public class test {
    public static void main(String[] args) {
        String constraint = "assert (= (strpos JSQ0_INSTRUCTOR_DEPT_NAME22 \"abc\") 1)";
        System.out.println(constraint.replaceAll(".*(JSQ\\d*_[A-Z_]+\\d+).*", "$1"));
    }
}
