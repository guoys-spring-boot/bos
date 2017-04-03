package cn.itcast.bos.service.impl;

import cn.itcast.bos.utils.UUIDUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.itcast.bos.dao.UserDAO;
import cn.itcast.bos.domain.User;
import cn.itcast.bos.service.UserService;
import cn.itcast.bos.utils.MD5Utils;

import java.util.List;

@Service("userService")
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDAO userDAO;

	public void saveUser(User user) {
		user.setPassword(MD5Utils.md5(user.getPassword()));
		user.setId(UUIDUtils.generatePrimaryKey());
		userDAO.insert(user);
	}

	public User findUserByLogin(User user) {
		user.setPassword(MD5Utils.md5(user.getPassword()));
		return userDAO.login(user);
	}

	public void updatePassword(User user) {
		user.setPassword(MD5Utils.md5(user.getPassword()));
		userDAO.updatePassword(user);
	}

	@Override
	public List<User> findAllUser() {
		return userDAO.findAll();
	}

	public String findPasswordByUsername(String username) {
		return userDAO.findPasswordByUsername(username);
	}

	public User findUserByUsername(String username) {
		return userDAO.findUserByUsername(username);
	}

    @Override
    public void deleteUser(String ids) {
        if(StringUtils.isNotBlank(ids)){
            userDAO.deleteByIds(ids.split(","));
        }
    }

    @Override
    public int totalUser() {
        return userDAO.findTotalCount();
    }
}
