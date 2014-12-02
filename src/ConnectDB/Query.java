package ConnectDB;

import java.lang.reflect.Array;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Query<T> {
	connectDB db;
	java.sql.Statement sqlStmt;

	public Query() {
		db = new connectDB();
	}



	public boolean check2(String[] name, String[] passwd) {
		PreparedStatement pstmt = null;
		try {
			String insert3 = "insert ignore into user (username,userpass) values (?,?)";
			db.conn = db.connect();
			pstmt = (PreparedStatement) db.conn.prepareStatement(insert3);

			for (int i = 0; i < name.length; i++) {
				pstmt.setString(1, name[i]);
				pstmt.setString(2, passwd[i]);
				pstmt.executeUpdate();
			}
			db.conn.close();
		} catch (Exception e) {
			e.printStackTrace(System.err);
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
					pstmt = null;
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

			}
		}
		return false;
	}

	public boolean insertName(String Name) {
		String CName = Name.trim();
		String insertN = "INSERT ignore INTO namemap (Name) VALUES ('"
				+ CName + "')";
		boolean r2 = db.executeVoid(insertN);
		if (r2) {
			return true;
		} else {
			return false;
		}

	}

	public boolean insertOrg(String Org) {
		String COrg=Org.trim();
		String insertO = "INSERT ignore INTO orgnizationmap (Orgnization) VALUES ('"
				+ COrg + "')";
		boolean r1 = db.executeVoid(insertO);
		if (r1) {
			return true;
		} else {
			return false;
		}

	}

	public boolean insertPaper(String Paper) {
		String CPaper=Paper.trim();
		String insertP = "INSERT ignore INTO papermap (Paper) VALUES ('"
				+ CPaper + "')";
		boolean r1 = db.executeVoid(insertP);
		if (r1) {
			return true;
		} else {
			return false;
		}

	}

	public boolean insertmember(String Name,String Org, int Roll, int conid, int year)
			throws SQLException {
		String Selectid = "SELECT N.Nid,O.Oid FROM namemap AS N,orgnizationmap AS O WHERE Name= '"
				+ Name + "' and Orgnization= '"	+ Org + "'";
		ResultSet r1 = null;

		if (insertName(Name) && insertOrg(Org)) {
			r1 = db.executeQuery(Selectid);
			if (r1.next()) {
				String InsertMen = "INSERT INTO member(Nameid,Orgid,Rollid,Confid,Year) VALUES ('"
						+ r1.getInt("N.Nid")
						+ "','"
						+ r1.getInt("O.Oid")
						+ "','"
						+ Roll
						+ "','"
						+ conid
						+ "','"
						+ year + "')";
				db.executeVoid(InsertMen);
				r1.close();

				return true;
			}
			r1.close();

			System.out.print("fail"+ Name+ Org);
			return false;
		}

		return false;

	}

	public boolean insertarticle(List<String> Name, String Paper,int conid, int year){
		insertPaper(Paper);
		PreparedStatement pstmt = null;
		String insertP = "INSERT INTO article(Nameid,Paperid,Confid,Year)  values (?,?,?,?)";
		String Selectid;
		ResultSet r1 = null;
		try {
		db.conn = db.connect();
		pstmt = (PreparedStatement) db.conn.prepareStatement(insertP);
		
		for (int i = 0; i < Name.size(); i++) {
			if (insertName(Name.get(i))){
				Selectid = "SELECT N.Nid,P.Pid FROM namemap AS N,papermap AS P WHERE N.Name= '"
						+ Name.get(i) + "' and P.Paper= '"	+ Paper + "'";
				r1 = db.executeQuery(Selectid);
				if (r1.next()) {
//					System.out.println(r1.getInt("N.Nid"));
//					System.out.println(r1.getInt("P.Pid"));
				pstmt.setInt(1, r1.getInt("N.Nid"));
				pstmt.setInt(2, r1.getInt("P.Pid"));
				pstmt.setInt(3, conid);
				pstmt.setInt(4, year);
				pstmt.executeUpdate();
				}
				
			}else{
				System.out.println(Paper + "false");
			}
			
		}
		r1.close();
		db.conn.close();
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if (pstmt != null) {
				try {
					System.out.println("success");
					pstmt.close();
					pstmt = null;
					return true;
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

			}
		}

		return false;

	}

  public ResultSet getfun1() throws SQLException{
	  ResultSet r1 = null;
	  String query = "select count(distinct(A.paperid)),OM.Orgnization from article AS A, member AS M, orgnizationmap AS OM where A.Nameid=M.Nameid and M.Orgid=OM.Oid and A.Year='2011' GROUP BY OM.Oid";
	  r1=db.executeQuery(query);

	return r1;
	  
  }
  
  public ResultSet getfun2() throws SQLException{
	  ResultSet r1 = null;
	  String query = "select count(A.Paperid),NM.Name from article AS A, member AS M, namemap AS NM where A.Nameid=M.Nameid and NM.Nid = A.Nameid   GROUP BY A.Nameid";
	  r1=db.executeQuery(query);

	return r1;
	  
  }
  
  public ResultSet getfun3() throws SQLException{
	  ResultSet r1 = null;
	  String query = "select count(distinct(A.paperid)),A.year from article AS A group by A.year";
	  r1=db.executeQuery(query);

	return r1;
	  
  }
  
  public ResultSet getfun4() throws SQLException{
	  ResultSet r1 = null;
	  String query = "select count(distinct(A.paperid)),OM.Orgnization,count(distinct(M2.Nameid)) from article AS A, member AS M, member AS M2, orgnizationmap AS OM where A.Nameid=M.Nameid and M.Orgid=OM.Oid and M2.Orgid=OM.Oid and A.Year='2011'and M2.Year='2011' GROUP BY OM.Oid";
	  r1=db.executeQuery(query);

	return r1;
	  
  }
  
	public ResultSet getRlt(String input){
		
		return db.executeQuery(input);		
	}

}

