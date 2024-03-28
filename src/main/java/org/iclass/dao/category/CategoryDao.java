package org.iclass.dao.category;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.iclass.mybatis.SqlSessionBean;
import org.iclass.vo.BG_CATEGORY;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CategoryDao {

	private static final Logger logger = LoggerFactory.getLogger(CategoryDao.class);
	private static CategoryDao dao = new CategoryDao();
	
	private CategoryDao() {}
	
	public static CategoryDao getInstance() {
		return dao;
	}
	
	public List<BG_CATEGORY> categoryList() {
		SqlSession sqlSession = SqlSessionBean.getSession();
		List<BG_CATEGORY> list = sqlSession.selectList("bg_category.categoryList");
		logger.info("categoryList :{}",list);
		sqlSession.close();
		return list;
	}
}
