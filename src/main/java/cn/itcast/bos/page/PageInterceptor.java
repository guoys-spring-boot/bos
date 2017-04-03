package cn.itcast.bos.page;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import org.apache.ibatis.executor.parameter.ParameterHandler;
import org.apache.ibatis.executor.statement.StatementHandler;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Plugin;
import org.apache.ibatis.plugin.Signature;
import org.apache.ibatis.reflection.DefaultReflectorFactory;
import org.apache.ibatis.reflection.MetaObject;
import org.apache.ibatis.reflection.factory.DefaultObjectFactory;
import org.apache.ibatis.reflection.wrapper.DefaultObjectWrapperFactory;
import org.apache.ibatis.scripting.defaults.DefaultParameterHandler;
import org.apache.ibatis.session.Configuration;
import org.apache.ibatis.session.RowBounds;

/**
 * 动态分页拦截器 直接使用
 * 
 * @author seawind
 * 
 */
@Intercepts({ @Signature(type = StatementHandler.class, method = "prepare", args = { Connection.class }) })
public class PageInterceptor implements Interceptor {

	/**
	 * 核心拦截
	 */
	public Object intercept(Invocation invocation) throws Throwable {
		// 获得拦截 目标对象
		StatementHandler statementHandler = (StatementHandler) invocation.getTarget();

		MetaObject metaStatementHandler = MetaObject.forObject(statementHandler, new DefaultObjectFactory(), new DefaultObjectWrapperFactory(), new DefaultReflectorFactory());
		MappedStatement mappedStatement = (MappedStatement) metaStatementHandler.getValue("delegate.mappedStatement");

		// 获取 sqlId
		String sqlId = mappedStatement.getId();// 对应mapper.xml <select> id
		// 获取sqlMapConfig 配置属性
		Configuration configuration = (Configuration) metaStatementHandler.getValue("delegate.configuration");
		String pageSqlId = configuration.getVariables().getProperty("pageSqlId"); // 对应 sqlMapConfig property

		if (sqlId.matches(pageSqlId)) {
			// 匹配拦截规则 ，执行拦截扩展SQL
			System.out.println("mybatis 拦截器 intercept ==============================");

			// 获取原来SQL
			BoundSql boundSql = (BoundSql) metaStatementHandler.getValue("delegate.boundSql");
			System.out.println("原来sql:" + boundSql.getSql());
			String sql = boundSql.getSql();

			// 获得DAO 方法参数
			// 分页参数作为参数对象parameterObject的一个属性
			PaginationInfo page = (PaginationInfo) metaStatementHandler.getValue("delegate.boundSql.parameterObject");

			// 获取sqlMapConfig 方言
			String dialect = configuration.getVariables().getProperty("dialect");
			if (dialect.equals("oracle")) {
				// oracle
				// 重写sql
				String pageSql = buildPageSqlForOracle(sql, page).toString();
				metaStatementHandler.setValue("delegate.boundSql.sql", pageSql);
				// 采用物理分页后，就不需要mybatis的内存分页了，所以重置下面的两个参数
				metaStatementHandler.setValue("delegate.rowBounds.offset", RowBounds.NO_ROW_OFFSET);
				metaStatementHandler.setValue("delegate.rowBounds.limit", RowBounds.NO_ROW_LIMIT);

			} else if (dialect.equals("mysql")) {
				// mysql
			}

			// 执行count(*)的sql语句
			Connection connection = (Connection) invocation.getArgs()[0];
			// 重设分页参数里的总页数等
			setPageParameter(sql, connection, mappedStatement, boundSql, page);
		}
		return invocation.proceed();
	}

	/**
	 * 查询 count * 参数 封装 PaginationInfo 对象
	 * 
	 * @param sql
	 * @param connection
	 * @param mappedStatement
	 * @param boundSql
	 * @param page
	 */
	private void setPageParameter(String sql, Connection connection, MappedStatement mappedStatement, BoundSql boundSql, PaginationInfo page) {
		// 记录总记录数
		String countSql = "select count(0) as total from (" + sql + ") ";
		PreparedStatement countStmt = null;
		ResultSet rs = null;
		try {
			countStmt = connection.prepareStatement(countSql);
			BoundSql countBS = new BoundSql(mappedStatement.getConfiguration(), countSql, boundSql.getParameterMappings(), boundSql.getParameterObject());

			// 设置其他参数
			ParameterHandler parameterHandler = new DefaultParameterHandler(mappedStatement, boundSql.getParameterObject(), boundSql);
			parameterHandler.setParameters(countStmt);

			rs = countStmt.executeQuery();
			int totalCount = 0;
			if (rs.next()) {
				totalCount = rs.getInt(1);
			}
			page.setTotal(totalCount);
		} catch (SQLException e) {

		} finally {
			try {
				rs.close();
			} catch (SQLException e) {
			}
			try {
				countStmt.close();
			} catch (SQLException e) {
			}
		}
	}

	public Object plugin(Object target) {
		// System.out.println("mybatis 拦截器 plugin ==============================");
		return Plugin.wrap(target, this);
	}

	public void setProperties(Properties properties) {

	}

	/**
	 * 参考hibernate的实现完成oracle的分页
	 * 
	 * @param sql
	 * @param page
	 * @return String
	 */
	public StringBuilder buildPageSqlForOracle(String sql, PaginationInfo page) {
		StringBuilder pageSql = new StringBuilder(100);
		String beginrow = String.valueOf((page.getPageno() - 1) * page.getPagesize());
		String endrow = String.valueOf(page.getPageno() * page.getPagesize());

		pageSql.append("select * from ( select temp.*, rownum row_id from ( ");
		pageSql.append(sql);
		pageSql.append(" ) temp where rownum <= ").append(endrow);
		pageSql.append(") where row_id > ").append(beginrow);
		return pageSql;
	}
}
