import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RegexTest {
    public static void main(String[] args) {
        String s1 = "assert (= (strpos JSQ0_INSTRUCTOR_DEPT_NAME22 \"abc\") 1)";
        String s2 = "assert (O_CRSE[2].2 > 'ggegeg')";
        String s3 = "(JSQ0_frpms__ACADEMICYEAR1 (select O_JSQ0 i1 )) = '2025'";

        Pattern p = Pattern.compile("([a-zA-Z0-9]+_[a-zA-Z0-9_]+__?[a-zA-Z0-9_]+\\d+|[a-zA-Z0-9_]+\\[\\d+\\]\\.\\d+)");
        Matcher m1 = p.matcher(s1);
        if (m1.find()) System.out.println(m1.group(1));

        Matcher m2 = p.matcher(s2);
        if (m2.find()) System.out.println(m2.group(1));

        Matcher m3 = p.matcher(s3);
        if (m3.find()) System.out.println(m3.group(1));
    }
}
