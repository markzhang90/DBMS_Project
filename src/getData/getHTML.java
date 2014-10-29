package getData;


import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


public class getHTML {
	ConnectDB.Query qu = new ConnectDB.Query();

	public String getOneHtml(String htmlurl) throws IOException {
		URL url;
		String temp;
		StringBuffer sb = new StringBuffer();
		try {
			url = new URL(htmlurl);
			BufferedReader in = new BufferedReader(new InputStreamReader(
					url.openStream(), "gb2312"));
			while ((temp = in.readLine()) != null) {
				sb.append(temp + "\n");
			}
			in.close();
		} catch (MalformedURLException me) {
			System.out.println("your input URL  is wrong");
			me.getMessage();
			throw me;
		} catch (IOException e) {
			e.printStackTrace();
			throw e;
		}
		return sb.toString();
	}

	public void writeHTML(String Content, File fileName) {
		FileOperator f1 = new FileOperator();
		try {
			f1.writeTxtFile(Content, fileName);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	/* get paper 2014 2012 and 2011 */
	// 2014 2012
	public String[] getPaper1(String input,int confid, int year ) {
		String regEx1 = "<li>.*";
		String regEx2 = "<\\/?li><.*>?";
		String regEx3 = "<li>";

		StringBuffer rs = new StringBuffer();
		Pattern pat = Pattern.compile(regEx1);
		Matcher mat = pat.matcher(input);
		Pattern pat2;
		Matcher mat2;
		while (mat.find()) {
			pat2 = Pattern.compile(regEx2);
			mat2 = pat2.matcher(mat.group());
			if (!mat2.find()) {
				rs.append(mat.group());
			}

		}

		Pattern pat3 = Pattern.compile(regEx3);

		String[] results = pat3.split(rs.toString());
		// get name and paper
		String regEx_split = ":";
		String regEx_split2 = ", and |, | and ";
		Pattern pat_split = Pattern.compile(regEx_split);
		Pattern pat_split2 = Pattern.compile(regEx_split2);
		Matcher mat_split;
		String[] seperate = null;
		List<String> namegroup = new ArrayList<String>();
		StringBuffer Paper = new StringBuffer();
		for (int i = 1; i < results.length; i++) {
//			System.out.println(results[i]);//namelist
			seperate = pat_split.split(results[i]);
			namegroup = Arrays.asList(pat_split2.split(seperate[0]));
			Paper.append(seperate[1]);
			if (seperate.length > 2) {
				for (int j = 2; j < seperate.length; j++) {
					Paper.append(":" + seperate[j]);
				}			
			}
			//insert to db
			qu.insertarticle(namegroup,Paper.toString(),confid,year);
//			for(int d=0;d<namegroup.size();d++){
//				System.out.println(namegroup.get(d)+"---"+Paper.toString());
//			}
			Paper.setLength(0);
			
		}
		

		

		return results;
	}

	// 2011
	public String[] getPaper2(String input, int confid, int year) {
		String regEx1 = "<\\/?p>";
		String regEx2 = "<\\/?strong>";
		String regEx3 = "<br \\/>";
		String regEx_split = ";";
		String regEx_split2 = ", and |, | and ";
		Pattern pat = Pattern.compile(regEx1);
		String[] results = pat.split(input.toString());

		Pattern pat2 = Pattern.compile(regEx2);
		Pattern pat3 = Pattern.compile(regEx3);
		String[] results2 = pat2.split(results[1]);
		String[] results3;
		ArrayList<String> result_paper = new ArrayList<>();
		ArrayList<String> result_author = new ArrayList<>();
		List<String> namegroup = new ArrayList<String>();
		
		String Paper;
		String[] names;
		String[] names_nd;
		String[] Org;
		Pattern pat_split = Pattern.compile(regEx_split);
		Pattern pat_split2 = Pattern.compile(regEx_split2);
		for (int i = 1, j = 0; i < results2.length; i = i + 2, j++) {
//			result_paper.add(j, results2[i].trim());
			results3 = pat3.split(results2[i + 1]);
//			result_author.add(j, results3[1].trim());
			Paper = results2[i].trim();
			names = pat_split.split(results3[1].trim());
			for(int k =0; k<names.length;k++){
				names_nd = pat_split2.split(names[k]);
				namegroup.add(names_nd[0]);				
			}
			
			qu.insertarticle(namegroup,Paper,confid,year);
			/*System.out.println(results3[1]);//list
			for (int d = 0; d < namegroup.size(); d++) {			
				System.out.println(namegroup.get(d) + "---" +Paper);
			}*/
			namegroup.clear();
		}
		
		return results;
	}

	/* get Pc memeber 2014 2012 2011 */

	public void getPCmember(String input, int confid, int year) {
		String RegEx_br = "<br ?\\/>";
		String RegEx_chair = "<strong>Chair<\\/strong><br \\/> ";
		Pattern pat1 = Pattern.compile(RegEx_chair);
		String[] results1 = pat1.split(input);
		String RegEx_leader = "<strong>Group Leaders<\\/strong><br \\/> ";
		Pattern pat2 = Pattern.compile(RegEx_leader);
		String[] results2 = pat2.split(results1[1]);
		/* chair */
		String chair_long = CleanHtml(results2[0]);
		String[] chair = chair_long.split(RegEx_br);
		String RegEx_split = "\\(|\\)|,";
		Pattern patsplit = Pattern.compile(RegEx_split);
		String[] Split_chair;
		for (int i = 0; i < chair.length; i++) {
			Split_chair = patsplit.split(chair[i]);
			if (Split_chair.length >= 2) {
				try {
					qu.insertmember(Split_chair[0].trim(),
							Split_chair[1].trim(), 1, confid, year);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

			}
		}

		String RegEx_member = "<p><strong>Committee Members<\\/strong><br \\/>";
		String RegEx_member2 = "<p><strong>PC Members<\\/strong><br \\/>";
		String[] results3 = null;
		Pattern pat3 = Pattern.compile(RegEx_member);
		Pattern pat3_1 = Pattern.compile(RegEx_member2);
		Matcher mat = pat3.matcher(results2[1]);
		String[] results4 = null;
		Pattern pat4;
		if (mat.find()) {
			String RegEx_end = "<\\/p>";
			results3 = pat3.split(results2[1]);
			if (results3 != null) {
				pat4 = Pattern.compile(RegEx_end);
				results4 = pat4.split(results3[1]);
			}
		} else {
			String RegEx_end = "<\\/div>";
			results3 = pat3_1.split(results2[1]);
			if (results3 != null) {
				pat4 = Pattern.compile(RegEx_end);
				results4 = pat4.split(results3[1]);

			}
		}

		/* leader */
		String leader_long = CleanHtml(results3[0]);
		String[] leader = leader_long.split(RegEx_br);
		String[] Split_leader;
		for (int i = 0; i < leader.length; i++) {
			Split_leader = patsplit.split(leader[i]);
			if (Split_leader.length >= 2) {
				try {
					// System.out.println(Split_leader[0].trim()+" 111 "+
					// Split_leader[1].trim());
					qu.insertmember(Split_leader[0].trim(),
							Split_leader[1].trim(), 2, confid, year);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

			}
		}
		/* member */
		String member_long = results4[0].trim();
		member_long = CleanHtml(member_long);
		String[] member = member_long.split(RegEx_br);
		String[] Split_member;
		for (int i = 0; i < member.length; i++) {
			Split_member = patsplit.split(member[i]);
			if (Split_member.length >= 2) {
				try {
					qu.insertmember(Split_member[0].trim(),
							Split_member[1].trim(), 3, confid, year);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

			}
		}
		// System.out.println(member_long);
		// for (int i = 0; i < member.length; i++) {
		// System.out.println(i+"---"+member[i].trim());
		// }

	}

	public String CleanHtml(String str) {
		String RegEx = "(<!--.*)|<\\/?p>";
		Pattern pat = Pattern.compile(RegEx);
		Matcher mat = pat.matcher(str);
		String s = mat.replaceAll("").trim();
		return s;
	}

}