package cn.itcast.bos.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.itcast.bos.dao.FunctionDAO;
import cn.itcast.bos.domain.Function;
import cn.itcast.bos.domain.User;
import cn.itcast.bos.service.FunctionService;

@Service
public class FunctionServiceImpl implements FunctionService {

	@Autowired
	private FunctionDAO functionDAO;

	public List<Function> findMenu(String username) {
		// 隐含条件 generateMenu = 1 ， order by zindex
		User user = new User();
		user.setUsername(username);
		return functionDAO.findMenu(user);
	}

}
