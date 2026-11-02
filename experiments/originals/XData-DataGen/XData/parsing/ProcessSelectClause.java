/** @author mathew
 * 
 */

package parsing;

import java.sql.Time;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.derby.iapi.types.Like;

import net.sf.jsqlparser.expression.Alias;
import net.sf.jsqlparser.expression.AllValue;
import net.sf.jsqlparser.expression.AnalyticExpression;

// import com.mysql.cj.x.protobuf.MysqlxCrud.Collection;
// import com.mysql.cj.x.protobuf.MysqlxDatatypes.Object;

// import net.sf.jsqlparser.expression.AliasWithArgs;
// import net.sf.jsqlparser.expression.Expression;

import net.sf.jsqlparser.expression.AnyComparisonExpression;
import net.sf.jsqlparser.expression.BinaryExpression;
import net.sf.jsqlparser.expression.CaseExpression;
import net.sf.jsqlparser.expression.CastExpression;
import net.sf.jsqlparser.expression.DateTimeLiteralExpression;
import net.sf.jsqlparser.expression.DateValue;
import net.sf.jsqlparser.expression.DoubleValue;
import net.sf.jsqlparser.expression.Expression;
import net.sf.jsqlparser.expression.ExtractExpression;
import net.sf.jsqlparser.expression.Function;
import net.sf.jsqlparser.expression.IntervalExpression;
import net.sf.jsqlparser.expression.JdbcNamedParameter;
import net.sf.jsqlparser.expression.JdbcParameter;
import net.sf.jsqlparser.expression.LongValue;
import net.sf.jsqlparser.expression.NotExpression;
import net.sf.jsqlparser.expression.Parenthesis;
import net.sf.jsqlparser.expression.SignedExpression;
import net.sf.jsqlparser.expression.StringValue;
import net.sf.jsqlparser.expression.TimeKeyExpression;
import net.sf.jsqlparser.expression.TimeValue;
import net.sf.jsqlparser.expression.TimestampValue;
import net.sf.jsqlparser.expression.TrimFunction;
import net.sf.jsqlparser.expression.WhenClause;
import net.sf.jsqlparser.expression.WindowDefinition;
import net.sf.jsqlparser.expression.operators.arithmetic.Addition;
import net.sf.jsqlparser.expression.operators.arithmetic.Division;
import net.sf.jsqlparser.expression.operators.arithmetic.Multiplication;
import net.sf.jsqlparser.expression.operators.arithmetic.Subtraction;
import net.sf.jsqlparser.expression.operators.conditional.AndExpression;
import net.sf.jsqlparser.expression.operators.conditional.OrExpression;
import net.sf.jsqlparser.expression.operators.relational.Between;
import net.sf.jsqlparser.expression.operators.relational.DoubleAnd;
import net.sf.jsqlparser.expression.operators.relational.EqualsTo;
import net.sf.jsqlparser.expression.operators.relational.ExistsExpression;
import net.sf.jsqlparser.expression.operators.relational.ExpressionList;
import net.sf.jsqlparser.expression.operators.relational.GreaterThan;
import net.sf.jsqlparser.expression.operators.relational.GreaterThanEquals;
import net.sf.jsqlparser.expression.operators.relational.InExpression;
import net.sf.jsqlparser.expression.operators.relational.IsBooleanExpression;
import net.sf.jsqlparser.expression.operators.relational.IsNullExpression;
import net.sf.jsqlparser.expression.operators.relational.LikeExpression;
import net.sf.jsqlparser.expression.operators.relational.RegExpMatchOperator;
import net.sf.jsqlparser.expression.operators.relational.RegExpMatchOperatorType;
import net.sf.jsqlparser.expression.operators.relational.MinorThan;
import net.sf.jsqlparser.expression.operators.relational.MinorThanEquals;
import net.sf.jsqlparser.expression.operators.relational.NotEqualsTo;
import net.sf.jsqlparser.expression.operators.relational.ParenthesedExpressionList;
import net.sf.jsqlparser.expression.operators.relational.GreaterThanEquals;
import net.sf.jsqlparser.parser.CCJSqlParserUtil;
import net.sf.jsqlparser.schema.Column;
import net.sf.jsqlparser.statement.create.table.ColDataType;
import net.sf.jsqlparser.statement.select.AllColumns;
import net.sf.jsqlparser.statement.select.FromItem;
import net.sf.jsqlparser.statement.select.Join;
import net.sf.jsqlparser.statement.select.OrderByElement;
import net.sf.jsqlparser.statement.select.ParenthesedFromItem;
// import net.sf.jsqlparser.statement.select.SubJoin;
import net.sf.jsqlparser.statement.select.ParenthesedSelect;
// import net.sf.jsqlparser.statement.select.ParenthesedFromItem;
import net.sf.jsqlparser.statement.select.PlainSelect;
import net.sf.jsqlparser.statement.select.Select;
// import net.sf.jsqlparser.statement.select.SelectItem;
import net.sf.jsqlparser.statement.select.SelectItem;
import oracle.net.aso.q;

public class ProcessSelectClause {
	private static Logger logger = Logger.getLogger(ProcessSelectClause.class.getName());

	/**
	 * @author mathew on 1st october 2016
	 * 
	 * 
	 * @param plainSelect
	 * @param debug
	 * @param qStruct
	 * @throws Exception
	 * 
	 *                   processes the plainSelect clause, calls the respective
	 *                   methods for processing its components/sub-clauses, which
	 *                   in turn stores the objects that represent the sub-clauses
	 *                   in the appropriate data structures in the
	 *                   qStruct object (3rd argument) .
	 * 
	 */

	public static void ProcessSelect(PlainSelect plainSelect, QueryStructure qStruct,
			AppTest_Parameters dbAppParameters) throws Exception {
		logger.log(Level.FINE, "processing select query" + plainSelect.toString());

		Vector<Node> joinConditions = new Vector<Node>();
		// Get the Node hierarchy
		// qStruct.topLevelRelation = generateRelationHierarchyJSQL(plainSelect);
		/*
		 * processes the from clause and extracts the join conditions, also the
		 * components such as tables,
		 * subqueries, and subjoins are stored in qStruct.fromListElements
		 */
		ProcessSelectClause.processFromClause(plainSelect, null, qStruct, joinConditions, dbAppParameters);
		for (Node n : joinConditions) {
			logger.log(Level.FINE, "joinCondition " + n);
		}

		if (plainSelect.getDistinct() != null) {
			qStruct.setIsDistinct(true);
		}
		if (plainSelect.getLimit() != null) {
			qStruct.setLimit(Integer.valueOf(plainSelect.getLimit().getRowCount().toString()));
		}

		/*
		 * processes the where clause and extracts the expression of nodes (stores an
		 * atomic condition),
		 * and stores it in qStruct.allConds
		 */
		ProcessSelectClause.processWhereClause(plainSelect, qStruct, dbAppParameters);

		if (!joinConditions.isEmpty()) {
			// if(!qStruct.allConds.isEmpty()) {
			Vector<Node> allCondsDups = (Vector<Node>) qStruct.allConds.clone();
			Node NewCond = new Node();
			NewCond.setType(Node.getAndNodeType());
			NewCond.setLeft(ProcessResultSetNode.getHierarchyOfJoinNode(joinConditions));
			if (qStruct.allConds.size() != 0)
				NewCond.setRight(qStruct.allConds.remove(0));
			qStruct.allConds.add(NewCond);
		}

		ProcessSelectClauseAbstract.modifyTreeForCompareSubQ(qStruct);

		/*
		 * takes the possibly complex expression of nodes stored in qStruct.allConds,
		 * splits it into atomic conditions,
		 * disjunct of atomic conditions, separates selection conditions, join
		 * conditions, is null conditions, subQuery conditions,
		 * like conditions etc., stores each conjunct in a disjunct in list
		 * qStruct.conjuncts
		 */
		QueryStructure.flattenAndSeparateAllConds(qStruct);

		for (ConjunctQueryStructure conjunct : qStruct.conjuncts)
			conjunct.createEqClass();

		// compute foreign keys from tableMap
		parsing.Util.foreignKeyClosure(qStruct);

		// now processes projection list, group by list, having conditions, and order by
		// list
		ProcessSelectClause.processProjectionList(plainSelect, qStruct, dbAppParameters); // making chages for rank
																							// query

		ProcessSelectClause.processGroupByList(plainSelect, qStruct, dbAppParameters);
		ProcessSelectClause.processHavingClause(plainSelect, qStruct, dbAppParameters);
		ProcessSelectClause.processOrderByList(plainSelect, qStruct, dbAppParameters);

		// initializes the populates the list structures (eg: lstSelectionConditions)
		// used by Canonicalization step subsequently
		qStruct.initializeQueryListStructures();
		for (Vector<Node> conds : qStruct.dnfCond) {
			Node composite = conds.firstElement();
			if (composite.getLeft() != null && composite.getLeft().getComponentNodes() != null
					&& composite.getLeft().getComponentNodes().size() > 1 && composite.getRight() != null
					&& composite.getRight().getComponentNodes() != null
					&& composite.getRight().getComponentNodes().size() > 1) {
				for (int i = 0; i < composite.getLeft().getComponentNodes().size(); i++) {
					Node n = new Node();
					n.setLeft(composite.getLeft().getComponentNodes().get(i));
					n.setRight(composite.getRight().getComponentNodes().get(i)); // null exception check if right side
																					// is also a list
					n.setOperator(composite.getOperator());
					if (!qStruct.getLstSelectionConditions().contains(n))
						qStruct.getLstSelectionConditions().add(n);
				}
			}
		}
		qStruct.reAdjustJoins();
	}

	/**
	 * method copied and adapted by mathew for query structure from
	 * parsing.Util.java
	 * 
	 * @param qStruct
	 */
	public static void modifyTreeForCompareSubQ(QueryStructure qStruct) {
		try {
			for (Node n : qStruct.allConds)
				Util.modifyTreeForComapreSubQ(n);
		} catch (Exception e) {
			logger.log(Level.SEVERE, "Error in modifyTreeForCompareSubQ : " + e.getMessage(), e);
		}
	}

	/**
	 * method copied and adapted by mathew for query structure from
	 * parsing.QueryParser.java
	 * 
	 * This method gets the case statements in where part of the query and adds it
	 * to query parser.
	 * Removes the where condition from the whereclause so that the where clause
	 * predicates are not generated
	 * for the same.
	 * 
	 * @param whereClause
	 * @param colExpression
	 * @param qStruct
	 * @return
	 * @throws Exception
	 */
	/**
	 * method copied and adapted by mathew for query structure from
	 * parsing.QueryParser.java
	 * 
	 * This method gets the case statements in where part of the query and adds it
	 * to query parser.
	 * Removes the where condition from the whereclause so that the where clause
	 * predicates are not generated
	 * for the same.
	 * 
	 * @param whereClause
	 * @param colExpression
	 * @param qStruct
	 * @return
	 * @throws Exception
	 */
	public static boolean caseInWhereClause(Expression whereClause, Expression colExpression, QueryStructure qStruct,
			PlainSelect plainSelect, AppTest_Parameters dbAppParameters) throws Exception {

		Vector<CaseCondition> caseConditionsVector = new Vector<CaseCondition>();
		boolean isCaseExpr = false;
		boolean isCaseExists = false;
		try {
			if (whereClause instanceof CaseExpression) {
				parsing.Column nodeColumnValue = null;
				List<WhenClause> whenClauses = ((CaseExpression) whereClause).getWhenClauses();
				for (int i = 0; i < whenClauses.size(); i++) {

					CaseCondition cC = new CaseCondition();
					Node n = processExpression(
							((WhenClause) ((CaseExpression) whereClause).getWhenClauses().get(i)).getWhenExpression(),
							qStruct.fromListElements, qStruct, plainSelect, null, dbAppParameters);
					qStruct.getCaseConditionMap().put(2, n.getCaseExpression());
					isCaseExists = true;
				}

				/*
				 * cC.setCaseConditionNode(n);
				 * cC.setCaseCondition(n.toString());
				 * cC.setConstantValue(((WhenClause)((CaseExpression)
				 * whereClause).getWhenClauses().get(i)).getThenExpression().toString());
				 * if(colExpression!= null && colExpression instanceof Column){
				 * Node n1 = ((processExpression((colExpression),
				 * qStruct.fromListElements,qStruct,plainSelect,null)));
				 * cC.setColValueForConjunct(UtilsRelatedToNode.getColumn(n1));
				 * nodeColumnValue = UtilsRelatedToNode.getColumn(n1);
				 * cC.setCaseOperator("=");
				 * }
				 * 
				 * caseConditionsVector.add(cC);
				 * 
				 * }
				 * isCaseExpr = true;
				 * //Add the else clause if present as the last item
				 * if(((CaseExpression) whereClause).getElseExpression() != null){
				 * CaseCondition cC = new CaseCondition();
				 * cC.setCaseConditionNode(n);
				 * cC.setCaseCondition("else");
				 * cC.setConstantValue(((CaseExpression)
				 * whereClause).getElseExpression().toString());
				 * if(colExpression != null && colExpression instanceof Column){
				 * Node n1 = ((processExpression((colExpression),
				 * qStruct.fromListElements,qStruct,plainSelect,null)));
				 * }
				 * 
				 * caseConditionsVector.add(cC);
				 * 
				 * }
				 */
				// Add Case conditions to queryparser

				return isCaseExists;
			} else if (whereClause instanceof BinaryExpression) {
				Expression binaryLeftExp = ((BinaryExpression) whereClause).getLeftExpression();
				Expression binaryRightExp = ((BinaryExpression) whereClause).getRightExpression();
				if (binaryLeftExp != null) {
					isCaseExists = caseInWhereClause(binaryLeftExp, binaryRightExp, qStruct, plainSelect,
							dbAppParameters);
					// If Case stmnt exists, rearrange Where clause to omit CASE condition
					if (isCaseExists) {
						((BinaryExpression) whereClause).setLeftExpression(null);
						((BinaryExpression) whereClause).setRightExpression(null);
					}
				}

				if (binaryRightExp != null) {
					isCaseExists = caseInWhereClause(binaryRightExp, binaryLeftExp, qStruct, plainSelect,
							dbAppParameters);
					// If Case stmnt exists, rearrange Where clause to omit CASE condition
					if (isCaseExists) {
						((BinaryExpression) whereClause).setLeftExpression(null);
						((BinaryExpression) whereClause).setRightExpression(null);
					}
				}
			} else if (whereClause instanceof Parenthesis) {
				Expression caseExpr = ((Parenthesis) whereClause).getExpression();

				if (caseExpr instanceof CaseExpression) {
					isCaseExists = caseInWhereClause(caseExpr, colExpression, qStruct, plainSelect, dbAppParameters);
					// If Case stmnt exists, rearrange Where clause to omit CASE condition
					if (isCaseExists) {
						((Parenthesis) whereClause).setExpression(null);
					}

				}
			}
			return isCaseExists;
		} catch (Exception e) {
			logger.log(Level.SEVERE, "Error in Processing case condition in where clause: " + e.getMessage(), e);
			throw e;
		}
	}
	// Modified for JSQL Exists - Start

	/**
	 * @author mathew
	 *         processes the where clause and extracts the expression of nodes
	 *         (stores an atomic condition),
	 *         and stores it in qStruct.allConds
	 */
	private static void processWhereClause(PlainSelect plainSelect, QueryStructure qStruct,
			AppTest_Parameters dbAppParameters) throws Exception {
		// TODO Auto-generated method stub

		Expression whereClauseExpression = plainSelect.getWhere();
		// Application Testing -- modified to consider database application constraints
		// on query result
		if (whereClauseExpression == null && (dbAppParameters == null
				|| (dbAppParameters != null && (dbAppParameters.getDbridge_Constraints() == null
						|| dbAppParameters.getDbridge_Constraints() == ""))))
			return;
		else if (whereClauseExpression == null
				&& (dbAppParameters != null && (dbAppParameters.getDbridge_Constraints() != null
						|| dbAppParameters.getDbridge_Constraints() != ""))) {
			whereClauseExpression = CCJSqlParserUtil.parseCondExpression(dbAppParameters.getDbridge_Constraints());
		} else if (whereClauseExpression != null && dbAppParameters != null
				&& dbAppParameters.getDbridge_Constraints() != "") {
			whereClauseExpression = CCJSqlParserUtil.parseCondExpression(
					whereClauseExpression.toString() + " AND " + dbAppParameters.getDbridge_Constraints());
		}

		caseInWhereClause(whereClauseExpression, null, qStruct, plainSelect, dbAppParameters);
		Node whereClause = ProcessSelectClause.processExpression(whereClauseExpression, qStruct.fromListElements,
				qStruct, plainSelect, null, dbAppParameters);
		logger.log(Level.FINE, " where clause " + whereClause);

		if (whereClause != null)
			qStruct.allConds.add(whereClause);
	}

	/**
	 * @author mathew
	 *         processes the having clause and extracts the expression of nodes
	 *         (stores an atomic condition),
	 *         and stores it in qStruct.havingClause
	 */

	private static void processHavingClause(PlainSelect plainSelect, QueryStructure qStruct,
			AppTest_Parameters dbAppParameters) throws Exception {
		// TODO Auto-generated method stub
		// get having clause
		Expression hc = plainSelect.getHaving();
		if (hc == null || hc.toString().isEmpty()) {
			qStruct.setHavingClause(null);
			return;
		}
		Node havingClause = ProcessSelectClause.processExpression(hc, qStruct.fromListElements, qStruct, plainSelect,
				null, dbAppParameters);
		qStruct.setHavingClause(havingClause);
		logger.log(Level.FINE, hc + " having clause " + havingClause);
	}

	/**
	 * @author mathew on 4th october 2016
	 * 
	 * 
	 * @param plainSelect
	 * @param qStruct
	 * @throws Exception
	 * 
	 *                   processes the group by list of plainSelect, and stores the
	 *                   elements as column nodes in groupByNodes list in
	 *                   qStruct object (2nd argument) . If the order by element is
	 *                   an alias or an unqualified column, it resolves the
	 *                   table name and column name of the element.
	 * 
	 */

	private static void processGroupByList(PlainSelect plainSelect, QueryStructure qStruct,
			AppTest_Parameters dbAppParameters) throws Exception {
		// TODO Auto-generated method stub
		if (plainSelect.getGroupBy() == null || plainSelect.getGroupBy().getGroupByExpressionList() == null
				|| plainSelect.getGroupBy().getGroupByExpressionList().isEmpty())
			return;

		List<Expression> gbl = plainSelect.getGroupBy().getGroupByExpressionList();
		for (int i = 0; i < gbl.size(); i++) {
			Column gbc;
			Expression groupExpression = gbl.get(i);

			if (groupExpression instanceof Column) {
				gbc = (Column) groupExpression;
			} else {
				continue;
			}

			Node groupByColumn = processExpression(groupExpression, qStruct.fromListElements, qStruct, plainSelect,
					null, dbAppParameters);
			if (groupByColumn.getTableNameNo() == null || groupByColumn.getTableNameNo().isEmpty()) {
				for (Node n : parsing.Util.getAllProjectedColumns(qStruct.fromListElements, qStruct)) {
					if (groupByColumn.getColumn() != null && n.getColumn() != null && n.getColumn().getColumnName()
							.equalsIgnoreCase(groupByColumn.getColumn().getColumnName())) {
						groupByColumn.setTable(n.getTable());
						groupByColumn.setTableNameNo(n.getTableNameNo());
						break;
					} else if (groupByColumn.getColumn() != null && n.getType().equals(Node.getValType())
							&& n.getAliasName().equals(groupByColumn.getColumn().getColumnName())) {
						groupByColumn = new Node(n);
						break;
					} else if (groupByColumn.getColumn() != null && n.getType().equals(Node.getCaseNodeType())
							&& n.getAliasName().equals(groupByColumn.getColumn().getColumnName())) {
						groupByColumn = new Node(n);
						break;
					} else if (groupByColumn.getColumn() != null && n.getType().equals(Node.getExtractFuncType())
							&& n.getAliasName().equals(groupByColumn.getColumn().getColumnName())) {
						groupByColumn = new Node(n);
						break;
					}
				}
			}
			if (groupByColumn.getType().equals(Node.getValType())) {
				qStruct.groupByNodes.addElement(groupByColumn);
				logger.log(Level.FINE, groupExpression.toString() + " group by column " + groupByColumn);
				continue;
			} else if (groupByColumn.getType().equals(Node.getCaseNodeType())) {
				qStruct.groupByNodes.addElement(groupByColumn);
				logger.log(Level.FINE, groupExpression.toString() + " group by column " + groupByColumn);
				continue;
			} else if (groupByColumn.getType().equals(Node.getExtractFuncType())) {
				qStruct.groupByNodes.addElement(groupByColumn);
				logger.log(Level.FINE, groupExpression.toString() + " group by column " + groupByColumn);
				continue;
			} else if (groupByColumn.getTableNameNo() == null || groupByColumn.getTableNameNo().isEmpty()) {
				List<SelectItem<?>> projectedItems = plainSelect.getSelectItems();
				for (int j = 0; j < projectedItems.size(); j++) {
					SelectItem projectedItem = projectedItems.get(j);
					if (projectedItem instanceof net.sf.jsqlparser.statement.select.SelectItem) {
						SelectItem selExpItem = (net.sf.jsqlparser.statement.select.SelectItem) projectedItem;
						Expression e = selExpItem.getExpression();
						if (e instanceof net.sf.jsqlparser.expression.Parenthesis) {
							net.sf.jsqlparser.expression.Parenthesis p = (net.sf.jsqlparser.expression.Parenthesis) e;
							e = p.getExpression();
						}
						if (selExpItem.getAlias() != null) {
							if (groupByColumn.getColumn().getColumnName()
									.equalsIgnoreCase(selExpItem.getAlias().getName())) {
								groupByColumn = processExpression(e, qStruct.fromListElements, qStruct, plainSelect,
										null, dbAppParameters);
								logger.log(Level.FINE,
										groupByColumn + " alias name resolved " + selExpItem.getAlias().getName());
								break;
							}
						}
					}
				}

			}
			qStruct.groupByNodes.addElement(groupByColumn);
			logger.log(Level.FINE, groupExpression.toString() + " group by column " + groupByColumn);

		}

	}

	/**
	 * @author mathew on 1st october 2016
	 * 
	 * 
	 * @param plainSelect
	 * @param qStruct
	 * @throws Exception
	 * 
	 *                   processes the order by list of plainSelect, and stores the
	 *                   elements as column nodes in orderByElements list in
	 *                   qStruct object (2nd argument) . If the order by element is
	 *                   an alias or an unqualified column, it resolves the
	 *                   table name and column name of the element.
	 * 
	 */
	private static void processOrderByList(PlainSelect plainSelect, QueryStructure qStruct,
			AppTest_Parameters dbAppParameters) throws Exception {
		if (plainSelect.getOrderByElements() == null || plainSelect.getOrderByElements().isEmpty())
			return;

		List<OrderByElement> obl = plainSelect.getOrderByElements();
		for (int i = 0; i < obl.size(); i++) {
			Column obc;
			Expression orderExpression = obl.get(i).getExpression();

			if (orderExpression instanceof Column) {
				obc = (Column) orderExpression;
			} else {
				continue;
			}

			Node orderByColumn = processExpression(orderExpression, qStruct.fromListElements, qStruct, plainSelect,
					null, dbAppParameters);
			if (orderByColumn.getTableNameNo() == null || orderByColumn.getTableNameNo().isEmpty()) {
				for (Node n : parsing.Util.getAllProjectedColumns(qStruct.fromListElements, qStruct)) {
					if (n.getColumn().getColumnName().equalsIgnoreCase(orderByColumn.getColumn().getColumnName())) {
						orderByColumn.setTable(n.getTable());
						orderByColumn.setTableNameNo(n.getTableNameNo());
						break;
					}
				}
			}
			if (orderByColumn.getTableNameNo() == null || orderByColumn.getTableNameNo().isEmpty()) {
				List<SelectItem<?>> projectedItems = plainSelect.getSelectItems();
				for (int j = 0; j < projectedItems.size(); j++) {
					SelectItem projectedItem = projectedItems.get(j);
					if (projectedItem instanceof net.sf.jsqlparser.statement.select.SelectItem) {
						SelectItem selExpItem = (net.sf.jsqlparser.statement.select.SelectItem) projectedItem;
						Expression e = selExpItem.getExpression();
						if (e instanceof net.sf.jsqlparser.expression.Parenthesis) {
							net.sf.jsqlparser.expression.Parenthesis p = (net.sf.jsqlparser.expression.Parenthesis) e;
							e = p.getExpression();
						}
						if (selExpItem.getAlias() != null) {
							if (orderByColumn.getColumn().getColumnName()
									.equalsIgnoreCase(selExpItem.getAlias().getName())) {
								orderByColumn = processExpression(e, qStruct.fromListElements, qStruct, plainSelect,
										null, dbAppParameters);
								logger.log(Level.FINE,
										orderByColumn + " alias name resolved " + selExpItem.getAlias().getName());
								break;
							}
						}
					}
				}

			}
			orderByColumn.orderByDirAsc = obl.get(i).isAsc();
			qStruct.orderByNodes.addElement(orderByColumn);
			logger.log(Level.FINE, orderExpression.toString() + " order by column " + orderByColumn);
		}

	}

	/**
	 * @author mathew on 3rd October 2016
	 * 
	 * @param plainSelect
	 * @param qStruct
	 * @param joinConditions
	 * @throws Exception
	 * 
	 *                   Processes the From Clause of the first argument,
	 *                   plainSelect. From list elements in the from clause are
	 *                   extracted and stored
	 *                   respecting their hierarchy/nestedness in the
	 *                   fromListElements list in the qStruct object (2nd argument),
	 *                   also the join conditions involved are
	 *                   extracted and stored in the 3rd argument, joinConditions
	 * 
	 */
	private static void processFromClause(PlainSelect plainSelect, ParenthesedFromItem parenthesedFromItem,
			QueryStructure qStruct, Vector<Node> joinConditions,
			AppTest_Parameters dbAppParameters) throws Exception {
		FromItem firstFromItem = null;
		if (plainSelect != null)
			firstFromItem = plainSelect.getFromItem();
		else if (parenthesedFromItem != null)
			firstFromItem = parenthesedFromItem.getFromItem();

		FromClauseElement leftFLE = null, rightFLE = null;

		if (firstFromItem instanceof net.sf.jsqlparser.schema.Table) {
			net.sf.jsqlparser.schema.Table jsqlTable = (net.sf.jsqlparser.schema.Table) firstFromItem;
			leftFLE = new FromClauseElement();
			ProcessSelectClause.processFromListTable(jsqlTable, leftFLE, qStruct);
			qStruct.fromListElements.addElement(leftFLE);
		} else if (firstFromItem instanceof ParenthesedSelect) {
			ParenthesedSelect ParenthesedSelect = (ParenthesedSelect) firstFromItem;

			QueryStructure subQueryParser = new QueryStructure(qStruct.getTableMap());
			leftFLE = new FromClauseElement();
			leftFLE.setSubQueryStructure(subQueryParser);
			if (ParenthesedSelect.getAlias() != null) {
				leftFLE.setAliasName(ParenthesedSelect.getAlias().getName());
				leftFLE.setTableNameNo(ParenthesedSelect.getAlias().getName());
			}
			qStruct.fromListElements.addElement(leftFLE);
			ProcessSelectClause.processFromListParenthesedSelect(ParenthesedSelect, subQueryParser, qStruct,
					dbAppParameters);
			/*
			 * The following if block enables resolvement of subquery aliases with
			 * projection list arguments.
			 * eg: (Select col1, col2, .. from ... ) as subQAlias( alias1, alias2, ..).
			 * While the complex alias
			 * is processed, the arugment aliasi is set as the alias name for the
			 * corresponding projected column coli
			 */
			if (ParenthesedSelect.getAlias() != null && (ParenthesedSelect.getAlias() instanceof Alias)) {
				Alias aliasWithArgs = (Alias) ParenthesedSelect.getAlias();
				List<Alias.AliasColumn> aliasNames = aliasWithArgs.getAliasColumns();

				if (aliasNames != null && aliasNames.size() > 0) {
					Vector<Node> subQueryProjColumns = subQueryParser.getProjectedCols();
					if (aliasNames.size() != subQueryProjColumns.size()) {
						logger.log(Level.WARNING,
								" Number of Aliass' Arguments does not match the number of subquery projected columns, "
										+ "exception thrown, query: " + plainSelect.toString());
						throw new Exception(
								" Number of Alias Arguments does not match the number of subquery projected columns"
										+ ", exception thrown");
					} else {
						for (int i = 0; i < aliasNames.size(); i++) {
							Alias.AliasColumn alName = aliasNames.get(i);
							String alNameStr = alName.name;
							subQueryProjColumns.get(i).setAliasName(alNameStr);
						}
					}
				}
			}

		} else if (firstFromItem instanceof Select) {
			Select subJoin = (Select) firstFromItem;
			Join join = subJoin.getPlainSelect().getJoin(0);
			Vector<FromClauseElement> tempElements = new Vector<FromClauseElement>();
			ProcessSelectClause.processFromListSubJoin(subJoin, tempElements, joinConditions, qStruct, plainSelect,
					dbAppParameters);
			leftFLE = new FromClauseElement();
			if (subJoin.getPlainSelect().getFromItem().getAlias() != null) {
				leftFLE.setAliasName(subJoin.getPlainSelect().getFromItem().getAlias().getName());
			}
			leftFLE.setBag(tempElements);
			qStruct.fromListElements.addElement(leftFLE);
		} else if (firstFromItem instanceof ParenthesedFromItem) {
			int sizeBefore = qStruct.fromListElements.size();
			ProcessSelectClause.processFromClause(null, (ParenthesedFromItem) firstFromItem, qStruct, joinConditions,
					dbAppParameters);
			leftFLE = new FromClauseElement();
			Vector<FromClauseElement> bag = new Vector<>();
			for (int i = sizeBefore; i < qStruct.fromListElements.size(); i++) {
				bag.add(qStruct.fromListElements.get(i));
			}
			leftFLE.setBag(bag);
		}

		if ((plainSelect != null && plainSelect.getJoins() != null && !plainSelect.getJoins().isEmpty())
				|| (parenthesedFromItem != null && parenthesedFromItem.getJoins() != null
						&& !parenthesedFromItem.getJoins().isEmpty())) {
			Vector<FromClauseElement> leftFLEVectorForNaturalJoin = new Vector<FromClauseElement>();
 			List<Join> joins = plainSelect != null ? plainSelect.getJoins() : parenthesedFromItem.getJoins();
			for (Join join : joins) {

				FromItem fromItem = join.getRightItem();
				if (fromItem instanceof net.sf.jsqlparser.schema.Table) {
					net.sf.jsqlparser.schema.Table jsqlTable = (net.sf.jsqlparser.schema.Table) fromItem;
					rightFLE = new FromClauseElement();
					processFromListTable(jsqlTable, rightFLE, qStruct);
					qStruct.fromListElements.addElement(rightFLE);
				} else if (fromItem instanceof ParenthesedSelect) {
					ParenthesedSelect ParenthesedSelect = (ParenthesedSelect) fromItem;
					QueryStructure subQueryParser = new QueryStructure(qStruct.getTableMap());
					rightFLE = new FromClauseElement();
					rightFLE.setSubQueryStructure(subQueryParser);
					if (ParenthesedSelect.getAlias() != null) {
						rightFLE.setAliasName(ParenthesedSelect.getAlias().getName());
						rightFLE.setTableNameNo(ParenthesedSelect.getAlias().getName());
					}
					qStruct.fromListElements.addElement(rightFLE);

					processFromListParenthesedSelect(ParenthesedSelect, subQueryParser, qStruct, dbAppParameters);

				} else if (fromItem instanceof Select) {
					Select subJoin = (Select) fromItem;
					Vector<FromClauseElement> tempElements = new Vector<FromClauseElement>();
					ProcessSelectClause.processFromListSubJoin(subJoin, tempElements, joinConditions, qStruct,
							plainSelect, dbAppParameters);
					rightFLE = new FromClauseElement();
					if (subJoin.getPlainSelect().getFromItem().getAlias() != null) {
						rightFLE.setAliasName(subJoin.getPlainSelect().getFromItem().getAlias().getName());
					}
					rightFLE.setBag(tempElements);
					qStruct.fromListElements.addElement(rightFLE);

				} else if (fromItem instanceof ParenthesedFromItem) {
					ProcessSelectClause.processFromClause(null, (ParenthesedFromItem) fromItem, qStruct, joinConditions,
							dbAppParameters);
				}
				if(join.isSimple()){
					qStruct.getQuery().JoinClauseTypes.add(JoinClauseInfo.crossJoin);
					qStruct.getQuery().joinInfo.add(new JoinClauseInfo(leftFLE.getAliasName(), rightFLE.getAliasName(), JoinClauseInfo.crossJoin));
				}
				Iterator<Expression> ite = join.getOnExpressions().iterator();

				Expression expressions = null;
				while (ite.hasNext()) {
					expressions = ite.next();
					List<Expression> exp = new ArrayList<Expression>();

					if (expressions instanceof ParenthesedExpressionList) {
						ParenthesedExpressionList parenthesizedExpressionList = (ParenthesedExpressionList) expressions;
						// Process expressions
						for (int j = 0; j < parenthesizedExpressionList.size(); j++) {
							exp.add((Expression) parenthesizedExpressionList.get(j));
						}
					}
					Expression e = join.getOnExpression();
					if (exp.size() > 0)
						e = exp.get(0);

					if (e != null) {/* Handling joins with ON Conditions */
						Node joinCondition = null;
						if (join.isLeft()){
							joinCondition = ProcessSelectClause.processExpression(e, qStruct.fromListElements, qStruct,
									plainSelect, JoinClauseInfo.leftOuterJoin, dbAppParameters);
							qStruct.getQuery().joinInfo.add(new JoinClauseInfo(leftFLE.getAliasName(), rightFLE.getAliasName(), JoinClauseInfo.leftOuterJoin));
							qStruct.getQuery().JoinClauseTypes.add(JoinClauseInfo.leftOuterJoin);
						}
						else if (join.isRight()){
							joinCondition = ProcessSelectClause.processExpression(e, qStruct.fromListElements, qStruct,
									plainSelect, JoinClauseInfo.rightOuterJoin, dbAppParameters);
							qStruct.getQuery().joinInfo.add(new JoinClauseInfo(leftFLE.getAliasName(), rightFLE.getAliasName(), JoinClauseInfo.rightOuterJoin));
							qStruct.getQuery().JoinClauseTypes.add(JoinClauseInfo.rightOuterJoin);	
						}
						else if (join.isFull() || join.isOuter()){
							joinCondition = ProcessSelectClause.processExpression(e, qStruct.fromListElements, qStruct,
									plainSelect, JoinClauseInfo.fullOuterJoin, dbAppParameters);
							qStruct.getQuery().joinInfo.add(new JoinClauseInfo(leftFLE.getAliasName(), rightFLE.getAliasName(), JoinClauseInfo.fullOuterJoin));
							qStruct.getQuery().JoinClauseTypes.add(JoinClauseInfo.fullOuterJoin);	
						}
						else{
							joinCondition = ProcessSelectClause.processExpression(e, qStruct.fromListElements, qStruct,
									plainSelect, JoinClauseInfo.innerJoin, dbAppParameters);
							qStruct.getQuery().JoinClauseTypes.add(JoinClauseInfo.innerJoin);	
							}

						joinConditions.add(joinCondition);
					}

				}
				if (join.getUsingColumns() != null && !join.getUsingColumns().isEmpty()) {/*
																							 * Handling
																							 * joins
																							 * with using
																							 * Conditions
																							 */
					Vector<FromClauseElement> leftFLEVector = new Vector<FromClauseElement>();
					leftFLEVector.add(leftFLE);
					Vector<FromClauseElement> rightFLEVector = new Vector<FromClauseElement>();
					rightFLEVector.add(rightFLE);
					Vector<Node> leftColumns = parsing.Util.getAllProjectedColumns(leftFLEVector, qStruct);
					Vector<Node> rightColumns = parsing.Util.getAllProjectedColumns(rightFLEVector, qStruct);
					for (Column column : join.getUsingColumns()) {
						Node matchedLeftColumn = null;
						for (Node leftColumn : leftColumns) {
							if (leftColumn.getColumn().getColumnName().equalsIgnoreCase(column.getColumnName())) {
								matchedLeftColumn = leftColumn;
								break;
							}
						}
						Node matchedRightColumn = null;
						for (Node rightColumn : rightColumns) {
							if (rightColumn.getColumn().getColumnName().equalsIgnoreCase(column.getColumnName())) {
								matchedRightColumn = rightColumn;
								break;
							}
						}
						if (matchedLeftColumn != null && matchedRightColumn != null) {
							Node equiJoinNode = new Node();
							equiJoinNode.setType(Node.getBroNodeType());
							equiJoinNode.setOperator(QueryStructure.cvcRelationalOperators[1]);
							equiJoinNode.setLeft(matchedLeftColumn);
							equiJoinNode.setRight(matchedRightColumn);
							if (join.isLeft()){
								equiJoinNode.setJoinType(JoinClauseInfo.leftOuterJoin);
								qStruct.getQuery().joinInfo.add(new JoinClauseInfo(leftFLE.getAliasName(), rightFLE.getAliasName(), JoinClauseInfo.leftOuterJoin));
								qStruct.getQuery().JoinClauseTypes.add(JoinClauseInfo.leftOuterJoin);
								
							}
							else if (join.isRight()){
								equiJoinNode.setJoinType(JoinClauseInfo.rightOuterJoin);
								qStruct.getQuery().joinInfo.add(new JoinClauseInfo(leftFLE.getAliasName(), rightFLE.getAliasName(), JoinClauseInfo.rightOuterJoin));
								qStruct.getQuery().JoinClauseTypes.add(JoinClauseInfo.rightOuterJoin);
							}
							else if (join.isFull()){
								equiJoinNode.setJoinType(JoinClauseInfo.fullOuterJoin);
								qStruct.getQuery().joinInfo.add(new JoinClauseInfo(leftFLE.getAliasName(), rightFLE.getAliasName(), JoinClauseInfo.rightOuterJoin));
								qStruct.getQuery().JoinClauseTypes.add(JoinClauseInfo.fullOuterJoin);
							}
							else{
								equiJoinNode.setJoinType(JoinClauseInfo.innerJoin);
								qStruct.getQuery().joinInfo.add(new JoinClauseInfo(leftFLE.getAliasName(), rightFLE.getAliasName(), JoinClauseInfo.innerJoin));
								qStruct.getQuery().JoinClauseTypes.add(JoinClauseInfo.innerJoin);
							}
							joinConditions.add(equiJoinNode);
							logger.log(Level.FINE,
									" join condition added for join with using condition: " + equiJoinNode);
						}
					}
				} else if (join.isNatural()) {/* Handling natural joins */
					leftFLEVectorForNaturalJoin.add(leftFLE);
					Vector<FromClauseElement> rightFLEVector = new Vector<FromClauseElement>();
					rightFLEVector.add(rightFLE);
					Vector<Node> leftColumns = parsing.Util.getAllProjectedColumns(leftFLEVectorForNaturalJoin,
							qStruct);
					Vector<Node> rightColumns = parsing.Util.getAllProjectedColumns(rightFLEVector, qStruct);
					for (Node leftColumn : leftColumns) {

						for (Node rightColumn : rightColumns) {
							if (leftColumn.getColumn().getColumnName().contains("XDATA_CNT")
									|| rightColumn.getColumn().getColumnName().contains("XDATA_CNT"))
								continue;
							if (leftColumn.getColumn().getColumnName()
									.equals(rightColumn.getColumn().getColumnName())) {
								Node equiJoinNode = new Node();
								equiJoinNode.setType(Node.getBroNodeType());
								equiJoinNode.setOperator(QueryStructure.cvcRelationalOperators[1]);
								equiJoinNode.setLeft(leftColumn);
								equiJoinNode.setRight(rightColumn);
								if (join.isLeft()){
									equiJoinNode.setJoinType(JoinClauseInfo.leftOuterJoin);
									qStruct.getQuery().joinInfo.add(new JoinClauseInfo(leftFLE.getAliasName(), rightFLE.getAliasName(), JoinClauseInfo.leftOuterJoin));
									qStruct.getQuery().JoinClauseTypes.add(JoinClauseInfo.leftOuterJoin);
								}
								else if (join.isRight()){
									equiJoinNode.setJoinType(JoinClauseInfo.rightOuterJoin);
									qStruct.getQuery().joinInfo.add(new JoinClauseInfo(leftFLE.getAliasName(), rightFLE.getAliasName(), JoinClauseInfo.rightOuterJoin));
									qStruct.getQuery().JoinClauseTypes.add(JoinClauseInfo.rightOuterJoin);
								}
								else if (join.isFull()){
									equiJoinNode.setJoinType(JoinClauseInfo.fullOuterJoin);
									qStruct.getQuery().joinInfo.add(new JoinClauseInfo(leftFLE.getAliasName(), rightFLE.getAliasName(), JoinClauseInfo.fullOuterJoin));
									qStruct.getQuery().JoinClauseTypes.add(JoinClauseInfo.fullOuterJoin);
								}
								else{
									equiJoinNode.setJoinType(JoinClauseInfo.innerJoin);
									qStruct.getQuery().joinInfo.add(new JoinClauseInfo(leftFLE.getAliasName(), rightFLE.getAliasName(), JoinClauseInfo.innerJoin));
									qStruct.getQuery().JoinClauseTypes.add(JoinClauseInfo.innerJoin);
								}

								joinConditions.add(equiJoinNode);
								logger.log(Level.FINE, " join condition added for natural join: " + equiJoinNode);
							}
						}
					}
				}
				leftFLE = rightFLE;// reset leftFLE to the previously visited FLE
			}
		}
	}

	/**
	 * @author mathew on 1st october 2016
	 * 
	 * 
	 * @param plainSelect
	 * @param qStruct
	 * @throws Exception
	 * 
	 *                   processes the projection list of plainSelect, for each
	 *                   element of the project list checks for the various
	 *                   possibilities -
	 *                   column expression , or an all column object. In case of the
	 *                   former, check if there is a case expression is present,
	 *                   in which case the parser's case condition map is updated
	 *                   with the respective objects from the case condition
	 * 
	 */

	// chaitra set projection column for case
	public static parsing.Column setCaseProjectionColumn(Node caseNode) {
		if (caseNode == null) {
			return null;
		}
		if (caseNode.getType().equalsIgnoreCase("BRO NODE")) {
			return caseNode.getLeft().getColumn();
		}

		return setCaseProjectionColumn(caseNode.getLeft());

	}
	// chaitra set projection column for case end

	private static Node buildCastNode(CastExpression exp, Vector<FromClauseElement> fle, QueryStructure qStruct,
			PlainSelect plainSelect, String joinType, AppTest_Parameters dbAppParameters) throws Exception {
		Expression left = exp.getLeftExpression();
		ColDataType type = exp.getColDataType();
		Node innerNode = processExpression(left, fle, qStruct, plainSelect, joinType, dbAppParameters);
		Node castNode = new Node();
		castNode.setLeft(innerNode);
		castNode.setCastType(type);
		castNode.setType(Node.getCastNodeType());
		castNode.setCastExpression(new parsing.CastExpression(left, type, exp.isUseCastKeyword()));
		return castNode;
	}

	private static void processProjectionList(PlainSelect plainSelect, QueryStructure qStruct,
			AppTest_Parameters dbAppParameters) throws Exception {
		// TODO Auto-generated method stub
		List<SelectItem<?>> projectedItems = plainSelect.getSelectItems();
		for (int i = 0; i < projectedItems.size(); i++) {
			SelectItem projectedItem = projectedItems.get(i);
			// the case where projected column is described by * in plainSelect
			if (projectedItem.getExpression() instanceof AllColumns) {
				for (Node n : parsing.Util.getAllProjectedColumns(qStruct.fromListElements, qStruct)) {
					logger.log(Level.FINE, " all column, select all columns... " + n);
					qStruct.projectedCols.add(n);
				}
			}

			// the case where set of columns are explicitly specified in plainSelect
			else if (projectedItem instanceof net.sf.jsqlparser.statement.select.SelectItem ||
					projectedItem.getExpression() instanceof AnalyticExpression) {

				SelectItem selExpItem = (net.sf.jsqlparser.statement.select.SelectItem) projectedItem;
				Expression e = selExpItem.getExpression();
				if (selExpItem.getAlias() != null) {
					logger.log(Level.FINE, " alias present " + selExpItem.getAlias().getName());
				}
				// deals with the case when projected column is bounded by a pair of braces
				if (e instanceof net.sf.jsqlparser.expression.Parenthesis) {
					net.sf.jsqlparser.expression.Parenthesis p = (net.sf.jsqlparser.expression.Parenthesis) e;
					Expression exp = p.getExpression();
					if (exp instanceof net.sf.jsqlparser.expression.CaseExpression)
						e = exp;
				}
				// deals with the cast expression
				if (e instanceof net.sf.jsqlparser.expression.CastExpression) {
					CastExpression exp = (CastExpression) e;
					Node projectedColumn = buildCastNode(exp, qStruct.fromListElements, qStruct, plainSelect, null,
							dbAppParameters);
					qStruct.projectedCols.add(projectedColumn);
					logger.log(Level.FINE, " Cast Expresssion Projected Column Added " + projectedColumn);
				}
				// deals with the case expression
				else if (e instanceof net.sf.jsqlparser.expression.CaseExpression) {
					logger.log(Level.FINE, "case expression: " + e);

					CaseExpression caseExpr = (CaseExpression) e;

					List<WhenClause> whenClauses = caseExpr.getWhenClauses();
					Expression switchExpression = caseExpr.getSwitchExpression();
					Node switchExpressionNode = processExpression(switchExpression, qStruct.fromListElements, qStruct,
							plainSelect, null, dbAppParameters);
					parsing.CaseExpression retCaseExpr = new parsing.CaseExpression();
					ArrayList<CaseCondition> whenConditionals = new ArrayList<CaseCondition>();

					for (Expression whenClauseExpr : whenClauses) {
						WhenClause whenClause = (WhenClause) whenClauseExpr;
						Node antecedentNode = processExpression(whenClause.getWhenExpression(),
								qStruct.fromListElements, qStruct, plainSelect, null, dbAppParameters);

						Node consequentNode = processExpression(whenClause.getThenExpression(),
								qStruct.fromListElements, qStruct, plainSelect, null, dbAppParameters);

						if (switchExpression != null) {
							Node tempNode = new Node();
							tempNode.setType(Node.getBroNodeType());
							tempNode.setOperator(QueryStructure.cvcRelationalOperators[1]);
							tempNode.setLeft(switchExpressionNode);
							tempNode.setRight(antecedentNode);
							antecedentNode = tempNode;
						}
						CaseCondition cC = new CaseCondition();
						cC.setWhenNode(antecedentNode);
						cC.setThenNode(consequentNode);
						whenConditionals.add(cC);

					}
					retCaseExpr.setWhenConditionals(whenConditionals);

					if (caseExpr.getElseExpression() != null) {
						CaseCondition cC = new CaseCondition();
						Node consequestNode = processExpression(caseExpr.getElseExpression(), qStruct.fromListElements,
								qStruct, plainSelect, null, dbAppParameters);

						cC.setThenNode(consequestNode);
						retCaseExpr.setElseConditional(cC);
					}
					Node projectedColumn = new Node();
					projectedColumn.setType(Node.getCaseNodeType());
					if (selExpItem.getAlias() != null)
						projectedColumn.setAliasName(selExpItem.getAlias().getName());
					projectedColumn.setCaseExpression(retCaseExpr);

					// chaitra set tuple no. and base column for case
					qStruct.isCase = whenClauses.size() + 1;
					projectedColumn.setColumn(setCaseProjectionColumn(retCaseExpr.whenConditionals.get(0).whenNode));
					// chaitra set tuple no. and base column for case end

					qStruct.projectedCols.add(projectedColumn);
					logger.log(Level.FINE, " Case Expresssion Projected Column Added " + projectedColumn);

				} else {// case when projected column is not a case expression
					Node projectedColumn = processExpression(e, qStruct.fromListElements, qStruct, plainSelect, null,
							dbAppParameters);
					// set aggregate alias if any (eg: count(id) as count_id)
					if (projectedColumn.getAgg() != null && selExpItem.getAlias() != null) {
						projectedColumn.getAgg().setAggAliasName(selExpItem.getAlias().getName());
					}
					// set alias if any for simple columns
					else if (selExpItem.getAlias() != null) {
						projectedColumn.setAliasName(selExpItem.getAlias().getName());
					}

					// chaitra set tuple no. and base column for case
					if (projectedColumn.getType().equalsIgnoreCase("CASE NODE")) {
						qStruct.isCase += projectedColumn.getCaseExpression().getWhenConditionals().size() + 1;
						projectedColumn.setColumn(setCaseProjectionColumn(
								projectedColumn.getCaseExpression().whenConditionals.get(0).whenNode));
					}
					// chaitra set tuple no. and base column for case end

					// chaitra for mixed bao nodes like sum(xyz)*exp add the hidden aggregate functions as projections
					if (projectedColumn.getType().equalsIgnoreCase("BAO NODE")){
						addHiddenAggNodesFromBaoNode(projectedColumn, qStruct);
					}
					//Following condition is added for scaler sub query in select clause.
					if(projectedColumn.getType().equals(Node.getBroNodeSubQType())){
						qStruct.getWhereClauseSubqueries().remove(projectedColumn.subQueryStructure);
						qStruct.getSelectClauseSubqueries().add(projectedColumn.subQueryStructure);
						// qStruct.projectedCols.add(projectedColumn.subQueryStructure.projectedCols.get(0));
						continue;
					}

					qStruct.projectedCols.add(projectedColumn);
					logger.log(Level.FINE, "Select Expression" + projectedItem.toString() + " " + projectedColumn
							+ " type " + projectedColumn.getType());

					if (qStruct.setOperator == null || qStruct.setOperator.isEmpty()) {
						// deals with the case when the table name of the projected column cannot be
						// resolved
						if (!projectedColumn.getType().equals(Node.getBaoNodeType())
								&& !projectedColumn.getType().equals(Node.getValType())
								&& !projectedColumn.getType().equals(Node.getAggrNodeType())
								&& !projectedColumn.getType().equals(Node.getCaseNodeType())
								&& !projectedColumn.getType().equals(Node.getExtractFuncType())
								&& !projectedColumn.getType().equals("ANALYTICAL NODE")
								&& (projectedColumn.getTableNameNo() == null
										|| projectedColumn.getTableNameNo().isEmpty())) {
							logger.log(Level.FINE,
									" Column name could not be resolved, query parsing failed, exception thrown, query: "
											+ plainSelect.toString());
							throw new Exception(
									" Column name could not be resolved, query parsing failed, exception thrown");
						}
					}

				}
			}
		}
	}

	private static void addHiddenAggNodesFromBaoNode(Node baoNode, QueryStructure qStruct) throws Exception {
		if (baoNode == null || baoNode.getType().equalsIgnoreCase("COLREF") || baoNode.getType().equalsIgnoreCase("VALUE"))
			return;
		if (baoNode.getType().equalsIgnoreCase("AGGREGATE NODE")) {
			// Node newAggNode = baoNode.clone();
			qStruct.getProjectedCols().add(baoNode);
			return;
		}
		addHiddenAggNodesFromBaoNode(baoNode.getLeft(), qStruct);
		addHiddenAggNodesFromBaoNode(baoNode.getRight(), qStruct);
	}

	/**
	 * @author mathew
	 * 
	 *         displays the contents of a list of FromListElements, by hierachically
	 *         traversing the iterating the list,
	 *         if any member fle represents is subquery, then it traverses into the
	 *         fromListElements of the subquery,
	 *         if any member fle represents a subjoin, then it traverses into it (by
	 *         recursion on getTabs)
	 * 
	 * @param visitedFromListElements
	 */
	public static void newDisplay(Vector<FromClauseElement> visitedFromListElements) {
		for (FromClauseElement fle : visitedFromListElements) {
			if (fle != null && (fle.getTableName() != null || fle.getTableNameNo() != null))
				;
			else if (fle != null && fle.getSubQueryStructure() != null) {

				newDisplay(fle.getSubQueryStructure().getFromListElements());
			} else if (fle != null && fle.getBag() != null && !fle.getBag().isEmpty()) {
				newDisplay(fle.getBag());
			}

		}
	}

	/**
	 * @author mathew
	 * 
	 * @param jsqlTable
	 * @param frmListElement
	 * @param qStruct
	 * 
	 *                       deals with the case when the fromListElement is a
	 *                       table, in which case
	 *                       the frmListElement argument is used to encode its
	 *                       details
	 * 
	 */
	public static void processFromListTable(net.sf.jsqlparser.schema.Table jsqlTable, FromClauseElement frmListElement,
			QueryStructure qStruct) {
		String tableName = jsqlTable.getFullyQualifiedName().toUpperCase();// getWholeTableName();

		// String tableName = jsqlTable.getFullyQualifiedName();// getWholeTableName();
		// // added by ram for mysql
		Table table = qStruct.getTableMap().getTable(tableName.toUpperCase());
		String aliasName = "";
		if (jsqlTable.getAlias() == null) {
			aliasName = tableName;
		} else {
			// aliasName = jsqlTable.getAlias().getName().toUpperCase();// getAlias();
			aliasName = jsqlTable.getAlias().getName();// added by rambabu
		}
		if (qStruct.getQuery().getRepeatedRelationCount().get(tableName) != null) {
			qStruct.getQuery().putRepeatedRelationCount(tableName, qStruct.getQuery()
					.getRepeatedRelationCount().get(tableName) + 1);
		} else {
			qStruct.getQuery().putRepeatedRelationCount(tableName, 1);
		}
		String tableNameNo = tableName
				+ qStruct.getQuery().getRepeatedRelationCount().get(tableName);

		frmListElement.setAliasName(aliasName);
		frmListElement.setTableName(tableName);
		frmListElement.setTableNameNo(tableNameNo);
		frmListElement.setBag(null);
		qStruct.addFromTable(frmListElement);

		qStruct.getQuery().addFromTable(table);
		qStruct.getQuery().putBaseRelation(aliasName, tableName);
		qStruct.getQuery().putBaseRelation(tableName);

		logger.fine("Table added" + frmListElement);
	}
	
	/**
	 * @author mathew
	 * 
	 * @param subJoin
	 * @param visitedFromListElements
	 * @param joinConditions
	 * @param qStruct
	 * @param plainSelect
	 * @throws Exception
	 *                   deals with the case when the fromListElement is a sub join,
	 *                   in which case
	 *                   the visitedFromListElements argument is used to encode
	 *                   details of it and its components,
	 *                   join conditions if any are extracted in joinConditions
	 *                   argument
	 */
	public static void processFromListSubJoin(Select subJoin, Vector<FromClauseElement> visitedFromListElements,
			Vector<Node> joinConditions,
			QueryStructure qStruct, PlainSelect plainSelect, AppTest_Parameters dbAppParameters) throws Exception {
		logger.log(Level.FINE, "processing subjoin" + subJoin.toString());
		FromItem leftFromItem = null;
		if (subJoin.getPlainSelect().getFromItem() == null)
			leftFromItem = subJoin.getPlainSelect().getJoin(0).getFromItem();
		else {
			leftFromItem = subJoin.getPlainSelect().getFromItem();
		}
		FromClauseElement leftFLE = null, rightFLE = null;

		if (leftFromItem instanceof net.sf.jsqlparser.schema.Table) {
			net.sf.jsqlparser.schema.Table jsqlTable = (net.sf.jsqlparser.schema.Table) leftFromItem;
			leftFLE = new FromClauseElement();
			ProcessSelectClause.processFromListTable(jsqlTable, leftFLE, qStruct);
			// logger.info(leftFLE.toString());
			visitedFromListElements.add(leftFLE);
		} else if (leftFromItem instanceof Select) {
			Select leftSubJoin = (Select) leftFromItem;
			Vector<FromClauseElement> tempElements = new Vector<FromClauseElement>();
			ProcessSelectClause.processFromListSubJoin(leftSubJoin, tempElements, joinConditions, qStruct, plainSelect,
					dbAppParameters);
			leftFLE = new FromClauseElement();
			if (leftSubJoin.getPlainSelect().getFromItem().getAlias() != null) {
				leftFLE.setAliasName(leftSubJoin.getPlainSelect().getFromItem().getAlias().getName());
			}
			leftFLE.setBag(tempElements);
			visitedFromListElements.add(leftFLE);
		} else if (leftFromItem instanceof ParenthesedSelect) {
			ParenthesedSelect ParenthesedSelect = (ParenthesedSelect) leftFromItem;
			QueryStructure subQueryParser = new QueryStructure(qStruct.getTableMap());
			leftFLE = new FromClauseElement();
			leftFLE.setSubQueryStructure(subQueryParser);
			if (ParenthesedSelect.getAlias() != null) {
				leftFLE.setAliasName(ParenthesedSelect.getAlias().getName());
				leftFLE.setTableNameNo(ParenthesedSelect.getAlias().getName());
			}
			qStruct.fromListElements.addElement(leftFLE);

			ProcessSelectClause.processFromListParenthesedSelect(ParenthesedSelect, subQueryParser, qStruct,
					dbAppParameters);

		} else if (leftFromItem instanceof ParenthesedFromItem) {
			ProcessSelectClause.processFromClause(null, (ParenthesedFromItem) leftFromItem, qStruct, joinConditions,
					dbAppParameters);
		}
		FromItem rightFromItem = null;
		if (subJoin.getPlainSelect().getJoins() != null && subJoin.getPlainSelect().getJoins().size() != 0) {
			rightFromItem = subJoin.getPlainSelect().getJoin(0).getRightItem();
		}
		if (rightFromItem != null) {
			if (rightFromItem instanceof net.sf.jsqlparser.schema.Table) {
				net.sf.jsqlparser.schema.Table jsqlTable = (net.sf.jsqlparser.schema.Table) rightFromItem;
				rightFLE = new FromClauseElement();
				ProcessSelectClause.processFromListTable(jsqlTable, rightFLE, qStruct);
				// logger.info(rightFLE.toString());
				visitedFromListElements.add(rightFLE);
			} else if (rightFromItem instanceof Select) {
				Select rightSubJoin = (Select) rightFromItem;
				Vector<FromClauseElement> tempElements = new Vector<FromClauseElement>();
				ProcessSelectClause.processFromListSubJoin(rightSubJoin, tempElements, joinConditions, qStruct,
						plainSelect,
						dbAppParameters);
				rightFLE = new FromClauseElement();
				if (rightSubJoin.getPlainSelect().getFromItem().getAlias() != null) {
					rightFLE.setAliasName(rightSubJoin.getPlainSelect().getFromItem().getAlias().getName());
				}
				rightFLE.setBag(tempElements);
				visitedFromListElements.add(rightFLE);
			} else if (rightFromItem instanceof ParenthesedSelect) {
				ParenthesedSelect ParenthesedSelect = (ParenthesedSelect) rightFromItem;
				QueryStructure subQueryParser = new QueryStructure(qStruct.getTableMap());
				rightFLE = new FromClauseElement();
				rightFLE.setSubQueryStructure(subQueryParser);
				if (ParenthesedSelect.getAlias() != null) {
					rightFLE.setAliasName(ParenthesedSelect.getAlias().getName());
					rightFLE.setTableNameNo(ParenthesedSelect.getAlias().getName());

				}
				qStruct.fromListElements.addElement(rightFLE);

				ProcessSelectClause.processFromListParenthesedSelect(ParenthesedSelect, subQueryParser, qStruct,
						dbAppParameters);

			} else if (rightFromItem instanceof ParenthesedFromItem) {
				ProcessSelectClause.processFromClause(null, (ParenthesedFromItem) rightFromItem, qStruct,
						joinConditions,
						dbAppParameters);
			}
		}

		Vector<FromClauseElement> leftFLEVectorForNaturalJoin = new Vector<FromClauseElement>();
		List<Join> joins = plainSelect != null ? plainSelect.getJoins() : null;
		for (Join join : joins) {

			FromItem fromItem = join.getRightItem();
			if (fromItem instanceof net.sf.jsqlparser.schema.Table) {
				net.sf.jsqlparser.schema.Table jsqlTable = (net.sf.jsqlparser.schema.Table) fromItem;
				rightFLE = new FromClauseElement();
				processFromListTable(jsqlTable, rightFLE, qStruct);
				qStruct.fromListElements.addElement(rightFLE);
			} else if (fromItem instanceof Select) {
				Select subJoin1 = (Select) fromItem;
				Vector<FromClauseElement> tempElements = new Vector<FromClauseElement>();
				ProcessSelectClause.processFromListSubJoin(subJoin1, tempElements, joinConditions, qStruct,
						plainSelect, dbAppParameters);
				rightFLE = new FromClauseElement();
				if (subJoin1.getPlainSelect().getFromItem().getAlias() != null) {
					rightFLE.setAliasName(subJoin1.getPlainSelect().getFromItem().getAlias().getName());
				}
				rightFLE.setBag(tempElements);
				qStruct.fromListElements.addElement(rightFLE);

			} else if (fromItem instanceof ParenthesedSelect) {
				ParenthesedSelect ParenthesedSelect = (ParenthesedSelect) fromItem;
				QueryStructure subQueryParser = new QueryStructure(qStruct.getTableMap());
				rightFLE = new FromClauseElement();
				rightFLE.setSubQueryStructure(subQueryParser);
				if (ParenthesedSelect.getAlias() != null) {
					rightFLE.setAliasName(ParenthesedSelect.getAlias().getName());
					rightFLE.setTableNameNo(ParenthesedSelect.getAlias().getName());
				}
				qStruct.fromListElements.addElement(rightFLE);

				processFromListParenthesedSelect(ParenthesedSelect, subQueryParser, qStruct, dbAppParameters);

			} else if (fromItem instanceof ParenthesedFromItem) {
				ProcessSelectClause.processFromClause(null, (ParenthesedFromItem) fromItem, qStruct, joinConditions,
						dbAppParameters);
			}

			Iterator<Expression> ite = join.getOnExpressions().iterator();

			Expression expressions = null;
			while (ite.hasNext()) {
				expressions = ite.next();
				List<Expression> exp = new ArrayList<Expression>();

				if (expressions instanceof ParenthesedExpressionList) {
					ParenthesedExpressionList parenthesizedExpressionList = (ParenthesedExpressionList) expressions;
					// Process expressions
					for (int j = 0; j < parenthesizedExpressionList.size(); j++) {
						exp.add((Expression) parenthesizedExpressionList.get(j));
					}
				}
				Expression e = null;
				if (exp.size() > 0)
					e = exp.get(0);

				if (e != null) {/* Handling joins with ON Conditions */
					Node joinCondition = null;
					if (join.isLeft())
						joinCondition = ProcessSelectClause.processExpression(e, qStruct.fromListElements, qStruct,
								plainSelect, JoinClauseInfo.leftOuterJoin, dbAppParameters);
					else if (join.isRight())
						joinCondition = ProcessSelectClause.processExpression(e, qStruct.fromListElements, qStruct,
								plainSelect, JoinClauseInfo.rightOuterJoin, dbAppParameters);
					else if (join.isFull())
						joinCondition = ProcessSelectClause.processExpression(e, qStruct.fromListElements, qStruct,
								plainSelect, JoinClauseInfo.fullOuterJoin, dbAppParameters);
					else
						joinCondition = ProcessSelectClause.processExpression(e, qStruct.fromListElements, qStruct,
								plainSelect, JoinClauseInfo.innerJoin, dbAppParameters);

					joinConditions.add(joinCondition);
				}

			}
			if (join.getUsingColumns() != null && !join.getUsingColumns().isEmpty()) {/*
																						 * Handling
																						 * joins
																						 * with using
																						 * Conditions
																						 */
				Vector<FromClauseElement> leftFLEVector = new Vector<FromClauseElement>();
				leftFLEVector.add(leftFLE);
				Vector<FromClauseElement> rightFLEVector = new Vector<FromClauseElement>();
				rightFLEVector.add(rightFLE);
				Vector<Node> leftColumns = parsing.Util.getAllProjectedColumns(leftFLEVector, qStruct);
				Vector<Node> rightColumns = parsing.Util.getAllProjectedColumns(rightFLEVector, qStruct);
				for (Column column : join.getUsingColumns()) {
					Node matchedLeftColumn = null;
					for (Node leftColumn : leftColumns) {
						if (leftColumn.getColumn().getColumnName().equalsIgnoreCase(column.getColumnName())) {
							matchedLeftColumn = leftColumn;
							break;
						}
					}
					Node matchedRightColumn = null;
					for (Node rightColumn : rightColumns) {
						if (rightColumn.getColumn().getColumnName().equalsIgnoreCase(column.getColumnName())) {
							matchedRightColumn = rightColumn;
							break;
						}
					}
					if (matchedLeftColumn != null && matchedRightColumn != null) {
						Node equiJoinNode = new Node();
						equiJoinNode.setType(Node.getBroNodeType());
						equiJoinNode.setOperator(QueryStructure.cvcRelationalOperators[1]);
						equiJoinNode.setLeft(matchedLeftColumn);
						equiJoinNode.setRight(matchedRightColumn);
						if (join.isLeft())
							equiJoinNode.setJoinType(JoinClauseInfo.leftOuterJoin);
						else if (join.isRight())
							equiJoinNode.setJoinType(JoinClauseInfo.rightOuterJoin);
						else if (join.isFull())
							equiJoinNode.setJoinType(JoinClauseInfo.leftOuterJoin);
						else
							equiJoinNode.setJoinType(JoinClauseInfo.innerJoin);
						joinConditions.add(equiJoinNode);
						logger.log(Level.FINE,
								" join condition added for join with using condition: " + equiJoinNode);
					}
				}
			} else if (join.isNatural()) {/* Handling natural joins */
				leftFLEVectorForNaturalJoin.add(leftFLE);
				Vector<FromClauseElement> rightFLEVector = new Vector<FromClauseElement>();
				rightFLEVector.add(rightFLE);
				Vector<Node> leftColumns = parsing.Util.getAllProjectedColumns(leftFLEVectorForNaturalJoin,
						qStruct);
				Vector<Node> rightColumns = parsing.Util.getAllProjectedColumns(rightFLEVector, qStruct);
				for (Node leftColumn : leftColumns) {

					for (Node rightColumn : rightColumns) {
						if (leftColumn.getColumn().getColumnName().contains("XDATA_CNT")
								|| rightColumn.getColumn().getColumnName().contains("XDATA_CNT"))
							continue;
						if (leftColumn.getColumn().getColumnName()
								.equals(rightColumn.getColumn().getColumnName())) {
							Node equiJoinNode = new Node();
							equiJoinNode.setType(Node.getBroNodeType());
							equiJoinNode.setOperator(QueryStructure.cvcRelationalOperators[1]);
							equiJoinNode.setLeft(leftColumn);
							equiJoinNode.setRight(rightColumn);
							if (join.isLeft())
								equiJoinNode.setJoinType(JoinClauseInfo.leftOuterJoin);
							else if (join.isRight())
								equiJoinNode.setJoinType(JoinClauseInfo.rightOuterJoin);
							else if (join.isFull())
								equiJoinNode.setJoinType(JoinClauseInfo.leftOuterJoin);
							else
								equiJoinNode.setJoinType(JoinClauseInfo.innerJoin);

							joinConditions.add(equiJoinNode);
							logger.log(Level.FINE, " join condition added for natural join: " + equiJoinNode);
						}
					}
				}
			}
			leftFLE = rightFLE;// reset leftFLE to the previously visited FLE
		}

		Join join = subJoin.getPlainSelect().getJoin(0);
		Expression e = join.getOnExpression();
		Vector<FromClauseElement> leftFLEVector = new Vector<FromClauseElement>();

		if (e != null) {
			// leftFLEVector.add(leftFLE);
			Node joinCondition = null;
			if (join.isLeft())
				joinCondition = ProcessSelectClause.processExpression(e, qStruct.fromListElements, qStruct, plainSelect,
						JoinClauseInfo.leftOuterJoin, dbAppParameters);
			else if (join.isRight())
				joinCondition = ProcessSelectClause.processExpression(e, qStruct.fromListElements, qStruct, plainSelect,
						JoinClauseInfo.rightOuterJoin, dbAppParameters);
			else if (join.isFull())
				joinCondition = ProcessSelectClause.processExpression(e, qStruct.fromListElements, qStruct, plainSelect,
						JoinClauseInfo.fullOuterJoin, dbAppParameters);
			else
				joinCondition = ProcessSelectClause.processExpression(e, qStruct.fromListElements, qStruct, plainSelect,
						JoinClauseInfo.innerJoin, dbAppParameters);

			joinConditions.add(joinCondition);
		} else if (join.isNatural()) {
			leftFLEVector.add(leftFLE);
			Vector<FromClauseElement> rightFLEVector = new Vector<FromClauseElement>();
			rightFLEVector.add(rightFLE);
			Vector<Node> leftColumns = parsing.Util.getAllProjectedColumns(leftFLEVector, qStruct);
			Vector<Node> rightColumns = parsing.Util.getAllProjectedColumns(rightFLEVector, qStruct);
			for (Node leftColumn : leftColumns) {
				if (leftColumn.getColumn().getColumnName().contains("XDATA_CNT"))
					continue;
				for (Node rightColumn : rightColumns) {
					if (rightColumn.getColumn().getColumnName().contains("XDATA_CNT"))
						continue;

					if (leftColumn.getColumn().getColumnName().equals(rightColumn.getColumn().getColumnName())) {
						Node equiJoinNode = new Node();
						equiJoinNode.setType(Node.getBroNodeType());
						equiJoinNode.setOperator(QueryStructure.cvcRelationalOperators[1]);
						equiJoinNode.setLeft(leftColumn);
						equiJoinNode.setRight(rightColumn);

						if (join.isLeft())
							equiJoinNode.setJoinType(JoinClauseInfo.leftOuterJoin);
						else if (join.isRight())
							equiJoinNode.setJoinType(JoinClauseInfo.rightOuterJoin);
						else if (join.isFull())
							equiJoinNode.setJoinType(JoinClauseInfo.leftOuterJoin);
						else
							equiJoinNode.setJoinType(JoinClauseInfo.innerJoin);

						joinConditions.add(equiJoinNode);
						logger.log(Level.FINE, " join condition added for natural join: " + equiJoinNode);
					}
				}
			}
		}

	}

	/**
	 * @author mathew - code modified and adapted from
	 *         parsing.WhereClauseVectorJSQL.getWhereClauseVector
	 * 
	 * @param clause      - expression to be processed
	 * @param fle         - set of fromListElements visited in the from clause of
	 *                    the plainSelect (4th argument)
	 * @param qStruct-    this query structure in its data structures encodes the
	 *                    plainSelect (4th argument)
	 * @param plainSelect - select query of which the clause (1st parameter) was
	 *                    part of
	 * @param joinType    - string for setting the join type (eg: right outer join),
	 *                    in case if the clause was part of a join expression
	 * @return Node (expression) that represents the expression
	 * @throws Exception
	 */

	public static Node processExpression(Object clause, Vector<FromClauseElement> fle,
			QueryStructure qStruct, PlainSelect plainSelect, String joinType, AppTest_Parameters dbAppParameters)
			throws Exception {

		try {
			// System.out.println(clause);
			if (clause == null) {
				return null;
			} else if (clause instanceof Parenthesis) {
				Parenthesis par = ((Parenthesis) clause);
				return processExpressionForParenthesis(par, fle, qStruct, plainSelect, joinType, dbAppParameters);
			} else if (clause instanceof Function) {
				Function an = (Function) clause;
				return processExpressionForFunction(an, fle, qStruct, plainSelect, joinType, dbAppParameters);

			}else if (clause instanceof TrimFunction) { // <--- Add this
				TrimFunction te = (TrimFunction) clause;
				return processExpressionForTrim(te, fle, qStruct, plainSelect, joinType, dbAppParameters);

			} 
			 else if (clause instanceof AnalyticExpression) {
				AnalyticExpression ae = (AnalyticExpression) clause;

				return ProcessExpressionForAnalyticalExpression(ae, fle, qStruct, plainSelect, joinType,
						dbAppParameters);
			} else if (clause instanceof DoubleValue) {
				Node n = new Node();
				n.setType(Node.getValType());
				String s = ((((DoubleValue) clause).getValue())) + "";
				// String str=(BigIntegerDecimal)((((NumericConstantNode)
				// clause).getValue()).getDouble()).toString();
				s = util.Utilities.covertDecimalToFraction(s);
				n.setStrConst(s);
				n.setLeft(null);
				n.setRight(null);
				return n;

			} else if (clause instanceof LongValue) {
				Node n = new Node();
				n.setType(Node.getValType());
				String s = ((((LongValue) clause).getValue())) + "";
				s = util.Utilities.covertDecimalToFraction(s);
				n.setStrConst(s);
				n.setLeft(null);
				n.setRight(null);
				return n;
			} else if (clause instanceof StringValue) {
				Node n = new Node();
				// chaitra changed here - dont change type if date
				if (n.getType()!=Node.getDateType())
					n.setType(Node.getValType());
				String temp=(((StringValue) clause).getValue());
				temp="'"+temp+"'";
				n.setStrConst(temp);
				n.setLeft(null);
				n.setRight(null);
				return n;
			} else if (clause instanceof TimeValue) {
				TimeValue timeValue = (TimeValue) clause;
				Time t = timeValue.getValue();
				Node n = new Node();
				n.setType(Node.getValType());
				n.setStrConst(t.toString());
				n.setLeft(null);
				n.setRight(null);
				logger.log(Level.FINE, "TimeValue" + clause);
			} else if (clause instanceof TimestampValue) {
				TimestampValue timeStampValue = (TimestampValue) clause;
				Timestamp ts = timeStampValue.getValue();
				Node n = new Node();
				n.setType(Node.getValType());
				n.setStrConst(ts.toString());
				n.setLeft(null);
				n.setRight(null);
				logger.log(Level.FINE, "TimestampValue" + clause);
				return n;
			} else if (clause instanceof TimeKeyExpression) {
				TimeKeyExpression timeKey = (TimeKeyExpression) clause;
				Node n = new Node();
				if (timeKey.getStringValue().equalsIgnoreCase("current_date")) {
					n.setType(Node.getDateType());
					n.setStrConst(java.time.LocalDate.now().toString());
				}
				else {
					n.setType(Node.getValType());
					n.setStrConst(timeKey.getStringValue());
				}
				n.setLeft(null);
				n.setRight(null);
				return n;
			} else if (clause instanceof DateTimeLiteralExpression) {
				DateTimeLiteralExpression dateTimeExpr = (DateTimeLiteralExpression) clause;
				Node n = new Node();
				n.setType(Node.getValType());
				n.setStrConst(dateTimeExpr.getValue());
				n.setLeft(null);
				n.setRight(null);
				logger.log(Level.FINE, "DateTimeLiteralExpression Processed" + n);
				return n;
			} else if (clause instanceof DateValue) {
				DateValue dateValue = (DateValue) clause;
				logger.log(Level.FINE, "its a date" + dateValue.getValue());
				Node n = new Node();
				n.setType(Node.getValType());
				n.setStrConst(dateValue.getValue().toString());
				n.setLeft(null);
				n.setRight(null);
				return n;

			} else if (clause instanceof IntervalExpression) {
				IntervalExpression dateTimeExpr = (IntervalExpression) clause;
				Node n = new Node();
				// chaitra changed interval type to date
				n.setType(Node.getDateType());
				n.setStrConst(dateTimeExpr.toString());
				n.setLeft(null);
				n.setRight(null);
				logger.log(Level.FINE, "IntervalExpression Processed" + n);
				return n;
			} else if (clause instanceof SignedExpression) {
				SignedExpression sExpr = (SignedExpression) clause;
				logger.log(Level.FINE, "its a signed expression" + sExpr);
				Node n = processExpression(sExpr.getExpression(), qStruct.fromListElements, qStruct, plainSelect,
						joinType, dbAppParameters);
				if (n.getType().equals(Node.getValType())) {
					n.setStrConst(sExpr.getSign() + n.getStrConst());
				}
				return n;

			} else if (clause instanceof ExtractExpression) {
				//Column col = (Column) ((ExtractExpression) clause).getExpression();
				//return processExpression(col, fle, qStruct, plainSelect, joinType, dbAppParameters);
				// chaitra changed here for date - parse extract
				ExtractExpression exp = (ExtractExpression) clause;
				return processExpressionForExtract(exp, fle, qStruct, plainSelect, joinType, dbAppParameters);
			} else if (clause instanceof Column) {
				Column columnReference = (Column) clause;
				if(columnReference.getTable()==null){
					net.sf.jsqlparser.schema.Table t = new net.sf.jsqlparser.schema.Table("");
					columnReference.setTable(t);
				}
				return ProcessExpressionForColumn(columnReference, fle, qStruct, plainSelect, joinType,
						dbAppParameters);
			} else if (clause instanceof AndExpression) {
				BinaryExpression andNode = ((BinaryExpression) clause);
				return ProcessExpressionForAnd(andNode, fle, qStruct, plainSelect, joinType, dbAppParameters);

			} else if (clause instanceof OrExpression) {
				BinaryExpression orNode = ((BinaryExpression) clause);
				return ProcessExpressionForOr(orNode, fle, qStruct, plainSelect, joinType, dbAppParameters);

			}
			// Added by Bikash
			// ---------------------------------------------------------------------------------
			else if (clause instanceof LikeExpression) {
				BinaryExpression likeNode = ((BinaryExpression) clause);
				return ProcessExpressionForLike(clause, likeNode, fle, qStruct, plainSelect, joinType, dbAppParameters);
			} else if (clause instanceof ParenthesedExpressionList) {
				ParenthesedExpressionList<Expression> pel = (ParenthesedExpressionList<Expression>) clause;
				// TODO: handle this case
				Expression e = pel.getExpressions().get(0);
				Node n = processExpression(e, fle, qStruct, plainSelect, joinType, dbAppParameters);
				return n;
			}

			else if (clause instanceof JdbcParameter) {
				Node n = new Node();
				n.setType(Node.getValType());
				n.setStrConst("$" + qStruct.paramCount);
				qStruct.paramCount++;
				n.setLeft(null);
				n.setRight(null);

				return n;
			} else if (clause instanceof Addition) {
				BinaryExpression baoNode = ((BinaryExpression) clause);
				if (baoNode.getLeftExpression() instanceof IntervalExpression
						|| baoNode.getRightExpression() instanceof IntervalExpression) {
					// return processInterval(baoNode, fle, qStruct, plainSelect, joinType, dbAppParameters);
				} else if (baoNode.getLeftExpression() instanceof DoubleValue
						&& baoNode.getRightExpression() instanceof DoubleValue) {
					return solveArithmaticOperation(baoNode, fle, qStruct, plainSelect, joinType, dbAppParameters, '+');
				}
				return ProcessExpressionForAddition(baoNode, fle, qStruct, plainSelect, joinType, dbAppParameters);
			} else if (clause instanceof Subtraction) {
				BinaryExpression baoNode = ((BinaryExpression) clause);
				if (baoNode.getLeftExpression() instanceof IntervalExpression
						|| baoNode.getRightExpression() instanceof IntervalExpression) {
					return processInterval(baoNode, fle, qStruct, plainSelect, joinType, dbAppParameters);
				} else if (baoNode.getLeftExpression() instanceof DoubleValue
						&& baoNode.getRightExpression() instanceof DoubleValue) {
					return solveArithmaticOperation(baoNode, fle, qStruct, plainSelect, joinType, dbAppParameters, '-');
				}
				return ProcessExpressionForSubtraction(baoNode, fle, qStruct, plainSelect, joinType, dbAppParameters);
			} else if (clause instanceof Multiplication) {
				BinaryExpression baoNode = ((BinaryExpression) clause);
				if (baoNode.getLeftExpression() instanceof DoubleValue
						&& baoNode.getRightExpression() instanceof DoubleValue) {
					return solveArithmaticOperation(baoNode, fle, qStruct, plainSelect, joinType, dbAppParameters, '*');
				}
				return ProcessExpressionForMultiplication(baoNode, fle, qStruct, plainSelect, joinType,
						dbAppParameters);
			} else if (clause instanceof Division) {
				BinaryExpression baoNode = ((BinaryExpression) clause);
				if (baoNode.getLeftExpression() instanceof DoubleValue
						&& baoNode.getRightExpression() instanceof DoubleValue) {
					return solveArithmaticOperation(baoNode, fle, qStruct, plainSelect, joinType, dbAppParameters, '/');
				}
				return ProcessExpressionForDivision(baoNode, fle, qStruct, plainSelect, joinType, dbAppParameters);
			}

			else if (clause instanceof NotEqualsTo) {
				NotEqualsTo broNode = (NotEqualsTo) clause;
				return ProcessExpressionForNotEquals(broNode, fle, qStruct, plainSelect, joinType, dbAppParameters);
			} else if (clause instanceof DoubleAnd) {
				DoubleAnd broNode = (DoubleAnd) clause;
				return ProcessExpressionForDoubleAnd(broNode, fle, qStruct, plainSelect, joinType, dbAppParameters);
			} else if (clause instanceof IsBooleanExpression) {
				IsBooleanExpression isBooleanNode = (IsBooleanExpression) clause;
				return ProcessExpressionForIsBoolean(isBooleanNode, fle, qStruct, plainSelect, joinType, dbAppParameters);
			} else if (clause instanceof IsNullExpression) {
				IsNullExpression isNullNode = (IsNullExpression) clause;
				return ProcessExpressionForIsNull(isNullNode, fle, qStruct, plainSelect, joinType, dbAppParameters);
			} else if (clause instanceof InExpression) {
				// handles NOT and NOT IN both
				InExpression sqn = (InExpression) clause;
				return ProcessExpressionForIn(sqn, fle, qStruct, plainSelect, joinType, dbAppParameters);

			} else if (clause instanceof ExistsExpression) {
				ExistsExpression sqn = (ExistsExpression) clause;
				return ProcessExpressionForExists(sqn, fle, qStruct, plainSelect, joinType, dbAppParameters);
			} else if (clause instanceof ParenthesedSelect) {
				ParenthesedSelect sqn = (ParenthesedSelect) clause;
				return ProcessExpressionForParenthesedSelect(sqn, fle, qStruct, plainSelect, joinType, dbAppParameters);
			} else if (clause instanceof Between) {
				Between bn = (Between) clause;
				return ProcessExpressionForBetween(bn, fle, qStruct, plainSelect, joinType, dbAppParameters);

			} else if (clause instanceof EqualsTo) {
				BinaryExpression bne = (BinaryExpression) clause;
				return ProcessExpressionForEqualsTo(bne, fle, qStruct, plainSelect, joinType, dbAppParameters);

			} else if (clause instanceof GreaterThan) {
				GreaterThan broNode = (GreaterThan) clause;
				return processExpressionForGreaterThan(broNode, qStruct.fromListElements, qStruct, plainSelect,
						joinType, dbAppParameters);
			} else if (clause instanceof GreaterThanEquals) {
				GreaterThanEquals broNode = (GreaterThanEquals) clause;
				return processExpressionForGreaterThanEquals(broNode, qStruct.fromListElements, qStruct, plainSelect,
						joinType, dbAppParameters);
			} else if (clause instanceof MinorThan) {
				BinaryExpression bne = (BinaryExpression) clause;
				return processExpressionForMinorThan(bne, qStruct.fromListElements, qStruct, plainSelect, joinType,
						dbAppParameters);
			} else if (clause instanceof MinorThanEquals) {
				BinaryExpression bne = (BinaryExpression) clause;
				return processExpressionForMinorThanEquals(bne, qStruct.fromListElements, qStruct, plainSelect,
						joinType, dbAppParameters);
			} else if (clause instanceof CaseExpression) {
				CaseExpression caseExpr = (CaseExpression) clause;
				return processExpressionForCaseExpression(caseExpr, qStruct.fromListElements, qStruct, plainSelect,
						dbAppParameters);
			} else if (clause instanceof AnyComparisonExpression) {
				AnyComparisonExpression ace = (AnyComparisonExpression) clause;
				if (ace.getAnyType().name().equalsIgnoreCase("ANY")) {
					return processExpressionForAllComparison(ace, qStruct, dbAppParameters);
				} else {
					return processExpressionForAnyComparison(ace, qStruct, dbAppParameters);
				}
			} else if (clause instanceof ExtractExpression) {
				ExtractExpression exp = (ExtractExpression) clause;
				return processExpressionForExtract(exp, fle, qStruct, plainSelect, joinType, dbAppParameters);
			} else if (clause instanceof NotExpression) {

				NotExpression exp = (NotExpression) clause;
				Expression ex = exp.getExpression();


				if (ex instanceof ExistsExpression) {
					Node n = ProcessSelectClause.processExpression(ex,qStruct.fromListElements,qStruct,plainSelect,null,dbAppParameters);
					n.setType(Node.getNotExistsNodeType());
					return n;
				} else {
					Node n=new Node();
					n.setLeft(ProcessSelectClause.processExpression(ex,qStruct.fromListElements,qStruct,plainSelect,null,dbAppParameters));
					n.setType(Node.getNotNodeType());  
					return n; 
				}

				
			}else if (clause instanceof CastExpression) {
				CastExpression expr = (CastExpression) clause;
				return buildCastNode(expr, fle, qStruct, plainSelect, joinType, dbAppParameters);
			} else if (clause instanceof RegExpMatchOperator) {
				// chaitra: handle POSIX regex operator (col ~ 'pattern', col !~ 'pattern', etc.)
				RegExpMatchOperator regexExpr = (RegExpMatchOperator) clause;
				return processExpressionForRegExpMatch(regexExpr, fle, qStruct, plainSelect, joinType, dbAppParameters);
			} else {
				logger.log(Level.SEVERE, "getWhereClauseVector needs more programming ");
				// throw new Exception("getWhereClauseVector needs more programming ");
			}
		} catch (Exception e) {
			logger.log(Level.SEVERE, e.getMessage(), e);
			throw e;
		}
		return null;
	}

	public static Node processExpressionForParenthesis(Parenthesis par, Vector<FromClauseElement> fle,
			QueryStructure qStruct,
			PlainSelect plainSelect, String joinType, AppTest_Parameters dbAppParameters) throws Exception {

		boolean isNot = false;
		if (par.getExpression() instanceof NotExpression) {
			isNot = true;
		}
		Node n = processExpression(par.getExpression(), fle, qStruct, plainSelect, joinType, dbAppParameters);
		if (isNot) {
			Node left = n.getLeft();
			Node right = n.getRight();
			if (left != null && left.getNodeType() != null &&
					left.getNodeType().equals(Node.getBroNodeType())
					&& left.getOperator() != null && left.getOperator().equalsIgnoreCase("=")) {
				left.setOperator("/=");
			}
			if (right != null && right.getNodeType() != null &&
					right.getNodeType().equals(Node.getBroNodeType())
					&& right.getOperator() != null && right.getOperator().equalsIgnoreCase("=")) {
				right.setOperator("/=");
			}

			if (left != null && left.getNodeType() != null &&
					left.getNodeType().equals(Node.getBroNodeType())
					&& left.getOperator() != null && left.getOperator().equalsIgnoreCase("=")) {
				left.setOperator("/=");
			}
			if (right != null && right.getNodeType() != null &&
					right.getNodeType().equals(Node.getBroNodeType())
					&& right.getOperator() != null && right.getOperator().equalsIgnoreCase("=")) {
				right.setOperator("/=");
			}
		}
		return n;
	}

	public static Node ProcessExpressionForColumn(Column columnReference, Vector<FromClauseElement> fle,
			QueryStructure qStruct, PlainSelect plainSelect, String joinType, AppTest_Parameters dbAppParameters)
			throws Exception {
		String colName = columnReference.getColumnName().toUpperCase();
		String tableName = (columnReference.getTable() != null) ? columnReference.getTable().getFullyQualifiedName()
				: null;

		// Check if this is a boolean constant (TRUE/FALSE) being incorrectly parsed as a column
		if ((colName.equalsIgnoreCase("TRUE") || colName.equalsIgnoreCase("FALSE")) && 
		    (tableName == null || tableName.isEmpty() || tableName.equals(""))) {
			Node n = new Node();
			n.setType(Node.getValType());
			n.setStrConst(colName);
			n.setLeft(null);
			n.setRight(null);
			return n;
		}

		Node n = new Node();
		n.setTableNameNo(tableName);
		n.setColumn(new parsing.Column(colName, tableName));
		n.setOrgiColumn(n.getColumn());
		n.setType(Node.getColRefType());
		if (tableName != null) {
			n.setTableAlias(tableName);
		} else {
			n.setTableAlias("");
		}
		if (n.getColumn() != null) {
			n.setTable(n.getColumn().getTable());
		}
		if (n.getColumn() != null) {
			if (tableName != null && !tableName.equalsIgnoreCase("")
					&& qStruct.getTableMap().getTables().containsKey(tableName.toUpperCase())) {
				n.setTable(qStruct.getTableMap().getTable(tableName.toUpperCase()));
				n.setColumn(qStruct.getTableMap().getTable(tableName.toUpperCase()).getColumn(colName.toUpperCase()));
			}
			// n.getColumn().setTable(qStruct.getTableMap().getTable(tableName.toUpperCase()));
		}
		n.setLeft(null);
		n.setRight(null);

		if (n.getTableNameNo() == null || n.getTableNameNo().isEmpty() || n.getTableNameNo().equals("")) {
			for (Node m : parsing.Util.getAllProjectedColumns(qStruct.fromListElements, qStruct)) {
				if (m.getColumn() != null
						&& m.getColumn().getColumnName().equalsIgnoreCase(n.getColumn().getColumnName())) {
					n.setTable(m.getTable());
					n.setTableAlias(m.getTableNameNo());
					n.setTableNameNo(m.getTableNameNo());
					n.setColumn(m.getColumn());
					break;
				} else if (m.getType().equals(Node.getValType())
						&& m.getAliasName().equals(n.getColumn().getColumnName())) {
					n = new Node(m);
					return n;
				} else if (m.getType().equals(Node.getCaseNodeType())
						&& m.getAliasName().equals(n.getColumn().getColumnName())) {
					n = new Node(m);
					return n;
				} else if (m.getType().equals(Node.getExtractFuncType())
						&& m.getAliasName().equals(n.getColumn().getColumnName())) {
					n = new Node(m);
					return n;
				}
			}
			
		}

		n = transformToAbsoluteTableNames(n, fle, false, qStruct);

		if (n.getType().equals(Node.getValType()))
			return n;
		else if (n.getType().equals(Node.getExtractFuncType()))
			return n;
		else if (n.getType().equals(Node.getCaseNodeType()))
			return n;

		if (n.getTableNameNo() == null || n.getTableNameNo().isEmpty() || n.getTableNameNo().equals("")) {
			List<SelectItem<?>> projectedItems = plainSelect.getSelectItems();
			for (int j = 0; j < projectedItems.size(); j++) {
				SelectItem projectedItem = projectedItems.get(j);
				if (projectedItem instanceof net.sf.jsqlparser.statement.select.SelectItem) {
					SelectItem selExpItem = (net.sf.jsqlparser.statement.select.SelectItem) projectedItem;
					Expression e = selExpItem.getExpression();
					if (e instanceof net.sf.jsqlparser.expression.Parenthesis) {
						net.sf.jsqlparser.expression.Parenthesis p = (net.sf.jsqlparser.expression.Parenthesis) e;
						e = p.getExpression();
					}
					if (selExpItem.getAlias() != null) {
						if (n.getColumn().getColumnName().equalsIgnoreCase(selExpItem.getAlias().getName())) {
							n = processExpression(e, qStruct.fromListElements, qStruct, plainSelect, joinType,
									dbAppParameters);
							break;
						}
					}
				}
			}

		}

		return n;
	}

	public static Node ProcessExpressionForOr(BinaryExpression orNode, Vector<FromClauseElement> fle,
			QueryStructure qStruct,
			PlainSelect plainSelect, String joinType, AppTest_Parameters dbAppParameters) throws Exception {
		if (orNode.getLeftExpression() != null
				&& orNode.getRightExpression() != null) {
			Node n = new Node();
			n.setType(Node.getOrNodeType());
			n.setOperator("OR");
			n.setLeft(processExpression(orNode.getLeftExpression(), fle, qStruct, plainSelect, joinType,
					dbAppParameters));
			n.setRight(processExpression(orNode.getRightExpression(), fle, qStruct, plainSelect, joinType,
					dbAppParameters));

			n.setQueryType(2);
			n.setQueryIndex(qStruct.getWhereClauseSubqueries().size() - 1);
			return n;
		}
		return null;
	}

	public static Node ProcessExpressionForLike(Object clause, BinaryExpression likeNode, Vector<FromClauseElement> fle,
			QueryStructure qStruct, PlainSelect plainSelect, String joinType, AppTest_Parameters dbAppParameters)
			throws Exception {
		if (likeNode.getLeftExpression() != null && likeNode.getRightExpression() != null) {
			Node n = new Node();

			if (!((LikeExpression) clause).isNot()) {
				n.setType(Node.getLikeNodeType());
				n.setOperator("~");
			} else {
				n.setType(Node.getLikeNodeType());
				n.setOperator("!~");
			}
			n.setLeft(processExpression(likeNode.getLeftExpression(), fle, qStruct, plainSelect, joinType,
					dbAppParameters));
			n.setRight(processExpression(likeNode.getRightExpression(), fle, qStruct, plainSelect, joinType,
					dbAppParameters));

			n.setQueryType(2);
			n.setQueryIndex(qStruct.getWhereClauseSubqueries().size() - 1);
			return n;
		}
		return null;
	}

	/**
	 * chaitra: Handles POSIX regex match expressions (col ~ 'pattern', col i~ 'pattern',
	 * col !~ 'pattern', col !i~ 'pattern') parsed by JSQLParser as RegExpMatchOperator.
	 * Creates a bro-node so the constraint pipeline treats this like any other relational
	 * predicate. The pattern string is stored as a string constraint. When the node type
	 * is BRO NODE and the operator is ~, i~, !~, or !i~, the LLM solver is responsible
	 * for generating a satisfying value — it is instructed that this is a POSIX regex and
	 * all regex symbols (^, $, ., *, +, ?, |, [], etc.) must be treated as such.
	 */
	public static Node processExpressionForRegExpMatch(RegExpMatchOperator regexExpr,
			Vector<FromClauseElement> fle, QueryStructure qStruct, PlainSelect plainSelect,
			String joinType, AppTest_Parameters dbAppParameters) throws Exception {

		if (regexExpr.getLeftExpression() == null || regexExpr.getRightExpression() == null) {
			return null;
		}

		Node n = new Node();
		n.setType(Node.getBroNodeType());

		// Map JSQLParser RegExpMatchOperatorType to XData's internal operator strings
		RegExpMatchOperatorType opType = regexExpr.getOperatorType();
		String operator;
		if (opType == RegExpMatchOperatorType.MATCH_CASESENSITIVE) {
			operator = "~";
		} else if (opType == RegExpMatchOperatorType.MATCH_CASEINSENSITIVE) {
			operator = "i~";
		} else if (opType == RegExpMatchOperatorType.NOT_MATCH_CASESENSITIVE) {
			operator = "!~";
		} else if (opType == RegExpMatchOperatorType.NOT_MATCH_CASEINSENSITIVE) {
			operator = "!i~";
		} else {
			operator = "~"; // safe default
		}
		n.setOperator(operator);

		Node leftNode = processExpression(regexExpr.getLeftExpression(), fle, qStruct, plainSelect,
				joinType, dbAppParameters);
		Node rightNode = processExpression(regexExpr.getRightExpression(), fle, qStruct, plainSelect,
				joinType, dbAppParameters);

		n.setLeft(leftNode);
		n.setRight(rightNode);

		// Store a string constraint on the right node; prefix with REGEX: so that
		// the string constraint solver (and isComplexFunc detection) can identify
		// this as a regex operation that must be solved by the LLM.
		if (rightNode != null && rightNode.getStrConst() != null) {
			String pattern = rightNode.getStrConst();
			// Strip surrounding quotes if present (e.g. 'abc.*' -> abc.*)
			if (pattern.startsWith("'") && pattern.endsWith("'")) {
				pattern = pattern.substring(1, pattern.length() - 1);
			}
			rightNode.setStrConst("'REGEX:" + pattern + "'");
		}

		n.setQueryType(2);
		n.setQueryIndex(qStruct.getWhereClauseSubqueries().size() - 1);

		logger.log(Level.FINE, "processExpressionForRegExpMatch: created bro-node with operator="
				+ operator + " for regex expression: " + regexExpr);
		return n;
	}

	public static Node ProcessExpressionForAnd(BinaryExpression andNode, Vector<FromClauseElement> fle,
			QueryStructure qStruct, PlainSelect plainSelect, String joinType, AppTest_Parameters dbAppParameters)
			throws Exception {
		if (andNode.getLeftExpression() != null
				&& andNode.getRightExpression() != null) {
			Node n = new Node();
			Node left = new Node();
			Node right = new Node();
			n.setType(Node.getAndNodeType());
			n.setOperator("AND");
			left = processExpression(andNode.getLeftExpression(), fle, qStruct, plainSelect, joinType, dbAppParameters);
			right = processExpression(andNode.getRightExpression(), fle, qStruct, plainSelect, joinType,
					dbAppParameters);

			n.setQueryType(2);
			n.setQueryIndex(qStruct.getWhereClauseSubqueries().size() - 1);
			n.setLeft(left);
			n.setRight(right);

			return n;
		}
		return null;
	}

	public static Node ProcessExpressionForAddition(BinaryExpression baoNode, Vector<FromClauseElement> fle,
			QueryStructure qStruct, PlainSelect plainSelect, String joinType, AppTest_Parameters dbAppParameters)
			throws Exception {
		Node n = new Node();
		n.setType(Node.getBaoNodeType());
		n.setOperator("+");
		n.setLeft(processExpression(baoNode.getLeftExpression(), fle, qStruct, plainSelect, joinType, dbAppParameters));
		n.setRight(
				processExpression(baoNode.getRightExpression(), fle, qStruct, plainSelect, joinType, dbAppParameters));
		n = WhereClauseVectorJSQL.getTableDetailsForArithmeticExpressions(n);
		return n;
	}

	public static Node ProcessExpressionForSubtraction(BinaryExpression baoNode, Vector<FromClauseElement> fle,
			QueryStructure qStruct, PlainSelect plainSelect, String joinType, AppTest_Parameters dbAppParameters)
			throws Exception {
		Node n = new Node();
		n.setType(Node.getBaoNodeType());
		n.setOperator("-");
		n.setLeft(processExpression(baoNode.getLeftExpression(), fle, qStruct, plainSelect, joinType, dbAppParameters));
		n.setRight(
				processExpression(baoNode.getRightExpression(), fle, qStruct, plainSelect, joinType, dbAppParameters));
		n = WhereClauseVectorJSQL.getTableDetailsForArithmeticExpressions(n);
		return n;
	}

	public static Node ProcessExpressionForMultiplication(BinaryExpression baoNode, Vector<FromClauseElement> fle,
			QueryStructure qStruct, PlainSelect plainSelect, String joinType, AppTest_Parameters dbAppParameters)
			throws Exception {
		Node n = new Node();
		n.setType(Node.getBaoNodeType());
		n.setOperator("*");
		n.setLeft(processExpression(baoNode.getLeftExpression(), fle, qStruct, plainSelect, joinType, dbAppParameters));
		n.setRight(
				processExpression(baoNode.getRightExpression(), fle, qStruct, plainSelect, joinType, dbAppParameters));
		n = WhereClauseVectorJSQL.getTableDetailsForArithmeticExpressions(n);
		return n;
	}

	public static Node ProcessExpressionForDivision(BinaryExpression baoNode, Vector<FromClauseElement> fle,
			QueryStructure qStruct, PlainSelect plainSelect, String joinType, AppTest_Parameters dbAppParameters)
			throws Exception {
		Node n = new Node();
		n.setType(Node.getBaoNodeType());
		n.setOperator("/");
		n.setLeft(processExpression(baoNode.getLeftExpression(), fle, qStruct, plainSelect, joinType, dbAppParameters));

		// chaitra temporary hack for case expression
		// if (n.getLeft().getType().equalsIgnoreCase("CASE NODE")) {
		// 	n.setCaseExpression(n.getLeft().getCaseExpression());
		// 	n.setType("CASE NODE");
		// }
		// chaitra temporary hack for case expression
		n.setRight(
				processExpression(baoNode.getRightExpression(), fle, qStruct, plainSelect, joinType, dbAppParameters));
		n = WhereClauseVectorJSQL.getTableDetailsForArithmeticExpressions(n);
		return n;
	}

	public static Node ProcessExpressionForNotEquals(NotEqualsTo broNode, Vector<FromClauseElement> fle,
			QueryStructure qStruct, PlainSelect plainSelect, String joinType, AppTest_Parameters dbAppParameters)
			throws Exception {
		Node n = new Node();
		n.setType(Node.getBroNodeType());
		n.setOperator(QueryStructure.cvcRelationalOperators[2]);
		if (checkForSubstr(broNode)) {
			return processSubstrFunc(broNode, fle, qStruct, plainSelect, joinType, dbAppParameters, n);
		} else if (checkForLength(broNode)) {
			return processLengthFunc(broNode, fle, qStruct, plainSelect, joinType, dbAppParameters, n);
		}
		n.setLeft(processExpression(broNode.getLeftExpression(), fle, qStruct, plainSelect, joinType, dbAppParameters));
		n.setRight(
				processExpression(broNode.getRightExpression(), fle, qStruct, plainSelect, joinType, dbAppParameters));

		n.setQueryType(2);
		n.setQueryIndex(qStruct.getWhereClauseSubqueries().size() - 1);
		// the following added by mathew on 17 oct 2016
		if (n.getLeft().getType().equals(Node.getAllNodeType()) || n.getRight().getType().equals(Node.getAllNodeType())
				||
				n.getLeft().getType().equals(Node.getAnyNodeType()) ||
				n.getRight().getType().equals(Node.getAnyNodeType()))
			n.setType(Node.getBroNodeSubQType());
		else if (n.getLeft().getType().equals(Node.getColRefType())
				&& n.getRight().getType().equals(Node.getColRefType())) {
			if (joinType != null)
				n.setJoinType(joinType);
			else
				n.setJoinType(JoinClauseInfo.innerJoin);
		} else if (n.getLeft().getType().equals(Node.getBroNodeSubQType())
				|| n.getRight().getType().equals(Node.getBroNodeSubQType()))
			n.setType(Node.getBroNodeSubQType());
		return n;
	}

	public static Node ProcessExpressionForDoubleAnd(DoubleAnd broNode, Vector<FromClauseElement> fle,
			QueryStructure qStruct,
			PlainSelect plainSelect, String joinType, AppTest_Parameters dbAppParameters) throws Exception {
		Node n = new Node();
		n.setType(Node.getBroNodeType());
		n.setOperator(QueryStructure.cvcRelationalOperators[7]);
		n.setLeft(processExpression(broNode.getLeftExpression(), fle, qStruct, plainSelect, joinType, dbAppParameters));
		n.setRight(
				processExpression(broNode.getRightExpression(), fle, qStruct, plainSelect, joinType, dbAppParameters));

		return n;
	}

	public static Node ProcessExpressionForIsNull(IsNullExpression isNullNode, Vector<FromClauseElement> fle,
			QueryStructure qStruct, PlainSelect plainSelect, String joinType, AppTest_Parameters dbAppParameters)
			throws Exception {
		Node n = new Node();
		n.setType(Node.getIsNullNodeType());
		n.setLeft(processExpression(isNullNode.getLeftExpression(), fle, qStruct, plainSelect, joinType,
				dbAppParameters));
		if (isNullNode.isNot()) {
			n.setOperator("!=");
		} else {
			n.setOperator("=");
		}
		n.setRight(null);
		return n;
	}

	public static Node ProcessExpressionForIsBoolean(IsBooleanExpression isBooleanNode, Vector<FromClauseElement> fle,
			QueryStructure qStruct, PlainSelect plainSelect, String joinType, AppTest_Parameters dbAppParameters)
			throws Exception {

		Node left = processExpression(isBooleanNode.getLeftExpression(), fle, qStruct, plainSelect, joinType,
				dbAppParameters);
		Node boolValue = createBooleanValueNode(isBooleanNode.isTrue());

		if (!isBooleanNode.isNot()) {
			Node n = new Node();
			n.setType(Node.getBroNodeType());
			n.setOperator("=");
			n.setLeft(left);
			n.setRight(boolValue);
			return n;
		}

		Node comparisonNode = new Node();
		comparisonNode.setType(Node.getBroNodeType());
		comparisonNode.setOperator("=");
		comparisonNode.setLeft(left);
		comparisonNode.setRight(createBooleanValueNode(!isBooleanNode.isTrue()));
		logger.log(Level.INFO,
				"ProcessExpressionForIsBoolean: comparison branch for IS NOT = " + comparisonNode
						+ ", right strConst = "
						+ (comparisonNode.getRight() != null ? comparisonNode.getRight().getStrConst() : "null"));

		Node isNullNode = new Node();
		isNullNode.setType(Node.getIsNullNodeType());
		isNullNode.setOperator("=");
		isNullNode.setLeft(processExpression(isBooleanNode.getLeftExpression(), fle, qStruct, plainSelect, joinType,
				dbAppParameters));
		isNullNode.setRight(null);
		logger.log(Level.INFO, "ProcessExpressionForIsBoolean: null branch for IS NOT = " + isNullNode
				+ ", type = " + isNullNode.getType() + ", operator = " + isNullNode.getOperator()
				+ ", left = " + isNullNode.getLeft());

		Node orNode = new Node();
		orNode.setType(Node.getOrNodeType());
		orNode.setOperator("OR");
		orNode.setLeft(comparisonNode);
		orNode.setRight(isNullNode);
		logger.log(Level.INFO, "ProcessExpressionForIsBoolean: returning OR node = " + orNode
				+ ", left type = " + (orNode.getLeft() != null ? orNode.getLeft().getType() : "null")
				+ ", right type = " + (orNode.getRight() != null ? orNode.getRight().getType() : "null"));
		return orNode;
	}

	private static Node createBooleanValueNode(boolean value) {
		Node n = new Node();
		n.setType(Node.getValType());
		n.setStrConst(value ? "TRUE" : "FALSE");
		n.setLeft(null);
		n.setRight(null);
		return n;
	}

	public static Node ProcessExpressionForIn(InExpression sqn, Vector<FromClauseElement> fle, QueryStructure qStruct,
			PlainSelect plainSelect, String joinType, AppTest_Parameters dbAppParameters) throws Exception {
		ParenthesedSelect subS = null;
		Node inNode = new Node();
		inNode.setType(Node.getInNodeType());
		Node notNode = new Node();
		Node rhs = new Node();
		if (sqn.getRightExpression() instanceof ExpressionList) {
			Node lhs = processExpression(sqn.getLeftExpression(), fle, qStruct, plainSelect, joinType, dbAppParameters);
			ExpressionList exprList = (ExpressionList) sqn.getRightExpression();
			List<Expression> expList = exprList.getExpressions();
			rhs = new Node(true);
			rhs.isComposite = true;
			rhs.setType(Node.getCompositeNodeType());
			for (Expression exp : expList) {
				Node tempNode = processExpression(exp, fle, qStruct, plainSelect, joinType, dbAppParameters);
				rhs.addComponentNode(tempNode);
				inNode.setLeft(lhs);
				inNode.setRight(rhs);
			}
			if (!sqn.isNot()) {
				logger.log(Level.FINE, " Composite In node" + inNode);
				return inNode;
			} else {
				notNode.setType(Node.getNotNodeType());
				notNode.setRight(null);
				notNode.setLeft(inNode);
				logger.log(Level.FINE, " Composite In node" + notNode);
				return notNode;

			}
		} else if (sqn.getLeftExpression() instanceof ParenthesedSelect) {
			subS = (ParenthesedSelect) sqn.getLeftExpression();
		} else if (sqn.getRightExpression() instanceof ParenthesedSelect) {
			subS = (ParenthesedSelect) sqn.getRightExpression();
		}
		QueryStructure subQueryParser = new QueryStructure(qStruct.getTableMap());
		rhs.setSubQueryStructure(subQueryParser);
		processWhereParenthesedSelect(subS, subQueryParser, qStruct, dbAppParameters);

		Node lhs = processExpression(sqn.getLeftExpression(), fle, qStruct, plainSelect, joinType, dbAppParameters);

		inNode.setLeft(lhs);
		inNode.setRight(rhs);

		inNode.setQueryType(2);
		inNode.setQueryIndex(qStruct.getWhereClauseSubqueries().size() - 1);
		if (!sqn.isNot()) {
			return inNode;
		} else {
			notNode.setType(Node.getNotNodeType());

			notNode.setQueryType(2);
			notNode.setQueryIndex(qStruct.getWhereClauseSubqueries().size() - 1);
			notNode.setRight(null);
			notNode.setLeft(inNode);
			return notNode;

		}
	}

	public static Node ProcessExpressionForExists(ExistsExpression sqn, Vector<FromClauseElement> fle,
			QueryStructure qStruct,
			PlainSelect plainSelect, String joinType, AppTest_Parameters dbAppParameters) throws Exception {

		ParenthesedSelect subS = (ParenthesedSelect) sqn.getRightExpression();
		QueryStructure subQueryParser = new QueryStructure(qStruct.getTableMap());
		Node existsNode = new Node();
		existsNode.setSubQueryStructure(subQueryParser);
		existsNode.setType(Node.getExistsNodeType());
		existsNode.setSubQueryConds(null);
		processWhereParenthesedSelect(subS, subQueryParser, qStruct, dbAppParameters);

		existsNode.setQueryType(2);
		existsNode.setQueryIndex(qStruct.getWhereClauseSubqueries().size() - 1);

		Node notNode = new Node();

		if (!sqn.isNot()) {
			return existsNode;
		} else {
			notNode.setType(Node.getNotNodeType());
			notNode.setRight(null);

			notNode.setQueryType(2);
			notNode.setQueryIndex(qStruct.getWhereClauseSubqueries().size() - 1);
			notNode.setLeft(existsNode);
			return notNode;

		}
	}

	public static Node ProcessExpressionForParenthesedSelect(ParenthesedSelect sqn, Vector<FromClauseElement> fle,
			QueryStructure qStruct,
			PlainSelect plainSelect, String joinType, AppTest_Parameters dbAppParameters) throws Exception {
		QueryStructure subQueryParser = new QueryStructure(qStruct.getTableMap());
		Node node = new Node();
		node.setSubQueryStructure(subQueryParser);
		node.setType(Node.getBroNodeSubQType());
		processWhereParenthesedSelect(sqn, subQueryParser, qStruct, dbAppParameters);

		node.setQueryType(2);
		node.setQueryIndex(qStruct.getWhereClauseSubqueries().size() - 1);

		List<SelectItem<?>> rcList = ((PlainSelect) sqn.getSelect()).getSelectItems();

		SelectItem rc = (SelectItem) rcList.get(0);
		node.setQueryIndex(qStruct.getWhereClauseSubqueries().size() - 1);
		if (rc.getExpression() instanceof Function) {
			return node;
		} else if (rc.getExpression() instanceof Parenthesis
				&& (((Parenthesis) rc.getExpression()).getExpression()) instanceof Column) {
			// the result of subquery must be a single tuple
			logger.log(Level.WARNING, "the result of subquery must be a single tuple");
		}

		else {
			// It is a scalar subquery that returns only one value
			Node retNode = new Node();
			retNode.setQueryType(2);
			retNode.setQueryIndex(qStruct.getWhereClauseSubqueries().size() - 1);

			retNode.setType(Node.getBroNodeSubQType());
			retNode.setLhsRhs(node);

			if (node.getSubQueryStructure() != null && node.getSubQueryStructure().getAllDnfSelCond() != null
					&& !node.getSubQueryStructure().getAllDnfSelCond().isEmpty()) {
				/// Check .get(0) - again
				retNode.setSubQueryConds(node.getSubQueryStructure().getAllDnfSelCond().get(0));
			}

			if (qStruct.getWhereClauseSubqueries() != null && !qStruct.getWhereClauseSubqueries().isEmpty()) {

				if (!qStruct.getWhereClauseSubqueries().get(0).getConjuncts().isEmpty()
						&& qStruct.getWhereClauseSubqueries().get(0).getConjuncts().get(0).selectionConds != null
						&& !qStruct.getWhereClauseSubqueries().get(0).getConjuncts().get(0).selectionConds.isEmpty()) {
					if(retNode.subQueryConds==null)
							return node;
					qStruct.getWhereClauseSubqueries().get(0).getConjuncts().get(0).selectionConds
							.addAll(retNode.getSubQueryConds());

					for (Node nod : retNode.getSubQueryConds()) {

						if (ConjunctQueryStructure.isStringSelection(nod, 1)) {
							String str = nod.getRight().getStrConst();
							qStruct.getWhereClauseSubqueries().get(0).getConjuncts().get(0).stringSelectionConds
									.add(nod);
							qStruct.getWhereClauseSubqueries().get(0).getConjuncts().get(0).selectionConds.remove(nod);
						} else if (ConjunctQueryStructure.isStringSelection(nod, 0)) {
							qStruct.getWhereClauseSubqueries().get(0).getConjuncts().get(0).stringSelectionConds
									.add(nod);
							qStruct.getWhereClauseSubqueries().get(0).getConjuncts().get(0).selectionConds.remove(nod);
						}
					}
				}
			}
			return retNode;
		}

		return node;
	}

	public static Node ProcessExpressionForBetween(Between bn, Vector<FromClauseElement> fle, QueryStructure qStruct,
			PlainSelect plainSelect, String joinType, AppTest_Parameters dbAppParameters) throws Exception {
		Node n = new Node();
		if (bn.getLeftExpression() instanceof Function) {
			Function func = (Function) bn.getLeftExpression();
			Expression colExpr = func.getParameters().getExpressions().get(0);
			Expression startExpr = func.getParameters().getExpressions().get(1);
			Expression lengthExpr = null;
			if (func.getParameters().size() > 2)
				lengthExpr = func.getParameters().getExpressions().get(2);

			Expression betweenStart = bn.getBetweenExpressionStart();
			Expression betweenEnd = bn.getBetweenExpressionEnd();

			// Create: substr(col, start, offset) >= 'xx'
			Function func1 = new Function();
			func1.setName("SUBSTR");
			ExpressionList paramList1 = new ExpressionList();
			paramList1.setExpressions(Arrays.asList(colExpr, startExpr, lengthExpr));
			func1.setParameters(paramList1);
			GreaterThanEquals gteExpr = new GreaterThanEquals();
			gteExpr.setLeftExpression(func1);
			gteExpr.setRightExpression(betweenStart);

			// Create: substr(col, start, offset) <= 'xx'
			Function func2 = new Function();
			func2.setName("SUBSTR");
			ExpressionList paramList2 = new ExpressionList();
			paramList2.setExpressions(Arrays.asList(colExpr, startExpr, lengthExpr));
			func2.setParameters(paramList2);
			MinorThanEquals lteExpr = new MinorThanEquals();
			lteExpr.setLeftExpression(func2);
			lteExpr.setRightExpression(betweenEnd);

			// Process both expressions
			// Node leftNode = processExpression(gteExpr, fle, qStruct, plainSelect,
			// joinType, dbAppParameters);
			// Node rightNode = processExpression(lteExpr, fle, qStruct, plainSelect,
			// joinType, dbAppParameters);
			AndExpression andNode = new AndExpression();
			andNode.setLeftExpression(gteExpr);
			andNode.setRightExpression(lteExpr);
			return processExpression(andNode, fle, qStruct, plainSelect, joinType, dbAppParameters);
			// Combine with AND
			// Node root = new Node();
			// root.setType(Node.getAndNodeType());
			// root.setLeft(leftNode);
			// root.setRight(rightNode);
			// return root;
		}
		n.setType(Node.getAndNodeType());
		n.setQueryType(2);
		n.setQueryIndex(qStruct.getWhereClauseSubqueries().size() - 1);
		if (bn.getLeftExpression() instanceof Function) {
			Function func = (Function) bn.getLeftExpression();
			String functionName = func.getName().toLowerCase();

			// Check for function name 'substring' or 'substr'
			if (functionName.equals("substr") || functionName.equals("substring")) {
				Expression colExpr = func.getParameters().getExpressions().get(0);
				Expression startExpr = func.getParameters().getExpressions().get(1);
				Expression lengthExpr = null;
				if (func.getParameters().size() > 2)
					lengthExpr = func.getParameters().getExpressions().get(2);

				Expression betweenStart = bn.getBetweenExpressionStart();
				Expression betweenEnd = bn.getBetweenExpressionEnd();

				// Create: substr(col, start, offset) >= 'xx'
				Function func1 = new Function();
				func1.setName("SUBSTR");
				ExpressionList paramList1 = new ExpressionList();
				paramList1.setExpressions(Arrays.asList(colExpr, startExpr, lengthExpr));
				func1.setParameters(paramList1);
				GreaterThanEquals gteExpr = new GreaterThanEquals();
				gteExpr.setLeftExpression(func1);
				gteExpr.setRightExpression(betweenStart);

				// Create: substr(col, start, offset) <= 'xx'
				Function func2 = new Function();
				func2.setName("SUBSTR");
				ExpressionList paramList2 = new ExpressionList();
				paramList2.setExpressions(Arrays.asList(colExpr, startExpr, lengthExpr));
				func2.setParameters(paramList2);
				MinorThanEquals lteExpr = new MinorThanEquals();
				lteExpr.setLeftExpression(func2);
				lteExpr.setRightExpression(betweenEnd);

				// Combine both into AND
				AndExpression andNode = new AndExpression(gteExpr, lteExpr);
				return processExpression(andNode, fle, qStruct, plainSelect, joinType, dbAppParameters);
			}
		}
		Node l = new Node();
		l.setLeft(processExpression(bn.getLeftExpression(), fle, qStruct, plainSelect, joinType, dbAppParameters));
		l.setOperator(">=");
		l.setRight(processExpression(bn.getBetweenExpressionStart(), fle, qStruct, plainSelect, joinType,
				dbAppParameters));
		l.setType(Node.getBroNodeType());
		n.setLeft(l);

		Node r = new Node();
		r.setLeft(processExpression(bn.getLeftExpression(), fle, qStruct, plainSelect, joinType, dbAppParameters));
		r.setOperator("<=");
		r.setRight(
				processExpression(bn.getBetweenExpressionEnd(), fle, qStruct, plainSelect, joinType, dbAppParameters));
		r.setType(Node.getBroNodeType());
		n.setRight(r);

		return n;
	}

	public static Node processExpressionForGreaterThan(GreaterThan broNode, Vector<FromClauseElement> fle,
			QueryStructure qStruct, PlainSelect plainSelect, String joinType, AppTest_Parameters dbAppParameters)
			throws Exception {
		Node n = new Node();
		n.setType(Node.getBroNodeType());
		n.setOperator(QueryStructure.cvcRelationalOperators[3]);
		if (checkForSubstr(broNode)) {
			return processSubstrFunc(broNode, fle, qStruct, plainSelect, joinType, dbAppParameters, n);
		} else if (checkForLength(broNode)) {
			return processLengthFunc(broNode, fle, qStruct, plainSelect, joinType, dbAppParameters, n);
		}
		n.setLeft(processExpression(broNode.getLeftExpression(), fle, qStruct, plainSelect, joinType, dbAppParameters));
		n.setRight(
				processExpression(broNode.getRightExpression(), fle, qStruct, plainSelect, joinType, dbAppParameters));

		// //parismita - scalar
		// if(n.getRight().getType().equals(Node.getBroNodeSubQType())){
		// n.setRight(n.getRight().getLhsRhs());
		// }
		n.setQueryType(2);
		n.setQueryIndex(qStruct.getWhereClauseSubqueries().size() - 1);

		if (n.getLeft() != null && n.getLeft().getSubQueryConds() != null && n.getLeft().getSubQueryConds().size() > 0
				&& n.getSubQueryConds() != null) {
			n.setSubQueryConds(n.getLeft().getSubQueryConds());
			n.getLeft().getSubQueryConds().clear();
		} else {
			if (n.getRight() != null && n.getRight().getSubQueryConds() != null
					&& n.getRight().getSubQueryConds().size() > 0 && n.getSubQueryConds() != null) {
				n.setSubQueryConds(n.getRight().getSubQueryConds());
				n.getRight().getSubQueryConds().clear();
			}
		}

		/*
		 * commented by mathew on 17 october 2016
		 * if(((GreaterThan) clause).getRightExpression() instanceof
		 * Expression ||
		 * ((GreaterThan) clause).getLeftExpression() instanceof
		 * Expression){
		 * 
		 * Node sqNode = new Node();
		 * sqNode.setType(Node.getAllNodeType());
		 * if(n.getLeft().getSubQueryConds() != null &&
		 * n.getLeft().getSubQueryConds().size() > 0){
		 * sqNode.setSubQueryConds(n.getLeft().getSubQueryConds());
		 * n.getLeft().getSubQueryConds().clear();
		 * }
		 * else{
		 * if(n.getRight()!=null&&n.getRight().getSubQueryConds()!=null&&n.getRight().
		 * getSubQueryConds().size()>0 && sqNode.getSubQueryConds()!=null)
		 * { sqNode.setSubQueryConds(n.getRight().getSubQueryConds());
		 * n.getRight().getSubQueryConds().clear();
		 * }
		 * }
		 * sqNode.setLhsRhs(n);
		 * return sqNode;
		 * }
		 * 
		 * if(((GreaterThan) clause).getRightExpression() instanceof
		 * AnyComparisonExpression ||
		 * ((GreaterThan) clause).getLeftExpression() instanceof
		 * AnyComparisonExpression){
		 * Node sqNode = new Node();
		 * sqNode.setType(Node.getAnyNodeType());
		 * if(n.getLeft().getSubQueryConds() != null &&
		 * n.getLeft().getSubQueryConds().size() > 0){
		 * sqNode.setSubQueryConds(n.getLeft().getSubQueryConds());
		 * n.getLeft().getSubQueryConds().clear();
		 * }
		 * else{
		 * if(n.getRight()!=null&&n.getRight().getSubQueryConds()!=null&&n.getRight().
		 * getSubQueryConds().size()>0 && sqNode.getSubQueryConds()!=null)
		 * { sqNode.setSubQueryConds(n.getRight().getSubQueryConds());
		 * sqNode.setSubQueryConds(n.getRight().getSubQueryConds());
		 * n.getRight().getSubQueryConds().clear();
		 * }
		 * }
		 * sqNode.setLhsRhs(n);
		 * return sqNode;
		 * }
		 */

		// the following added by mathew on 17 oct 2016
		if (n.getLeft().getType().equals(Node.getAllNodeType()) || n.getRight().getType().equals(Node.getAllNodeType())
				||
				n.getLeft().getType().equals(Node.getAnyNodeType()) ||
				n.getRight().getType().equals(Node.getAnyNodeType()))
			n.setType(Node.getBroNodeSubQType());
		else if (n.getLeft().getType().equals(Node.getColRefType())
				&& n.getRight().getType().equals(Node.getColRefType())) {
			if (joinType != null)
				n.setJoinType(joinType);
			else
				n.setJoinType(JoinClauseInfo.innerJoin);
		}

		return n;
	}

	public static Node processExpressionForGreaterThanEquals(GreaterThanEquals broNode,
			Vector<FromClauseElement> fles, QueryStructure qStruct, PlainSelect plainSelect, String joinType,
			AppTest_Parameters dbAppParameters) throws Exception {
		Node n = new Node();
		n.setType(Node.getBroNodeType());
		n.setOperator(QueryStructure.cvcRelationalOperators[4]);
		if (checkForSubstr(broNode)) {
			return processSubstrFunc(broNode, fles, qStruct, plainSelect, joinType, dbAppParameters, n);
		} else if (checkForLength(broNode)) {
			return processLengthFunc(broNode, fles, qStruct, plainSelect, joinType, dbAppParameters, n);
		}
		n.setLeft(
				processExpression(broNode.getLeftExpression(), fles, qStruct, plainSelect, joinType, dbAppParameters));
		n.setRight(
				processExpression(broNode.getRightExpression(), fles, qStruct, plainSelect, joinType, dbAppParameters));

		n.setQueryType(2);
		n.setQueryIndex(qStruct.getWhereClauseSubqueries().size() - 1);

		// Storing sub query details
		// Code added for ALL / ANY subqueries - Start
		// FIXME ANy condition needs to be tested - IS this correct???
		if (n.getLeft() != null && n.getLeft().getSubQueryConds() != null
				&& n.getLeft().getSubQueryConds().size() > 0) {
			n.setSubQueryConds(n.getLeft().getSubQueryConds());
			n.getLeft().getSubQueryConds().clear();
		} else {
			if (n.getRight() != null && n.getRight().getSubQueryConds() != null
					&& n.getRight().getSubQueryConds().size() > 0) {
				n.setSubQueryConds(n.getRight().getSubQueryConds());
				n.getRight().getSubQueryConds().clear();
			}
		}

		// the following added by mathew on 17 oct 2016
		if (n.getLeft().getType().equals(Node.getAllNodeType()) || n.getRight().getType().equals(Node.getAllNodeType())
				||
				n.getLeft().getType().equals(Node.getAnyNodeType()) ||
				n.getRight().getType().equals(Node.getAnyNodeType()))
			n.setType(Node.getBroNodeSubQType());
		else if (n.getLeft().getType().equals(Node.getColRefType())
				&& n.getRight().getType().equals(Node.getColRefType())) {
			if (joinType != null)
				n.setJoinType(joinType);
			else
				n.setJoinType(JoinClauseInfo.innerJoin);
		}

		return n;
	}

	public static Node processExpressionForMinorThan(BinaryExpression bne, Vector<FromClauseElement> fle,
			QueryStructure qStruct, PlainSelect plainSelect, String joinType, AppTest_Parameters dbAppParameters)
			throws Exception {
		Node n = new Node();
		n.setType(Node.getBroNodeType());
		n.setOperator(QueryStructure.cvcRelationalOperators[5]);
		if (checkForSubstr(bne)) {
			return processSubstrFunc(bne, fle, qStruct, plainSelect, joinType, dbAppParameters, n);
		} else if (checkForLength(bne)) {
			return processLengthFunc(bne, fle, qStruct, plainSelect, joinType, dbAppParameters, n);
		}
		n.setLeft(processExpression(bne.getLeftExpression(), fle, qStruct, plainSelect, joinType, dbAppParameters));
		n.setRight(processExpression(bne.getRightExpression(), fle, qStruct, plainSelect, joinType, dbAppParameters));

		n.setQueryType(2);
		n.setQueryIndex(qStruct.getWhereClauseSubqueries().size() - 1);

		if (n.getLeft() != null && n.getLeft().getSubQueryConds() != null
				&& n.getLeft().getSubQueryConds().size() > 0) {
			n.setSubQueryConds(n.getLeft().getSubQueryConds());
			n.getLeft().getSubQueryConds().clear();
		} else {
			if (n.getRight() != null && n.getRight().getSubQueryConds() != null
					&& n.getRight().getSubQueryConds().size() > 0) {
				n.setSubQueryConds(n.getRight().getSubQueryConds());
				n.getRight().getSubQueryConds().clear();
			}
		}

		// the following added by mathew on 17 oct 2016
		if (n.getLeft().getType().equals(Node.getAllNodeType()) || n.getRight().getType().equals(Node.getAllNodeType())
				||
				n.getLeft().getType().equals(Node.getAnyNodeType()) ||
				n.getRight().getType().equals(Node.getAnyNodeType()))
			n.setType(Node.getBroNodeSubQType());
		else if (n.getLeft().getType().equals(Node.getColRefType())
				&& n.getRight().getType().equals(Node.getColRefType())) {
			if (joinType != null)
				n.setJoinType(joinType);
			else
				n.setJoinType(JoinClauseInfo.innerJoin);
		}
		return n;
	}

	public static Node processExpressionForMinorThanEquals(BinaryExpression bne, Vector<FromClauseElement> fle,
			QueryStructure qStruct, PlainSelect plainSelect, String joinType, AppTest_Parameters dbAppParameters)
			throws Exception {
		Node n = new Node();
		n.setType(Node.getBroNodeType());

		n.setOperator(QueryStructure.cvcRelationalOperators[6]);
		if (checkForSubstr(bne)) {
			return processSubstrFunc(bne, fle, qStruct, plainSelect, joinType, dbAppParameters, n);
		} else if (checkForLength(bne)) {
			return processLengthFunc(bne, fle, qStruct, plainSelect, joinType, dbAppParameters, n);
		}
		n.setLeft(processExpression(bne.getLeftExpression(), fle, qStruct, plainSelect, joinType, dbAppParameters));
		n.setRight(processExpression(bne.getRightExpression(), fle, qStruct, plainSelect, joinType, dbAppParameters));

		n.setQueryType(2);
		n.setQueryIndex(qStruct.getWhereClauseSubqueries().size() - 1);

		if (n.getLeft() != null && n.getLeft().getSubQueryConds() != null
				&& n.getLeft().getSubQueryConds().size() > 0) {
			n.setSubQueryConds(n.getLeft().getSubQueryConds());
			n.getLeft().getSubQueryConds().clear();
		} else {
			if (n.getRight() != null && n.getRight().getSubQueryConds() != null
					&& n.getRight().getSubQueryConds().size() > 0) {
				n.setSubQueryConds(n.getRight().getSubQueryConds());
				n.getRight().getSubQueryConds().clear();
			}
		}

		// the following added by mathew on 17 oct 2016
		if (n.getLeft().getType().equals(Node.getAllNodeType()) || n.getRight().getType().equals(Node.getAllNodeType())
				||
				n.getLeft().getType().equals(Node.getAnyNodeType()) ||
				n.getRight().getType().equals(Node.getAnyNodeType()))
			n.setType(Node.getBroNodeSubQType());
		else if (n.getLeft().getType().equals(Node.getColRefType())
				&& n.getRight().getType().equals(Node.getColRefType())) {
			if (joinType != null)
				n.setJoinType(joinType);
			else
				n.setJoinType(JoinClauseInfo.innerJoin);
		}
		return n;
	}

	public static Node processExpressionForCaseExpression(CaseExpression caseExpr,
			Vector<FromClauseElement> fromListElements,
			QueryStructure qStruct, PlainSelect plainSelect, AppTest_Parameters dbAppParameters) throws Exception {

		List<WhenClause> whenClauses = caseExpr.getWhenClauses();
		Expression switchExpression = caseExpr.getSwitchExpression();
		Node switchExpressionNode = processExpression(switchExpression, qStruct.fromListElements, qStruct, plainSelect,
				null, dbAppParameters);
		parsing.CaseExpression retCaseExpr = new parsing.CaseExpression();
		ArrayList<CaseCondition> whenConditionals = new ArrayList<CaseCondition>();

		for (Expression whenClauseExpr : whenClauses) {
			WhenClause whenClause = (WhenClause) whenClauseExpr;
			logger.log(Level.FINE, " when exp: " + whenClause.getWhenExpression() + " then expression "
					+ whenClause.getThenExpression());
			Node antecedentNode = processExpression(whenClause.getWhenExpression(), qStruct.fromListElements, qStruct,
					plainSelect, null, dbAppParameters);

			Node consequentNode = processExpression(whenClause.getThenExpression(), qStruct.fromListElements, qStruct,
					plainSelect, null, dbAppParameters);

			// chaitra set datatype of case-then 
			if (whenClause.getThenExpression() instanceof StringValue)
				consequentNode.type = "String";
			else if (whenClause.getThenExpression() instanceof LongValue)
				consequentNode.type = "int";
			else if (whenClause.getThenExpression() instanceof DoubleValue)
				consequentNode.type = "real";
			// chaitra set datatype of case-then end

			if (switchExpression != null) {
				Node tempNode = new Node();
				tempNode.setType(Node.getBroNodeType());
				tempNode.setOperator(QueryStructure.cvcRelationalOperators[1]);
				tempNode.setLeft(switchExpressionNode);
				tempNode.setRight(antecedentNode);
				antecedentNode = tempNode;
			}
			CaseCondition cC = new CaseCondition();
			cC.setWhenNode(antecedentNode);
			cC.setThenNode(consequentNode);
			whenConditionals.add(cC);

		}
		retCaseExpr.setWhenConditionals(whenConditionals);

		if (caseExpr.getElseExpression() != null) {
			CaseCondition cC = new CaseCondition();
			Node consequestNode = processExpression(caseExpr.getElseExpression(), qStruct.fromListElements, qStruct,
					plainSelect, null, dbAppParameters);

			// chaitra set datatype of case-else
			if (caseExpr.getElseExpression() instanceof StringValue)
				consequestNode.type = "String";
			else if (caseExpr.getElseExpression() instanceof LongValue)
				consequestNode.type = "int";
			else if (caseExpr.getElseExpression() instanceof DoubleValue)
				consequestNode.type = "real";
			// chaitra set datatype of case-else

			cC.setThenNode(consequestNode);
			retCaseExpr.setElseConditional(cC);
		}
		Node retNode = new Node();
		retNode.setType(Node.getCaseNodeType());
		retNode.setCaseExpression(retCaseExpr);
		retNode.setColumn(setCaseProjectionColumn(retCaseExpr.whenConditionals.get(0).whenNode));
		retNode.setTable(retNode.getColumn().getTable());
		retNode.setTableNameNo(retNode.getColumn().getTableName());
		// chaitra added column and table for case node here
		return retNode;
	}

	public static Node processExpressionForAllComparison(Expression ace, QueryStructure qStruct,
			AppTest_Parameters dbAppParameters) throws Exception {

		AnyComparisonExpression ac = null;
		if (ace instanceof AnyComparisonExpression) {
			ac = (AnyComparisonExpression) ace;
		}
		ParenthesedSelect ss = (ParenthesedSelect) ac.getSelect();

		QueryStructure subQueryParser = new QueryStructure(qStruct.getTableMap());
		Node allNode = new Node();
		allNode.setSubQueryStructure(subQueryParser);
		allNode.setType(Node.getAllNodeType());
		processWhereParenthesedSelect(ss, subQueryParser, qStruct, dbAppParameters);

		allNode.setQueryType(2);
		allNode.setQueryIndex(qStruct.getWhereClauseSubqueries().size() - 1);
		return allNode;
	}

	public static Node processExpressionForAnyComparison(Expression ace, QueryStructure qStruct,
			AppTest_Parameters dbAppParameters) throws Exception {
		AnyComparisonExpression ac = null;
		if (ace instanceof AnyComparisonExpression) {
			ac = (AnyComparisonExpression) ace;
		}
		ParenthesedSelect ss = (ParenthesedSelect) ac.getSelect();

		QueryStructure subQueryParser = new QueryStructure(qStruct.getTableMap());
		Node anyNode = new Node();
		anyNode.setSubQueryStructure(subQueryParser);
		anyNode.setType(Node.getAnyNodeType());
		processWhereParenthesedSelect(ss, subQueryParser, qStruct, dbAppParameters);

		anyNode.setQueryType(2);
		anyNode.setQueryIndex(qStruct.getWhereClauseSubqueries().size() - 1);
		return anyNode;
	}

	public static Node processExpressionForExtract(ExtractExpression exp, Vector<FromClauseElement> fle,
			QueryStructure qStruct, PlainSelect plainSelect, String joinType, AppTest_Parameters dbAppParameters)
			throws Exception {

		Node n = new Node(); // Main node
		n.setType(Node.getExtractFuncType());
		if (exp.getName() != null) {
			n.setStrConst(exp.getName());
		}
		if (exp.getExpression() != null) {
			Node n1 = processExpression(exp.getExpression(), fle, qStruct, plainSelect, joinType, dbAppParameters);
			n.setLeft(n1);
			// n.setColumn(n1.getColumn());
		}
		n.setRight(null);
		logger.log(Level.FINE, "Extract expression processed" + n);
		return n;

	}

	public static Node ProcessExpressionForEqualsTo(BinaryExpression bne, Vector<FromClauseElement> fle,
			QueryStructure qStruct,
			PlainSelect plainSelect, String joinType, AppTest_Parameters dbAppParameters) throws Exception {
		Node n = new Node();
		n.setType(Node.getBroNodeType());
		n.setOperator("=");
		if (checkForSubstr(bne)) {
			return processSubstrFunc(bne, fle, qStruct, plainSelect, joinType, dbAppParameters, n);
		} else if (checkForLength(bne)) {
			return processLengthFunc(bne, fle, qStruct, plainSelect, joinType, dbAppParameters, n);
		}
		Node ndl = processExpression(bne.getLeftExpression(), fle, qStruct, plainSelect, joinType, dbAppParameters);
		if (ndl != null) {
			n.setLeft(ndl);
		}
		Node ndr = processExpression(bne.getRightExpression(), fle, qStruct, plainSelect, joinType, dbAppParameters);
		if (ndr != null) {
			n.setRight(ndr);
		}

		if ((ndl == null && ndr == null)) {
			return null;
		}

		// the following added by mathew on 17 oct 2016
		if (n.getLeft().getType().equals(Node.getAllNodeType()) || n.getRight().getType().equals(Node.getAllNodeType())
				||
				n.getLeft().getType().equals(Node.getAnyNodeType()) ||
				n.getRight().getType().equals(Node.getAnyNodeType()))
			n.setType(Node.getBroNodeSubQType());
		else if (n.getLeft().getType().equals(Node.getColRefType())
				&& n.getRight().getType().equals(Node.getColRefType())) {
			if (joinType != null)
				n.setJoinType(joinType);
			else
				n.setJoinType(JoinClauseInfo.innerJoin);
		}

		n.setQueryType(2);
		n.setQueryIndex(qStruct.getWhereClauseSubqueries().size() - 1);
		return n;
	}

	public static boolean checkForSubstr(BinaryExpression bne) {
		if (bne.getLeftExpression() instanceof Function) {
			Function func = (Function) bne.getLeftExpression();
			if (func.getName().equalsIgnoreCase("substr") || func.getName().equalsIgnoreCase("substring")) {
				return true;
			}
		}
		return false;
	}

	public static Node processSubstrFunc(BinaryExpression bne, Vector<FromClauseElement> fle,
			QueryStructure qStruct,
			PlainSelect plainSelect, String joinType, AppTest_Parameters dbAppParameters, Node n) throws Exception {
		Expression leftExp = bne.getLeftExpression();
		Expression rightExp = bne.getRightExpression();
		Function func = (Function) leftExp;

		// n.setOperator("substr");
		Expression colExpr = func.getParameters().getExpressions().get(0);
		Expression startExpr = func.getParameters().getExpressions().get(1);
		Expression lengthExpr = null;
		if (func.getParameters().size() > 2)
			lengthExpr = func.getParameters().getExpressions().get(2);

		n.setLeft(processExpression(colExpr, fle, qStruct, plainSelect, joinType, dbAppParameters));
		Node right = new Node();
		right.setType(Node.getValType());
		String val;
		// val = "[" + startExpr.toString() + "," + lengthExpr==null?"":lengthExpr.toString() + "]" + ((StringValue) rightExp).getValue();
		val = 	"[" 
				+ startExpr.toString() 
				+ "," 
				+ (lengthExpr == null ? "" : lengthExpr.toString())
				+ "]"
				+ ((StringValue) rightExp).getValue();

		right.setStrConst(val);
		right.setLeft(null);
		right.setRight(null);
		n.setRight(right);
		n.setQueryType(2);
		n.setQueryIndex(qStruct.getWhereClauseSubqueries().size() - 1);
		return n;
	}

	public static boolean checkForLength(BinaryExpression bne) {
		if (bne.getLeftExpression() instanceof Function) {
			Function func = (Function) bne.getLeftExpression();
			if (func.getName().equalsIgnoreCase("length") || func.getName().equalsIgnoreCase("len")) {
				return true;
			}
		}
		return false;
	}

	public static Node processLengthFunc(BinaryExpression bne, Vector<FromClauseElement> fle,
			QueryStructure qStruct,
			PlainSelect plainSelect, String joinType, AppTest_Parameters dbAppParameters, Node n) throws Exception {
		Expression leftExp = bne.getLeftExpression();
		Expression rightExp = bne.getRightExpression();
		Function func = (Function) leftExp;

		Expression colExpr = func.getParameters().getExpressions().get(0);
		n.setLeft(processExpression(colExpr, fle, qStruct, plainSelect, joinType, dbAppParameters));
		Node right = new Node();
		right.setType(Node.getValType());
		
		String val = "LEN:" + rightExp.toString();

		right.setStrConst(val);
		right.setLeft(null);
		right.setRight(null);
		n.setRight(right);
		n.setQueryType(2);
		n.setQueryIndex(qStruct.getWhereClauseSubqueries().size() - 1);
		return n;
	}

	public static Node ProcessExpressionForAnalyticalExpression(AnalyticExpression an, Vector<FromClauseElement> fle,
			QueryStructure qStruct,
			PlainSelect plainSelect, String joinType, AppTest_Parameters dbAppParameters) throws Exception {

		String funcName = an.getName();
		Expression anExp = an.getExpression();

		if (!(funcName.contains("rank") || funcName.contains("RANK"))) {
			Node n = processExpression(anExp, fle, qStruct, plainSelect, joinType, dbAppParameters);
			n.setType("ANALYTICAL NODE");
			n.windowAggString = funcName;

			ExpressionList exList = an.getPartitionExpressionList();
			List<Expression> expList = new ArrayList<Expression>();

			if (exList != null && exList.size() > 0) {
				for (int j = 0; j < exList.size(); j++) {
					expList.add((Expression) exList.get(j));
				}

				for (int j = 0; j < expList.size(); j++) {
					Node x = new Node();
					x = processExpression(expList.get(j), fle, qStruct, plainSelect, joinType, dbAppParameters);
					n.partitionByNodes.add(x);
				}
			}

			return n;

		} else {
			if (an.getWindowDefinition() != null) {
				Node finalNode = new Node();
				finalNode.setType("ANALYTICAL NODE");
				finalNode.windowAggString = funcName;

				for (int i = 0; i < an.getWindowDefinition().getOrderByElements().size(); i++) {

					Expression rankExp = an.getWindowDefinition().getOrderByElements().get(i).getExpression();

					Node n = processExpression(rankExp, fle, qStruct, plainSelect, joinType, dbAppParameters);

					n.windowAggString = funcName;
					n.setType("ANALYTICAL NODE");

					if (an.getWindowDefinition().getOrderByElements().get(i).isAscDescPresent()) {
						if (an.getWindowDefinition().getOrderByElements().get(i).isAsc()) {
							n.orderByDirAsc = true;
						} else {
							n.orderByDirAsc = false;
						}

					} else {
						n.orderByDirAsc = true;
					}

					finalNode.orderNodesInWindow.add(n);

					if (i == 0) {
						ExpressionList exList = an.getWindowDefinition().getPartitionExpressionList();
						List<Expression> expList = new ArrayList<Expression>();

						if (exList != null && exList.size() > 0) {
							for (int j = 0; j < exList.size(); j++) {
								expList.add((Expression) exList.get(j));
							}

							for (int j = 0; j < expList.size(); j++) {
								Node x = new Node();
								x = processExpression(expList.get(j), fle, qStruct, plainSelect, joinType,
										dbAppParameters);
								finalNode.partitionByNodes.add(x);
							}
						}
					}

				}
				return finalNode;

			}
		}
		return null;

	}
	public static Node processExpressionForTrim(TrimFunction an, Vector<FromClauseElement> fle, QueryStructure qStruct,
			PlainSelect plainSelect, String joinType, AppTest_Parameters dbAppParameters) throws Exception {

		if (an == null) {
			return null;
		}

		
		Expression innerExpression = an.getExpression();

		if (innerExpression != null) {
			
			Node n = processExpression(innerExpression, fle, qStruct, plainSelect, joinType, dbAppParameters);
			return n;
		}

		return null;
	}
	public static Node processExpressionForFunction(Function an, Vector<FromClauseElement> fle, QueryStructure qStruct,
			PlainSelect plainSelect, String joinType, AppTest_Parameters dbAppParameters) throws Exception {
		// TODO Auto-generated method stub
		String funcName = an.getName();

		// All these are string manipulation functions and not aggregate function
		if (funcName.equalsIgnoreCase("ROW")) {
			Node n = new Node(true);
			n.isComposite = true;
			n.setType(Node.getCompositeNodeType());
			if (an.getParameters() != null) {
				ExpressionList anList = an.getParameters();
				List<Expression> expList = anList.getExpressions();
				for (Expression e : expList) {
					Node tempNode = processExpression(e, fle, qStruct, plainSelect, joinType, dbAppParameters);
					n.addComponentNode(tempNode);
				}
			}
			return n;
		} else if (!(funcName.equalsIgnoreCase("Lower") || funcName.equalsIgnoreCase("substring")
				|| funcName.equalsIgnoreCase("upper")
				|| funcName.equalsIgnoreCase("trim") || funcName.equalsIgnoreCase("postion")
				|| funcName.equalsIgnoreCase("octet_length")
				|| funcName.equalsIgnoreCase("bit_length") || funcName.equalsIgnoreCase("char_length")
				|| funcName.equalsIgnoreCase("overlay"))) {

			AggregateFunction af = new AggregateFunction();
			if (an.getParameters() != null) {
				ExpressionList anList = an.getParameters();
				List<Expression> expList = new ArrayList<Expression>();// FIXME not only 1 expression but all
																		// expressions

				for (int j = 0; j < anList.size(); j++) {
					expList.add((Expression) anList.get(j));
				}
				Node n = processExpression(expList.get(0), fle, qStruct, plainSelect, joinType, dbAppParameters);
				if (n == null) {
					an.setAllColumns(true);
				}
				af.setAggExp(n);

			} else {
				af.setAggExp(null);
			}

			af.setFunc(funcName.toUpperCase());
			af.setAggAliasName(funcName.toUpperCase());
			af.setDistinct(an.isDistinct());

			Node agg = new Node();

			// chaitra modified this if else ladder
			if (af.getAggExp() != null) {
				//if (af.getAggExp().getCaseExpression() == null) {
					agg.setAgg(af);
					agg.setType(Node.getAggrNodeType());
					// Shree added this to set Table, TableNameNo for Aggregate function node - @
					// node level
					if (af.getAggExp() != null) {
						agg.setTable(af.getAggExp().getTable());
						agg.setTableNameNo(af.getAggExp().getTableNameNo());
						agg.setTableAlias(af.getAggExp().getTableAlias());
						agg.setColumn(af.getAggExp().getColumn());

					} // Added by Shree for count(*)
					else if (af.getFunc().toUpperCase().contains("COUNT") && an.isAllColumns()) {
						agg.setAgg(af);
						agg.setType(Node.getAggrNodeType());
						if (af.getAggExp() == null) {
							Node n1 = parsing.Util.getNodeForCount(fle, qStruct);
							Vector<parsing.Column> columns = parsing.Util.getColumnsForCountstar(fle, qStruct);
							af.setAggExp(n1);
							af.setFunc(funcName.toUpperCase());
							af.setDistinct(an.isDistinct());
							af.setAggCols(columns);
							if (af.getAggExp() != null) {
								agg.setTable(af.getAggExp().getTable());
								agg.setTableNameNo(af.getAggExp().getTableNameNo());
								agg.setTableAlias(af.getAggExp().getTableAlias());
								agg.setColumn(af.getAggExp().getColumn());
							}

							agg.setLeft(null);
							agg.setRight(null);
						}
					}
				//}
				// chaitra handle sum(exp) issueeee!!!
				// else {
				// 	agg.setType("CASE NODE");
				// 	agg.setCaseExpression(af.getAggExp().getCaseExpression());
				// 	agg.setColumn(af.getAggExp().getColumn());
				// 	agg.setAliasName(af.getAggAliasName());
				// }
			} else if (af.getFunc().toUpperCase().contains("COUNT") && an.isAllColumns()) {
				agg.setAgg(af);
				agg.setType(Node.getAggrNodeType());
				if (af.getAggExp() == null) {
					Node n1 = parsing.Util.getNodeForCount(fle, qStruct);
					af.setAggExp(n1);
					af.setFunc(funcName.toUpperCase());
					af.setDistinct(an.isDistinct());

					if (af.getAggExp() != null) {
						agg.setTable(af.getAggExp().getTable());
						agg.setTableNameNo(af.getAggExp().getTableNameNo());
						agg.setTableAlias(af.getAggExp().getTableAlias());
						agg.setColumn(af.getAggExp().getColumn());
					}

					agg.setLeft(null);
					agg.setRight(null);
				}
			}
			// chaitra handle sum(exp)

			return agg;
		} else {
			// String function manipulation
			Node n = new Node();
			if (an.getParameters() != null) {
				ExpressionList anList = an.getParameters();
				List<Expression> expList = anList.getExpressions();// FIXME: not only 1 expression but all expressions
				n = processExpression(expList.get(0), fle, qStruct, plainSelect, joinType, dbAppParameters);
			}else if(an.getNamedParameters()!=null){
				ExpressionList anList = an.getNamedParameters();
				List<Expression> expList = anList.getExpressions();// FIXME: not only 1 expression but all expressions
				n = processExpression(expList.get(0), fle, qStruct, plainSelect, joinType, dbAppParameters);
			}
			return n;
		}
	}

	/**
	 * @author mathew
	 * 
	 * @param ParenthesedSelect
	 * @param subQueryParser
	 * @param parentQueryParser
	 * @throws Exception
	 * 
	 *                   deals with the case when a subquery is encountered while
	 *                   processing the from clause
	 */
	public static void processFromListParenthesedSelect(ParenthesedSelect ParenthesedSelect,
			QueryStructure subQueryParser,
			QueryStructure parentQueryParser, AppTest_Parameters dbAppParameters) throws Exception {
		// TODO Auto-generated method stub
		logger.log(Level.FINE, " Processing ParenthesedSelect, selbody:" + ParenthesedSelect.getSelect().toString());
		if (ParenthesedSelect.getAlias() != null)
			logger.log(Level.FINE, " ParenthesedSelect alias " + ParenthesedSelect.getAlias().getName());

		parentQueryParser.getFromClauseSubqueries().add(subQueryParser);

		subQueryParser.parentQueryParser = parentQueryParser;
		subQueryParser.setQuery(new Query("q2", ParenthesedSelect.getSelect().toString()));
		subQueryParser.getQuery().setRepeatedRelationCount(parentQueryParser.getQuery().getRepeatedRelationCount());
		// subQueryParser.getQuery().addFromTable(table);
		parentQueryParser.getQuery().putBaseRelation(ParenthesedSelect.getAlias().getName(),
				ParenthesedSelect.getAlias().getName());
		parentQueryParser.getQuery().putBaseRelation(ParenthesedSelect.getAlias().getName());
		subQueryParser.buildQueryStructureJSQL("q2", ParenthesedSelect.getSelect().toString(), true, dbAppParameters);

	}
	/**
	 * @author mathew
	 * 
	 * @param ParenthesedSelect
	 * @param subQueryParser
	 * @param parentQueryParser
	 * @throws Exception
	 * 
	 *                   deals with the case when a subquery is encountered while
	 *                   processing the where clause
	 */

	// parismita - nested subqueries not getting added
	public static void processWhereParenthesedSelect(ParenthesedSelect ParenthesedSelect, QueryStructure subQueryParser,
			QueryStructure parentQueryParser, AppTest_Parameters dbAppParameters) throws Exception {
		logger.log(Level.FINE, " Processing ParenthesedSelect, selbody:" + ParenthesedSelect.getSelect().toString());

		parentQueryParser.getWhereClauseSubqueries().add(subQueryParser);
		subQueryParser.parentQueryParser = parentQueryParser;
		subQueryParser.setQuery(new Query("q2", ParenthesedSelect.getSelect().toString()));
		subQueryParser.getQuery().setRepeatedRelationCount(parentQueryParser.getQuery().getRepeatedRelationCount());
		subQueryParser.buildQueryStructureJSQL("q2", ParenthesedSelect.getSelect().toString(), true, dbAppParameters);
	}

	/**
	 * @author mathew
	 * 
	 * @param n
	 * @param fleList        - list of from list elements returned after processing
	 *                       the from clause
	 * @param aliasNameFound
	 * @param qStruct
	 * @return
	 * @throws Exception
	 * 
	 *                   takes a node n (1st argument) for whose either table name
	 *                   is an alias or absent, resolves the alias/determines the
	 *                   table t
	 *                   to which the column belongs to returns a node whose table,
	 *                   table name etc. are set with the respective values of t
	 */
	private static Node transformToAbsoluteTableNames(Node n, Vector<FromClauseElement> fleList, boolean aliasNameFound,
			QueryStructure qStruct) throws Exception {
		// note that for any FromListElement object its tableName ==null iff it
		// represents a Select or a ParenthesedSelect
		String oldTableNameNo = n.getTableNameNo();
		for (FromClauseElement fle : fleList) {
			// iterates through the fleList, for each fle, tries to match its table
			// name/alias name
			// with the the name of the input node n
			// case when fle under consideration is a table, in which case if there is a
			// match, then fle's
			// table name is copied to n's and also the respective table
			if (fle != null && fle.getTableName() != null) {
				if (fle.getTableName().equalsIgnoreCase(n.getTableAlias())) {
					n.setTableNameNo(fle.getTableNameNo());
					Table table = qStruct.getTableMap().getTable(fle.getTableName());
					Table t = (Table) table.clone();
					n.setTable(t);
					// changes by sunanda for table alias in conjunct
					if (n.getTable() != null) {
						n.getTable().setAliasName(n.getTableNameNo().toLowerCase());
					}
					n.setTableAlias(n.getTableNameNo().toLowerCase());

					// n.setColumn(new parsing.Column(n.getColumn().getColumnName(),table));
					parsing.Column c = table.getColumn(n.getColumn().getColumnName());
					if (c == null) {
						logger.log(Level.WARNING,
								" Column name could not be resolved, query parsing failed, exception thrown, column name: "
										+ n.getColumn().getColumnName());
						throw new Exception(
								" Column name could not be resolved, query parsing failed, exception thrown, column name: "
										+ n.getColumn().getColumnName());
					} else {
						n.setColumn(table.getColumn(n.getColumn().getColumnName()));
						n.setOrgiColumn(n.getColumn());
						logger.log(Level.FINE, "table Name Found " + n);
					}
					return n;
				} else if (fle.getAliasName().equalsIgnoreCase(n.getTableAlias())) {
					n.setTableNameNo(fle.getTableNameNo());
					Table table = qStruct.getTableMap().getTable(fle.getTableName());
					if (table != null) {
						Table t = (Table) table.clone();
						n.setTable(t);
						// changes by sunanda for table alias in conjunct
						if (n.getTable() != null && oldTableNameNo.equalsIgnoreCase("")) {
							n.getTable().setAliasName(n.getTableNameNo().toLowerCase());
						} else if (n.getTable() != null && !oldTableNameNo.equalsIgnoreCase("")) {
							n.getTable().setAliasName(oldTableNameNo);
						}
						n.setTableAlias(n.getTableNameNo().toLowerCase());

						parsing.Column c = table.getColumn(n.getColumn().getColumnName());
						n.setColumn(c);
						n.setOrgiColumn(n.getColumn());

						if (c == null) {
							logger.log(Level.WARNING,
									" Column name could not be resolved, query parsing failed, exception thrown, column name: "
											+ n.getColumn().getColumnName());
							throw new Exception(
									" Column name could not be resolved, query parsing failed, exception thrown, column name: "
											+ n.getColumn().getColumnName());
						}
					}
					logger.log(Level.FINE, "alias Name Found " + n);
					return n;
				}
				// case when there is table name of n does not match with table/alias name of
				// fle
				// in which case fle's columns are searched for a column whose name is n's, if
				// yes
				// then fle's table and table name is copied to n's
				else if (aliasNameFound) {
					logger.log(Level.FINE, "alias Name Found but not n");
					Table table = qStruct.getTableMap().getTable(fle.getTableName());
					parsing.Column c;
					if ((c = table.getColumn(n.getColumn().getColumnName().toUpperCase())) != null) {
						n.setTableNameNo(fle.getTableNameNo());
						Table t = (Table) table.clone();
						n.setTable(t);
						// changes by sunanda for table alias in conjunct
						if (n.getTable() != null) {
							n.getTable().setAliasName(n.getTableNameNo().toLowerCase());
						}
						n.setTableAlias(n.getTableNameNo().toLowerCase());
						n.sqTableAliasName = oldTableNameNo; // changes by sunanda for aliasing from clause sq
						// n.setColumn(c);
						n.setColumn(table.getColumn(n.getColumn().getColumnName()));
						n.setOrgiColumn(n.getColumn());

						return n;
					}
				}
			}
			// considers the case fle alias is provided and fle is not a table (hence, is a
			// subquery or a subjoin)
			// and alias name matches with n's table name
			if (fle != null && fle.getTableName() == null && fle.getAliasName() != null &&
					fle.getAliasName().equalsIgnoreCase(n.getTableAlias())) {
				logger.log(Level.FINE, " alias name is not null, but table name is null");

				// case when fle is a subquery, then its from list elements are recursively
				// traversed and searched for a match
				if (fle.getSubQueryStructure() != null) {
					// continue;
					Node k = transformToAbsoluteTableNames(n, fle.getSubQueryStructure().getFromListElements(), true,
							fle.getSubQueryStructure());
					if (k != null && !n.getTableNameNo().equalsIgnoreCase(k.getTableNameNo()))
						return k;
				}
				// case when fle is a sub join, then its tabs are recursively traversed and
				// search for a match
				else {
					Node k = transformToAbsoluteTableNames(n, fle.getBag(), true, qStruct);
					if (k != null && !n.getTableNameNo().equalsIgnoreCase(k.getTableNameNo()))
						return k;
				}
			}
			if (aliasNameFound
					&& fle.getTableName() == null) {
				logger.log(Level.FINE, "alias name found" + n);
				if (fle.getBag() != null && !fle.getBag().isEmpty()) {
					Node k = transformToAbsoluteTableNames(n, fle.getBag(), true, qStruct);
					if (!n.getTableNameNo().equalsIgnoreCase(k.getTableNameNo()))
						return k;
				}
				if (fle.getSubQueryStructure() != null) {
					Node k = transformToAbsoluteTableNames(n, fle.getSubQueryStructure().getFromListElements(), true,
							fle.getSubQueryStructure());
					if (k != null && !n.getTableNameNo().equalsIgnoreCase(k.getTableNameNo()))
						return k;

				}
				logger.log(Level.FINE, " Alias name found, but column name cannot be resolved");
			}

			// if fle represents a sub join then its tabs contains it's components, in which
			// case its tabs are recursively traversed for finding a match
			if (fle != null && fle.getBag() != null && !fle.getBag().isEmpty()) {
				logger.log(Level.FINE, " tabs is not null");
				Node k = transformToAbsoluteTableNames(n, fle.getBag(), false, qStruct);
				if (!n.getTableNameNo().equalsIgnoreCase(k.getTableNameNo()))
					return k;
			}
			// if fle represents a subquery then its columns' names/alias names are also
			// examined for a match with n's column name
			if (fle != null && fle.getSubQueryStructure() != null
					&& (aliasNameFound || n.getTableNameNo() == null || n.getTableNameNo().isEmpty())) {
				logger.log(Level.FINE, " subQueryParser: checking projected cols");

				Node k = transformToAbsoluteNamesForAliasNameFoundSubquery(n, fle.getSubQueryStructure());
				if (!n.getTableNameNo().equalsIgnoreCase(k.getTableNameNo()))
					return k;

				k = transformToAbsoluteTableNames(n, fle.getSubQueryStructure().getFromListElements(), false,
						fle.getSubQueryStructure());
				if (!n.getTableNameNo().equalsIgnoreCase(k.getTableNameNo()))
					return k;

			}
		}

		if (n.getTableAlias().equalsIgnoreCase(oldTableNameNo) && qStruct.parentQueryParser != null) {
			Node k = traverseAncestorsForAbsoluteNameTransformations(n, qStruct.parentQueryParser.getFromListElements(),
					false, qStruct.parentQueryParser);
			if (!n.getTableNameNo().equalsIgnoreCase(k.getTableNameNo()))
				return k;

		}

		return n;
	}

	public static Node solveArithmaticOperation(BinaryExpression bne, Vector<FromClauseElement> fle,
			QueryStructure qStruct, PlainSelect plainSelect, String joinType, AppTest_Parameters dbAppParameters,
			char operation) {
		Node n = new Node();
		String left = bne.getLeftExpression().toString();
		String right = bne.getRightExpression().toString();
		Double l = Double.parseDouble(left);
		Double r = Double.parseDouble(right);
		Double ans = 0.0;
		switch (operation) {
			case '+':
				ans = l + r;
				break;
			case '-':
				ans = l - r;
				break;
			case '*':
				ans = l * r;
				break;
			case '/':
				ans = l / r;
				break;
			default:
				System.out.println("Unhandled Operation");
				break;
		}
		n.setType(Node.getValType());
		n.setStrConst(String.format("%.6f", ans));
		n.setLeft(null);
		n.setRight(null);
		return n;
	}

	public static int parseIntervalToDays(String intervalStr) {
		int totalDays = 0;
		Map<String, Integer> unitToDays = Map.of(
				"YEAR", 365, "MONTH", 30, "WEEK", 7, "DAY", 1);
		Pattern pattern = Pattern.compile("(\\d+)\\s*(YEAR|MONTH|WEEK|DAY)S?", Pattern.CASE_INSENSITIVE);
		Matcher matcher = pattern.matcher(intervalStr);
		while (matcher.find()) {
			int val = Integer.parseInt(matcher.group(1));
			String unit = matcher.group(2).toUpperCase();
			totalDays += val * unitToDays.get(unit);
		}
		return totalDays;
	}

	public static long parseIntervalToSeconds(String intervalStr) {
		long totalSeconds = 0;
		Map<String, Long> unitToSeconds = Map.of(
				"YEAR", 365L * 24 * 3600, "MONTH", 30L * 24 * 3600, "WEEK", 7L * 24 * 3600, "DAY", 24L * 3600, "HOUR",
				3600L, "MINUTE", 60L, "SECOND", 1L);
		Pattern pattern = Pattern.compile("(\\d+)\\s*(YEAR|MONTH|WEEK|DAY|HOUR|MINIUTE|SECOND)S?",
				Pattern.CASE_INSENSITIVE);
		Matcher matcher = pattern.matcher(intervalStr);
		while (matcher.find()) {
			long val = Long.parseLong(matcher.group(1));
			String unit = matcher.group(2);
			totalSeconds += val * unitToSeconds.get(unit);
		}
		return totalSeconds;
	}

	private static boolean isDateExpression(Expression expr) {
		return (expr instanceof DateValue ||
				expr instanceof DateTimeLiteralExpression ||
				expr.toString().equalsIgnoreCase("CURRENT_DATE") ||
				expr.toString().equalsIgnoreCase("NOW()"));
	}

	// if (strExpr.equals("CURRENT_DATE") || strExpr.equals("NOW()")) {
	// return LocalDate.now(); // or fixed for reproducibility
	// }
	public static String getCurrentDateTime(String type) {
		if (type.equalsIgnoreCase("DATE"))
			return LocalDate.now().toString();
		else if (type.equalsIgnoreCase("TIMESTAMP"))
			return LocalDateTime.now().toString();
		else
			return LocalTime.now().toString();
	}

	public static Node processInterval(BinaryExpression bne, Vector<FromClauseElement> fle,
			QueryStructure qStruct, PlainSelect plainSelect, String joinType, AppTest_Parameters dbAppParameters) {

		Node n = new Node();
		n.setType(Node.getValType());

		Expression left = bne.getLeftExpression();
		Expression right = bne.getRightExpression();
		String type = "";
		String val = "";
		IntervalExpression intervalExpr = null;
		boolean isAddition = bne instanceof Addition;
		if (left instanceof CastExpression) {
			type = ((CastExpression) left).getColDataType().toString();
			left = ((CastExpression) left).getLeftExpression();
			val = left.toString().replace("'", "").trim();
			if (right instanceof IntervalExpression)
				intervalExpr = (IntervalExpression) right;
			else {
				intervalExpr = new IntervalExpression();
				intervalExpr.setParameter(getCurrentDateTime(type));
			}

		} else if (right instanceof CastExpression) {
			type = ((CastExpression) right).getColDataType().toString();
			right = ((CastExpression) right).getLeftExpression();
			val = right.toString();
			if (left instanceof IntervalExpression)
				intervalExpr = (IntervalExpression) left;
			else {
				intervalExpr = new IntervalExpression();
				intervalExpr.setParameter(getCurrentDateTime(type));
			}
		}

		if (type.equalsIgnoreCase("DATE")) {
			LocalDate basDate = LocalDate.parse(val); // parse the date from the string
			String temp=intervalExpr.getParameter().toString().replace("'", "").trim();
			if(intervalExpr.getIntervalType()!=null){
				temp+=" "+intervalExpr.getIntervalType();
			}
			basDate = basDate
					.plusDays(parseIntervalToDays(temp));
			val = basDate.toString();

		} else if (type.equalsIgnoreCase("TIMESTAMP")) {
			LocalDateTime baseDateTime = LocalDateTime.parse(val);
			String temp=intervalExpr.getParameter().toString().replace("'", "").trim();
			if(intervalExpr.getIntervalType()!=null){
				temp+=" "+intervalExpr.getIntervalType();
			}
			baseDateTime = baseDateTime.plusSeconds(
					parseIntervalToSeconds(temp));
			val = baseDateTime.toString();

		} else if (type.equalsIgnoreCase("TIME")) {
			LocalTime baseTime = LocalTime.parse(val);
			String temp=intervalExpr.getParameter().toString().replace("'", "").trim();
			if(intervalExpr.getIntervalType()!=null){
				temp+=" "+intervalExpr.getIntervalType();
			}
			baseTime = baseTime.plusSeconds(
					parseIntervalToSeconds(temp));
			val = baseTime.toString();
		} else {
			throw new UnsupportedOperationException("Unsupported type for interval operation: " + type);
		}

		// Set the final node
		n.setStrConst(val);
		n.setLeft(null);
		n.setRight(null);

		return n;
	}

	private static Node traverseAncestorsForAbsoluteNameTransformations(Node n,
			Vector<FromClauseElement> fleList, boolean aliasNameFound, QueryStructure qStruct)
			throws CloneNotSupportedException {
		// TODO Auto-generated method stub
		String oldTableNameNo = n.getTableNameNo();

		for (FromClauseElement fle : fleList) {
			// iterates through the fleList, for each fle, tries to match its table
			// name/alias name
			// with the the name of the input node n
			// case when fle under consideration is a table, in which case if there is a
			// match, then fle's
			// table name is copied to n's and also the respective table
			if (fle != null && fle.getTableName() != null) {
				if (!n.getTableNameNo().isEmpty() && fle.getTableName().equalsIgnoreCase(n.getTableAlias())) {
					n.setTableNameNo(fle.getTableNameNo());
					Table table = qStruct.getTableMap().getTable(fle.getTableName());
					Table t = (Table) table.clone();
					n.setTable(t);
					// changes by sunanda for table alias in conjunct
					if (n.getTable() != null) {
						n.getTable().setAliasName(n.getTableNameNo().toLowerCase());
					}
					n.setTableAlias(n.getTableNameNo().toLowerCase());

					// n.setColumn(new parsing.Column(n.getColumn().getColumnName(),table));
					n.isCorrelated = true; // POOJA
					n.setColumn(table.getColumn(n.getColumn().getColumnName()));
					n.setOrgiColumn(n.getColumn());

					logger.log(Level.FINE, "table Name Found in ancestor" + n);
					return n;
				} else if (!n.getTableNameNo().isEmpty() && fle.getAliasName().equalsIgnoreCase(n.getTableAlias())) {
					n.setTableNameNo(fle.getTableNameNo());
					Table table = qStruct.getTableMap().getTable(fle.getTableName());
					if (table != null) {
						Table t = (Table) table.clone();
						n.setTable(t);
						// changes by sunanda for table alias in conjunct
						if (n.getTable() != null) {
							n.getTable().setAliasName(n.getTableAlias().toLowerCase());
						}
						n.setTableAlias(n.getTableNameNo().toLowerCase());

						// Set isCorrelated to true if the subquery holds tables that are correlated.
						n.isCorrelated = true;
						// n.setColumn(new parsing.Column(n.getColumn().getColumnName(),table));
						n.setColumn(table.getColumn(n.getColumn().getColumnName()));
						n.setOrgiColumn(n.getColumn());

					}
					logger.log(Level.FINE, "alias Name Found in ancestor" + n);
					return n;
				}
				// case when there is table name of n does not match with table/alias name of
				// fle
				else if (!n.getTableNameNo().isEmpty() && fle.getAliasName().equalsIgnoreCase(n.getTableAlias())) {
					n.setTableNameNo(fle.getTableNameNo());
					Table table = qStruct.getTableMap().getTable(fle.getTableName());
					if (table != null) {
						Table t = (Table) table.clone();
						n.setTable(t);
						// changes by sunanda for table alias in conjunct
						if (n.getTable() != null) {
							n.getTable().setAliasName(n.getTableNameNo().toLowerCase());
						}
						n.setTableAlias(n.getTableNameNo().toLowerCase());

						// Set isCorrelated to true if the subquery holds tables that are correlated.
						n.isCorrelated = true;
						// n.setColumn(new parsing.Column(n.getColumn().getColumnName(),table));
						n.setColumn(table.getColumn(n.getColumn().getColumnName()));
						n.setOrgiColumn(n.getColumn());

					}
					logger.log(Level.FINE, "alias Name Found in ancestor" + n);
					return n;
				}
				// case when there is table name of n that does not match with table/alias name
				// of fle
				// in which case fle's columns are searched for a column whose name is n's, if
				// yes
				// then fle's table and table name is copied to n's
				else if (aliasNameFound) {
					logger.log(Level.FINE, "alias Name Found but not n in ancestor");
					Table table = qStruct.getTableMap().getTable(fle.getTableName());
					parsing.Column c;
					if ((c = table.getColumn(n.getColumn().getColumnName().toUpperCase())) != null) {
						n.setTableNameNo(fle.getTableNameNo());
						Table t = (Table) table.clone();
						n.setTable(t);
						// changes by sunanda for table alias in conjunct
						if (n.getTable() != null) {
							n.getTable().setAliasName(n.getTableNameNo().toLowerCase());
						}
						n.setTableAlias(n.getTableNameNo().toLowerCase());

						// n.setColumn(c);
						n.setColumn(table.getColumn(n.getColumn().getColumnName()));
						n.setOrgiColumn(n.getColumn());

						return n;
					}
				}
				// Case where column name of ancestor table is used in a subquery without any
				// table alias.
				else if (n.getTableNameNo().isEmpty() && n.getTableAlias().isEmpty() && n.getTable() == null) {
					logger.log(Level.FINE,
							"No Table/Aliasdetails exists other than Column Name. So find the table in fle and check if column name matches any parent table. ");
					// Table table=qStruct.getTableMap().getTable(fle.getTableName());
					Table table = qStruct.getTableMap().getTable(fle.getTableName().toUpperCase()); // added by rambabu
					parsing.Column c;
					if ((c = table.getColumn(n.getColumn().getColumnName().toUpperCase())) != null) {
						n.setTableNameNo(fle.getTableNameNo());
						Table t = (Table) table.clone();
						n.setTable(t);
						// changes by sunanda for table alias in conjunct
						if (n.getTable() != null) {
							n.getTable().setAliasName(n.getTableNameNo().toLowerCase());
						}
						n.setTableAlias(n.getTableNameNo().toLowerCase());

						// n.setColumn(c);
						n.setColumn(table.getColumn(n.getColumn().getColumnName()));
						n.setOrgiColumn(n.getColumn());

						return n;
					}
				}
			}
			// considers the case fle alias is provided and fle is not a table (hence, is a
			// subquery or a subjoin)
			// and alias name matches with n's table name
			if (fle != null && fle.getTableName() == null && fle.getAliasName() != null &&
					fle.getAliasName().equalsIgnoreCase(n.getTableNameNo())) {
				logger.log(Level.FINE, " alias name is not null, but table name is null");

				// case when fle is a subquery, then its from list elements are recursively
				// traversed and searched for a match
				if (fle.getSubQueryStructure() != null) {
					Node k = transformToAbsoluteNamesForAliasNameFoundSubquery(n, fle.getSubQueryStructure());
					if (k != null && !n.getTableNameNo().equalsIgnoreCase(k.getTableNameNo()))
						return k;
				}
				// case when fle is a sub join, then its tabs are recursively traversed and
				// search for a match
				else {
					Node k = traverseAncestorsForAbsoluteNameTransformations(n, fle.getBag(), true, qStruct);
					if (k != null && !n.getTableNameNo().equalsIgnoreCase(k.getTableNameNo()))
						return k;
				}
			}

			// if fle represents a sub join then its tabs contains it's components, in which
			// case its tabs are recursively traversed for finding a match
			if (fle != null && fle.getBag() != null && !fle.getBag().isEmpty()) {
				logger.log(Level.FINE, " tabs is not null");
				Node k = traverseAncestorsForAbsoluteNameTransformations(n, fle.getBag(), false, qStruct);
				if (!n.getTableNameNo().equalsIgnoreCase(k.getTableNameNo()))
					return k;
			}
			// added by Sunanda for non-immediate correlation conditions for correlation and
			// table aliasing
			if (n.getTable() == null && qStruct.parentQueryParser != null) {
				Node k = traverseAncestorsForAbsoluteNameTransformations(n,
						qStruct.parentQueryParser.getFromListElements(), false, qStruct.parentQueryParser);
				if (!n.getTableNameNo().equalsIgnoreCase(k.getTableNameNo()))
					return k;

			}
			// if fle represents a subquery then its columns' names/alias names are also
			// examined for a match with n's column name
			if (fle != null && fle.getSubQueryStructure() != null
					&& (aliasNameFound || n.getTableNameNo() == null || n.getTableNameNo().isEmpty()
							|| n.getTable() == null)) {
				logger.log(Level.FINE, " subQueryParser: checking projected cols");

				Node k = transformToAbsoluteNamesForAliasNameFoundSubquery(n, fle.getSubQueryStructure());
				if (!n.getTableNameNo().equalsIgnoreCase(k.getTableNameNo()))
					return k;

			}
		}
		if (n.getTableAlias().equalsIgnoreCase(oldTableNameNo) && qStruct.parentQueryParser != null) {
			Node k = traverseAncestorsForAbsoluteNameTransformations(n, qStruct.parentQueryParser.getFromListElements(),
					false, qStruct.parentQueryParser);
			if (!n.getTableNameNo().equalsIgnoreCase(k.getTableNameNo()))
				return k;

		}

		return n;

	}

	private static Node transformToAbsoluteNamesForAliasNameFoundSubquery(Node n, QueryStructure subQueryStructure) {
		logger.log(Level.FINE, " subQueryParser: checking projected cols");

		for (Node m : subQueryStructure.getProjectedCols()) {
			if (m.getAgg() != null && m.getAgg().getAggAliasName() != null) {
				if (n.getColumn().getColumnName().equalsIgnoreCase(m.getAgg().getAggAliasName())) {
					logger.log(Level.FINE, " agg alias Name " + m.getAgg().getAggAliasName() + " node " + m);
					return m;
				}
			}
			if (m.getColumn() != null
					&& m.getColumn().getColumnName().equalsIgnoreCase(n.getColumn().getColumnName())) {
				logger.log(Level.FINE, " column Name found in subQueryParser " + m);
				return m;
			}
			if (m.getAliasName() != null && m.getAliasName().equalsIgnoreCase(n.getColumn().getColumnName())) {
				logger.log(Level.FINE, " column Name found as alias in subQueryParser " + m);
				return m;
			}
		}

		return n;
	}

	// Check if the following methods are needed and why are they added to avoid
	// extra tuples
	/**
	 * This method returns a Node with join conditions as node inside node for
	 * sending to conjuncts
	 * for conversion
	 * 
	 * @param joinNodeList
	 * @return
	 * @throws Exception
	 */
	private static RelationHierarchyNode generateRelationHierarchyJSQL(FromItem frmItem) throws Exception {

		RelationHierarchyNode node = null;

		if (frmItem instanceof net.sf.jsqlparser.schema.Table) {
			node = new RelationHierarchyNode(
					((net.sf.jsqlparser.schema.Table) frmItem).getFullyQualifiedName().toUpperCase());
		}

		else if (frmItem instanceof Select) {

			if (frmItem instanceof PlainSelect) {
				PlainSelect selectNode = ((Select) frmItem).getPlainSelect();
				// Vector<QueryTreeNode> v = selectNode..getFromList().getNodeVector();

				// for(QueryTreeNode i : v){
				node = generateRelationHierarchyJSQL(selectNode.getFromItem());
				// }

				List<RelationHierarchyNode> l = new ArrayList<RelationHierarchyNode>();
				Expression w = selectNode.getWhere();
				getAllNotExistsQueriesJSQL(w, l);
				if (node != null) {
					node.setNotExistsSubQueries(l);
				}
			}

		}
		// Modified for JSQL Exists - End
		return node;
	}

	private static RelationHierarchyNode generateRelationHierarchyJSQL(PlainSelect plainsel) throws Exception {
		RelationHierarchyNode node = null;
		FromItem prev = plainsel.getFromItem();
		if (plainsel.getWhere() != null) {

			node = generateRelationHierarchyJSQL(prev);

			List<RelationHierarchyNode> l = new ArrayList<RelationHierarchyNode>();
			Expression w = plainsel.getWhere();
			getAllNotExistsQueriesJSQL(w, l);
			if (node != null) {
				node.setNotExistsSubQueries(l);
			}
		}

		else {
			node = generateRelationHierarchyJSQL(prev);
		}
		return node;
	}// Added for Exists Subqueries-End

	public static Node getHierarchyOfJoinNode(Vector<Node> joinNodeList) throws Exception {
		Node nd = new Node();
		nd.setType(Node.getAndNodeType());
		if (joinNodeList != null && joinNodeList.size() > 0 && !joinNodeList.isEmpty()) {
			nd.setLeft(joinNodeList.get(0));
		} else
			nd.setLeft(null);
		Vector<Node> newList = new Vector<Node>();
		for (int i = 1; i < joinNodeList.size(); i++) {
			newList.add(joinNodeList.get(i));
		}
		if (newList != null && newList.size() > 0 && !newList.isEmpty()) {
			nd.setRight(getHierarchyOfJoinNode(newList));
		} else {
			nd.setRight(null);
		}
		return nd;

	}

	private static void getAllNotExistsQueriesJSQL(Expression w, List<RelationHierarchyNode> l) throws Exception {
		if (w instanceof BinaryExpression) {
			BinaryExpression whereNode = (BinaryExpression) w;
			getAllNotExistsQueriesJSQL(whereNode.getRightExpression(), l);
			getAllNotExistsQueriesJSQL(whereNode.getLeftExpression(), l);
		} else if (w instanceof Parenthesis) {
			Expression temp = ((Parenthesis) w).getExpression();
			if (temp instanceof ExistsExpression || temp instanceof InExpression) {
				getAllNotExistsQueriesJSQL(temp, l);
			}
		} else if ((w instanceof ExistsExpression && ((ExistsExpression) w).isNot())) {
			ExistsExpression notOp = (ExistsExpression) w;
			Expression temp = notOp.getRightExpression();
			if (temp instanceof ParenthesedSelect) {
				ParenthesedSelect subQueryNode = (ParenthesedSelect) temp;

				PlainSelect ps = (PlainSelect) subQueryNode.getSelect();
				if (ps.getJoins() != null && ps.getJoins().size() > 0) {

					l.add(generateRelationHierarchyJSQL(ps));

				} else {
					FromItem frm = ps.getFromItem();
					// if(frm instanceof Table){
					if (frm instanceof net.sf.jsqlparser.schema.Table) { // added by rambabu
						l.add(generateRelationHierarchyJSQL(frm));
					}
				}

				// }
			}
		} else if (w instanceof InExpression && ((InExpression) w).isNot()) {
			InExpression notOp = (InExpression) w;

			if (notOp.getRightExpression() instanceof ParenthesedSelect) {
				ParenthesedSelect subQueryNode = (ParenthesedSelect) notOp.getRightExpression();

				PlainSelect ps = (PlainSelect) subQueryNode.getSelect();

				if (ps.getJoins() != null && ps.getJoins().size() > 0) {

					// l.add(generateRelationHierarchyJSQL(ps));

				} else {
					FromItem frm = ps.getFromItem();
					// if(frm instanceof Table){
					if (frm instanceof net.sf.jsqlparser.schema.Table) { // added by rambabu
						l.add(generateRelationHierarchyJSQL(frm));
					}
				}
			} else if (notOp.getLeftExpression() instanceof ParenthesedSelect) {
				ParenthesedSelect subQueryNode = (ParenthesedSelect) notOp.getLeftExpression();

				PlainSelect ps = (PlainSelect) subQueryNode.getSelect();

				if (ps.getJoins() != null && ps.getJoins().size() > 0) {

					// l.add(generateRelationHierarchyJSQL(ps));

				} else {
					FromItem frm = ps.getFromItem();
					// if(frm instanceof Table){
					if (frm instanceof net.sf.jsqlparser.schema.Table) { // added by rambabu
						l.add(generateRelationHierarchyJSQL(frm));
					}
				}
			}
		}
	}
}
