package testDataGen;

import net.sf.jsqlparser.parser.CCJSqlParserUtil;
import net.sf.jsqlparser.statement.Statement;
import net.sf.jsqlparser.statement.select.ParenthesedFromItem;
import net.sf.jsqlparser.statement.select.PlainSelect;
import net.sf.jsqlparser.statement.select.Select;
import net.sf.jsqlparser.expression.Expression;
import net.sf.jsqlparser.expression.Function;
import net.sf.jsqlparser.expression.operators.conditional.AndExpression;
import net.sf.jsqlparser.expression.operators.conditional.OrExpression;
import net.sf.jsqlparser.expression.operators.relational.EqualsTo;
import net.sf.jsqlparser.expression.operators.relational.ParenthesedExpressionList;
// import net.sf.jsqlparser.expression.Expression;

public class SubstrExtractorManual {
    public static void main(String[] args) throws Exception {
        String sql = "SELECT AVG(T2.cost) " +
                "FROM member AS T1 INNER JOIN expense AS T2 ON T1.member_id = T2.link_to_member " +
                "WHERE T1.last_name = 'Allen' AND T1.first_name = 'Elijah' " +
                "AND (SUBSTR(T2.expense_date, 6, 2) = '09' OR SUBSTR(T2.expense_date, 6, 2) = '10')";

        System.out.println("SQL Query: " + sql);

        Statement stmt = CCJSqlParserUtil.parse(sql);
        Select select = (Select) stmt;
        PlainSelect plainSelect = (PlainSelect) select.getSelectBody();
        Expression where = plainSelect.getWhere();

        System.out.println("Parsed WHERE: " + where);

        findSubstrs(where);
    }

    static void findSubstrs(Expression expr) {
        if (expr instanceof Function) {
            Function func = (Function) expr;
            if (func.getName().equalsIgnoreCase("SUBSTR")) {
                System.out.println("✅ Found SUBSTR: " + func);
            }
        } else if (expr instanceof AndExpression) {
            AndExpression and = (AndExpression) expr;
            findSubstrs(and.getLeftExpression());
            findSubstrs(and.getRightExpression());
        } else if (expr instanceof OrExpression) {
            OrExpression or = (OrExpression) expr;
            findSubstrs(or.getLeftExpression());
            findSubstrs(or.getRightExpression());
        } else if (expr instanceof EqualsTo) { 
            EqualsTo eq = (EqualsTo) expr;
            findSubstrs(eq.getLeftExpression());
            findSubstrs(eq.getRightExpression());
        } else if(expr instanceof ParenthesedExpressionList){
            ParenthesedExpressionList<Expression>pel= (ParenthesedExpressionList<Expression>) expr;
            for (Expression expression : pel.getExpressions()) 
                findSubstrs(expression); // Recursively check each expression in the list
        } 
    }
}
