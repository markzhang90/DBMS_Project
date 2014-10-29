package ConnectDB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class connectDB {

	/**
	 * @param args
	 */
	private String strSql;
	private String userName;
	private String pwd;

	Connection conn;

	public connectDB() {
		strSql = "jdbc:mysql://localhost/pubworld?useUnicode=true&characterEncoding=gb2312";
		userName = "root";
		pwd = "";
		conn = null;
	}

	public Connection connect() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(strSql, userName, pwd);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}

	public Statement sqlStmt() throws SQLException {
		return conn.createStatement(java.sql.ResultSet.TYPE_SCROLL_INSENSITIVE,
				java.sql.ResultSet.CONCUR_READ_ONLY);

	}

	
	public boolean executeVoid(String str) {

		conn = connect();
		try {

			Statement statement = conn.createStatement();

			statement.executeUpdate(str);
			statement.close();
			conn.close();
			return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	/**
	 * *execute the given SQL,return resultset
	 */
	public ResultSet executeQuery(String str) {

		conn = connect();

		ResultSet rs = null;
		try {
			Statement statement = conn.createStatement();
			rs = statement.executeQuery(str);

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}
}
