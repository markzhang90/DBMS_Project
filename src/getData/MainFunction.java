package getData;

import java.io.File;
import java.io.IOException;
import ConnectDB.Query;
public class MainFunction {
	public static void main(String[] argc) {
		getHTML getH = new getHTML();		
		String getBack = null;
		String URL1 = "http://www.sigmod2014.org/pods_list.shtml";
		String URL2 = "http://www.sigmod.org/2012/pods_list.shtml";
		String URL3 = "http://www.sigmod2011.org/research_list.shtml";
		String NURL1 = "http://www.sigmod2014.org/org_sigmod_pc.shtml";
		String NURL2 = "http://www.sigmod.org/2012/org_sigmod_pc.shtml";
		String NURL3 = "http://www.sigmod2011.org/org_sigmod_pc.shtml";
		File FileName = new File( "D://result.txt");
		try {
			getBack = getH.getOneHtml(URL1);
			//getH.writeHTML(getBack,FileName);
			System.out.println(getBack);			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//  into db paper 2014 2012
//		String[] results_paper = getH.getPaper1(getBack,1,2014);
		//2011
//		String[] results2_paper = getH.getPaper2(getBack,1,2011);

		/* download pc member into db  */
//		getH.getPCmember(getBack,1,2011);
		


	}

	
}
