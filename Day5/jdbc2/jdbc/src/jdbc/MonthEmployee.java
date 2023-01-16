package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Scanner;

public class MonthEmployee {
	
	ArrayList<String> getEmployees()
			throws ClassNotFoundException, SQLException{
		// 키보드 월 입력
		ArrayList<String> list = new ArrayList();
		Scanner key = new Scanner(System.in);
		System.out.println("제외할 월 : " );
		int inputmonth = key.nextInt();
		// sql

		
		String sql 
		="select substr(hire_date, 6, 2 ) 입사월, sum(salary) 급여총합"
			+ "		from employees\r\n"
			+ "		where date_format(hire_date, '%m') != ?"
			+ "		group by month(hire_date)"
			+ "		order by 입사월";
		//jdbc 전송 결과 
		Class.forName(ConnectionInform.DRIVER_CLASS);
		Connection con = DriverManager.getConnection
		(ConnectionInform.JDBC_URL, 
		ConnectionInform.USERNAME, ConnectionInform.PASSWORD);
		PreparedStatement pt = con.prepareStatement(sql);
		pt.setInt(1, inputmonth);
		ResultSet rs = pt.executeQuery();
		
		while(rs.next()) {
			int outputmonth = rs.getInt("입사월");
			double sum = rs.getDouble("급여총합");
			list.add(outputmonth+"\t"+sum);
		}
		rs.close();
		pt.close();
		con.close();
		return list;
	}
	
	public static void main(String[] args) {
		try {
		ArrayList<String> list = 
				new MonthEmployee().getEmployees();
		System.out.println("입사월\t급여총합");
		for(String o : list) {
			System.out.println(o);
		}
		}catch(Exception e) {
			e.printStackTrace();
		}
		/*  * 키보드로 입력 
	     * 
	     * 제외할 월 : 3
	     * 01-12 사이 값 입력시 월별 입사자 총급여 조회
	     * 입사월 급여총합
	     * 01   xxx
	     * 02   xxx
	     * 04   xxx
	     * ....
	     * 12   xxx
	     *  */
	}

}
