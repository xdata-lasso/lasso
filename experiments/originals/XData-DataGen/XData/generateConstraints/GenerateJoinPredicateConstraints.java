package generateConstraints;

import java.lang.Thread.State;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.StringTokenizer;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.apache.derby.impl.sql.compile.JoinNode;

import com.healthmarketscience.sqlbuilder.Query;
import com.healthmarketscience.sqlbuilder.dbspec.Constraint;
import com.microsoft.z3.ArithExpr;
import com.microsoft.z3.BoolExpr;
import com.microsoft.z3.Context;
import com.microsoft.z3.DatatypeSort;
import com.microsoft.z3.EnumSort;
import com.microsoft.z3.Expr;
import com.microsoft.z3.FuncDecl;
import com.microsoft.z3.Sort;

import GenConstraints.GenConstraints;
import net.sf.jsqlparser.statement.create.table.ColDataType;
import net.sf.jsqlparser.statement.select.Join;
import net.sf.jsqlparser.statement.create.table.ColDataType;
import oracle.net.aso.i;
import oracle.net.aso.n;
import oracle.sql.NUMBER;
import parsing.Column;
import parsing.ConjunctQueryStructure;
import parsing.DisjunctQueryStructure;
import parsing.JoinClause;
import parsing.JoinClauseInfo;
import parsing.Node;
import parsing.QueryStructure;
import parsing.Table;
import parsing.correlationStructure;
import testDataGen.GenerateCVC1;
import testDataGen.QueryBlockDetails;
import testDataGen.SubqueryStructure;
import util.Configuration;
import util.ConstraintObject;
import util.Pair;
import util.TagDatasets.QueryBlock;

/**
 * This class is used to generate constraints for the join predicates
 * The join predicates can be equi-join or non-equi join predicates
 * TODO: Handling join conditions which involve aggregations like SUM(A.x) = B.x
 * is part of future work
 * 
 * @author mahesh
 *
 */

public class GenerateJoinPredicateConstraints {

	private static Logger logger = Logger.getLogger(GenerateJoinPredicateConstraints.class.getName());

	private static boolean isTempJoin = false;
	private static Vector<String> tablesAdded = new Vector<String>();
	static boolean isChanged = false;
	static ConjunctQueryStructure old;
	static Vector<String> joinTypeCopy;
	static ArrayList<String> oldBaseRelation;
	static ArrayList<String> oldBaseSQRelation;

	/**
	 * Constructor
	 */

	// added by deeksha : API call Context()
	// ----------------------------------------------------------------
	// public static Context ctx = new Context();
	// private static Solver solver = ctx.mkSolver();
	// private static HashMap<String, FuncDecl> ctxFuncDecls = new HashMap<String,
	// FuncDecl>(); // for storing Z3 context function declarations
	// static Solver dummySol = ctx.mkSolver();
	// ConstraintGenerator obj = new ConstraintGenerator();
	// --------------------------------------------------------------------
	public GenerateJoinPredicateConstraints() {

		if (Configuration.getProperty("tempJoins").equalsIgnoreCase("true")) {
			this.isTempJoin = true;
		} else {
			this.isTempJoin = false;
		}
	}

	public static String getConstraintsforEquivalenceClasses(GenerateCVC1 cvc, QueryBlockDetails queryBlock,
			ConjunctQueryStructure conjunct) throws Exception {
		String constraintString = "";
		if (queryBlock.getLevel() > 0)
			return constraintString;// parismita
		Vector<Vector<Node>> equivalenceClasses = conjunct.getEquivalenceClasses();
		for (int k = 0; k < equivalenceClasses.size(); k++) {
			Vector<Node> ec = equivalenceClasses.get(k);
			for (int i = 0; i < ec.size() - 1; i++) {
				Node n1 = ec.get(i);
				Node n2 = ec.get(i + 1);
				constraintString += GenerateJoinPredicateConstraints.getConstraintsForEquiJoins1(cvc, queryBlock, n1,
						n2);
			}
		}

		if (Configuration.getProperty("tempJoins").equalsIgnoreCase("true")) {
			isTempJoin = true;
		} else {
			isTempJoin = false;
		}
		/*
		 * if(isTempJoin) {
		 * String constr,declare="";
		 * int st_index=0,end_index=0;
		 * constr = constraintString;
		 * while(constr.indexOf("(declare-datatypes ()") != -1) {
		 * st_index = constr.indexOf("(declare-datatypes ()");
		 * end_index = constr.indexOf("_TupleType))")+12;
		 * if(!declare.contains(constr.substring(st_index, end_index)))
		 * declare += constr.substring(st_index, end_index) + " \n";
		 * constr = constr.substring(0, st_index)+constr.substring(end_index);
		 * }
		 * 
		 * constraintString = declare + constr;
		 * }
		 */

		return constraintString;
	}

	/**
	 * Get the constraints for equivalence Classes by Considering repeated relations
	 * 
	 * @param cvc
	 * @param queryBlock
	 * @param n1
	 * @param n2
	 * @return
	 * @throws Exception
	 */

	public static String getConstraintsForEquiJoins(GenerateCVC1 cvc, QueryBlockDetails queryBlock, Node n1, Node n2,
			String subqueryType) throws Exception {

		String constraintString = "";

		if (n1.getQueryType() == n2.getQueryType()) {
			/**
			 * If both nodes are of same type (i.e. either from clause sub qury nodes or
			 * where clause sub query nodes or outer query block nodes
			 */
			if (n1.getQueryIndex() != n2.getQueryIndex()) {/**
															 * This means these nodes correspond to two different from
															 * clause sub queries and are joined in the outer query
															 * block
															 */
				return getConstraintsForJoinsInDiffSubQueryBlocks(cvc, queryBlock, n1, n2, "=");
			} else {/** these are either correspond to from clause/ where clause/ outer clause */
				return getConstraintsForJoinsWithoutTemp(cvc, queryBlock, n1, n2, "=");
			}
		} else {/**
				 * This means one node correspond to from/Where clause sub query and other node
				 * correspond to outer query block
				 */
			return getConstraintsForEquiJoinsInSubQBlockAndOuterBlock(cvc, queryBlock, n1, n2, "=");
		}
	}

	/**
	 * Get the constraints for equivalence Classes by Considering repeated relations
	 * 
	 * @param cvc
	 * @param queryBlock
	 * @param n1
	 * @param n2
	 * @return
	 * @throws Exception
	 */

	public static String getConstraintsForEquiJoins1(GenerateCVC1 cvc, QueryBlockDetails queryBlock, Node n1, Node n2)
			throws Exception {

		String constraintString = "";

		if (n1.getQueryType() == n2.getQueryType()) {
			/**
			 * If both nodes are of same type (i.e. either from clause sub query nodes or
			 * where clause sub query nodes or outer query block nodes
			 */
			if (n1.getQueryIndex() != n2.getQueryIndex()) {/**
															 * This means these nodes correspond to two different from
															 * clause sub queries and are joined in the outer query
															 * block
															 */
				return getConstraintsForJoinsInDiffSubQueryBlocks1(cvc, queryBlock, n1, n2, "=");
			} else {/** these are either correspond to from clause/ where clause/ outer clause */
				return getConstraintsForJoinsInSameQueryBlock1(cvc, queryBlock, n1, n2, "=");
			}
		} else {/**
				 * This means one node correspond to from clause sub query and other node
				 * correspond to outer query block
				 */
			return getConstraintsForEquiJoinsInSubQBlockAndOuterBlock1(cvc, queryBlock, n1, n2, "=");
		}
	}

	/**
	 * Wrapper method Used to generate constraints for the non equi join conditions
	 * of the conjunct
	 * 
	 * @param cvc
	 * @param queryBlock
	 * @param allConds
	 * @return
	 * @throws Exception
	 */

	public static String getConstraintsForNonEquiJoins(GenerateCVC1 cvc, QueryBlockDetails queryBlock,
			Vector<Node> allConds, String fromwhere) throws Exception {

		String constraintString = "";
		for (Node n : allConds)
			constraintString += getConstraintsForNonEquiJoins(cvc, queryBlock, n.getLeft(), n.getRight(),
					n.getOperator(), fromwhere);
		return constraintString;
	}

	public static String getConstraintsForNonEquiJoinsTJ(GenerateCVC1 cvc, QueryBlockDetails queryBlock, Node n,
			String fromwhere) throws Exception {

		String constraintString = "";
		constraintString += getConstraintsForNonEquiJoins(cvc, queryBlock, n.getLeft(), n.getRight(), n.getOperator(),
				fromwhere);
		return constraintString;
	}

	/**
	 * Wrapper method Used to generate constraints negative for the non equi join
	 * conditions of the conjunct
	 * 
	 * @param cvc
	 * @param queryBlock
	 * @param allConds
	 * @return
	 * @throws Exception
	 */
	public static String getNegativeConstraintsForNonEquiJoins(GenerateCVC1 cvc, QueryBlockDetails queryBlock,
			Vector<Node> allConds) throws Exception {

		Vector<Node> allCondsDup = new Vector<Node>();

		for (Node node : allConds) {
			Node n = new Node(node);
			if (n.getOperator().equals("="))
				n.setOperator("/=");
			else if (n.getOperator().equals("/="))
				n.setOperator("=");
			else if (n.getOperator().equals(">"))
				n.setOperator("<=");
			else if (n.getOperator().equals("<"))
				n.setOperator(">=");
			else if (n.getOperator().equals("<="))
				n.setOperator(">");
			else if (n.getOperator().equals(">="))
				n.setOperator("<");
		}

		return getConstraintsForNonEquiJoins(cvc, queryBlock, allCondsDup, "");
	}

	/**
	 * Used to generate constraints for the non equi join conditions of the conjunct
	 * 
	 * @param cvc
	 * @param queryBlock
	 * @param left
	 * @param right
	 * @param operator
	 * @return
	 * @throws Exception
	 */
	public static String getConstraintsForNonEquiJoins(GenerateCVC1 cvc, QueryBlockDetails queryBlock, Node left,
			Node right, String operator, String subqueryType) throws Exception {

		if (queryBlock.getLevel() > 0)
			return "";
		if (left.getQueryType() == right.getQueryType()) {
			/**
			 * If both nodes are of same type (i.e. either from clause sub query nodes or
			 * where clause sub query nodes or outer query block nodes)
			 */
			if (left.getQueryIndex() != right.getQueryIndex()) {/**
																 * This means these nodes correspond to two different
																 * from clause sub queries and are joined in the outer
																 * query block
																 */
				return getConstraintsForJoinsInDiffSubQueryBlocks(cvc, queryBlock, left, right, operator);
			} else {/** these are either correspond to from clause/ where clause/ outer clause */
				// return getConstraintsForJoinsInSameQueryBlock(cvc, queryBlock, left, right,
				// operator, fromorwhere);
				return getConstraintsForJoinsInSameQueryBlock1(cvc, queryBlock, left, right, operator);

			}
		} else {/**
				 * This means one node correspond to from clause sub query and other node
				 * correspond to outer query block
				 */
			return getConstraintsForEquiJoinsInSubQBlockAndOuterBlock(cvc, queryBlock, left, right, operator);
		}
	}

	/**
	 * Gets constraints for nodes which are involved in join conditions where one
	 * node is in outer query block and other node is in from clause sub query
	 * 
	 * @param cvc
	 * @param queryBlock
	 * @param n1
	 * @param n2
	 * @param string
	 * @return
	 */
	public static String getConstraintsForEquiJoinsInSubQBlockAndOuterBlock(GenerateCVC1 cvc,
			QueryBlockDetails queryBlock, Node n1, Node n2, String operator) {
		String constraintString = "";

		/** Let make n1 as sub query node and n2 as outer query node */
		if (n1.getQueryType() == 0) {
			Node temp = new Node(n1);
			n1 = new Node(n2);
			n2 = temp;
		}

		int leftGroup = 1;

		/** get number of groups for the from clause nested subquery block */
		leftGroup = UtilsRelatedToNode.getNoOfGroupsForThisNode(cvc, queryBlock, n1);

		/** get the details of each node */
		String t1 = getTableName(n1);
		String t2 = getTableName(n2);
		int pos1 = cvc.getTableMap().getTable(t1).getColumnIndex(getColumn(n1).getColumnName());
		int pos2 = cvc.getTableMap().getTable(t2).getColumnIndex(getColumn(n2).getColumnName());

		String r1 = getTableNameNo(n1);
		String r2 = getTableNameNo(n2);
		int offset1 = cvc.getRepeatedRelNextTuplePos().get(r1)[1];
		int offset2 = cvc.getRepeatedRelNextTuplePos().get(r2)[1];

		/** Get number of tuples of each relation occurrence */
		int tuples1 = 0, tuples2 = 0;
		if (cvc.getNoOfTuples().containsKey(r1)) {
			tuples1 = cvc.getNoOfTuples().get(r1);
		}
		if (cvc.getNoOfTuples().containsKey(r2)) {
			tuples2 = cvc.getNoOfTuples().get(r2);
		}
		ConstraintGenerator constrGen = new ConstraintGenerator();
		ArrayList<ConstraintObject> constrObjList = new ArrayList<ConstraintObject>();

		/** Do a round robin for the smaller value of the group number */
		for (int k = 1, l = 1;; k++, l++) {
			// constraintString += "ASSERT ("+
			// GenerateCVCConstraintForNode.genPositiveCondsForPred(queryBlock, n1,
			// ((k-1)*tuples1+offset1))+ operator +
			// GenerateCVCConstraintForNode.genPositiveCondsForPred(queryBlock, n2,
			// (l+offset2-1))+");\n";

			/*
			 * ConstraintObject constrObj = new ConstraintObject();
			 * constrObj.setLeftConstraint(constrGen.genPositiveCondsForPred(queryBlock,n1,
			 * ((k-1)*tuples1+offset1)));
			 * constrObj.setRightConstraint(constrGen.genPositiveCondsForPred(queryBlock,
			 * n2, (l+offset2-1)));
			 * constrObj.setOperator(operator);
			 * constrObjList.add(constrObj);
			 */

			constraintString += constrGen.getAssertConstraint(
					constrGen.genPositiveCondsForPred(queryBlock, n1, ((k - 1) * tuples1 + offset1)), operator,
					constrGen.genPositiveCondsForPred(queryBlock, n2, (l + offset2 - 1)));

			if (leftGroup > tuples2) {
				if (l == tuples2 && k < leftGroup)
					l = 0;
				if (k >= leftGroup)
					break;
			} else if (leftGroup < tuples2) {
				if (l < tuples2 && k == leftGroup)
					k = 0;
				if (l >= tuples2)
					break;
			} else {// if tuples1==tuples2
				if (l == leftGroup)
					break;
			}
		}
		// constraintString =constrGen.generateANDConstraintsWithAssert(constrObjList);
		return constraintString;
	}

	/**
	 * Gets constraints for nodes which are involved in join conditions where one
	 * node is in outer query block and other node is in from clause sub query
	 * 
	 * @param cvc
	 * @param queryBlock
	 * @param n1
	 * @param n2
	 * @param string
	 * @return
	 */
	public static String getConstraintsForEquiJoinsInSubQBlockAndOuterBlock1(GenerateCVC1 cvc,
			QueryBlockDetails queryBlock, Node n1, Node n2, String operator) {
		String constraintString = "";

		/** Let make n1 as sub query node and n2 as outer query node */
		if (n1.getQueryType() == 0) {
			Node temp = new Node(n1);
			n1 = new Node(n2);
			n2 = temp;
		}

		int leftGroup = 1;

		/** get number of groups for the from clause nested subquery block */
		leftGroup = UtilsRelatedToNode.getNoOfGroupsForThisNode(cvc, queryBlock, n1);

		/** get the details of each node */
		String t1 = n1.getColumn().getTableName();
		String t2 = n2.getColumn().getTableName();
		int pos1 = cvc.getTableMap().getTable(t1).getColumnIndex(n1.getColumn().getColumnName());
		int pos2 = cvc.getTableMap().getTable(t2).getColumnIndex(n2.getColumn().getColumnName());

		String r1 = n1.getTableNameNo();
		String r2 = n2.getTableNameNo();
		int offset1 = cvc.getRepeatedRelNextTuplePos().get(r1)[1];
		int offset2 = cvc.getRepeatedRelNextTuplePos().get(r2)[1];

		/** Get number of tuples of each relation occurrence */
		int tuples1 = 0, tuples2 = 0;
		if (cvc.getNoOfTuples().containsKey(r1)) {
			tuples1 = cvc.getNoOfTuples().get(r1);
		}
		if (cvc.getNoOfTuples().containsKey(r2)) {
			tuples2 = cvc.getNoOfTuples().get(r2);
		}

		ConstraintGenerator constrGen = new ConstraintGenerator();
		ArrayList<ConstraintObject> constrObjList = new ArrayList<ConstraintObject>();

		/** Do a round robin for the smaller value of the group number */
		for (int k = 1, l = 1;; k++, l++) {
			// constraintString += "("+
			// GenerateCVCConstraintForNode.genPositiveCondsForPred(queryBlock, n1,
			// ((k-1)*tuples1+offset1))+ operator +
			// GenerateCVCConstraintForNode.genPositiveCondsForPred(queryBlock, n2,
			// (l+offset2-1))+") AND ";
			ConstraintObject constrObj = new ConstraintObject();
			constrObj.setLeftConstraint(
					constrGen.genPositiveCondsForPred(queryBlock, n1, ((k - 1) * tuples1 + offset1)));
			constrObj.setRightConstraint(constrGen.genPositiveCondsForPred(queryBlock, n2, (l + offset2 - 1)));
			constrObj.setOperator(operator);
			constrObjList.add(constrObj);
			if (leftGroup > tuples2) {
				if (l == tuples2 && k < leftGroup)
					l = 0;
				if (k >= leftGroup)
					break;
			} else if (leftGroup < tuples2) {
				if (l < tuples2 && k == leftGroup)
					k = 0;
				if (l >= tuples2)
					break;
			} else {// if tuples1==tuples2
				if (l == leftGroup)
					break;
			}
		}
		constraintString = constrGen.generateANDConstraintsWithAssert(constrObjList);
		return constraintString;
	}

	/**
	 * heuristics for multiplicity
	 * 
	 * @author parismita
	 * @param cvc
	 * @param conds
	 * @param tables
	 * @return
	 * @throws Exception
	 */
	public static int getOptimalTupleCountForJoinTable(GenerateCVC1 cvc, Vector<Node> conds, Vector<Table> tables)
			throws Exception {
		int tuplesInJoinTable = 1, tupleNo = 0;
		HashMap<Table, Integer> multiplicity = new HashMap<Table, Integer>();

		for (Table cvcTable : tables) {
			tupleNo = cvc.getNoOfOutputTuples(cvcTable.getTableName());
			if (cvcTable.getTableName().startsWith("JSQ") || cvcTable.getTableName().startsWith("GSQ"))
				tupleNo = 1;
			multiplicity.put(cvcTable, tupleNo);
		}
		// for every table 1 and 2 -> for every pkey1 -> check nodes for condition,
		// maintain a flag and remove node on cond sat
		// flag array int = case 1:const 1:pkey/npkey table1&2 3:pkey/pkey table1&2
		// 4:npkey/pkey table1&2

		// build a map <pair<table, table>, vector<nodes>>
		// traverse the map for every table, check if col is pkey if yes
		for (int i = 0; i < tables.size(); i++) {
			Table t1 = tables.get(i);
			// case1
			int pkey1[] = new int[t1.getPrimaryKey().size()];// 0-1 bool
			int flag = 1;
			for (int k = 0; k < t1.getPrimaryKey().size(); k++) {
				for (Node node : conds)
					if (node.getLeft() != null && t1.getPrimaryKey().get(k) == node.getLeft().getColumn()
							&& node.getRight().getType() == Node.getValType())
						pkey1[k] = 1;
			}
			for (int pk : pkey1)
				if (pk != 1)
					flag = 0;
			if (flag == 1) {
				multiplicity.put(t1, 1);
				continue;
			}
			// case 1 end

			for (int j = i + 1; j < tables.size(); j++) {// each pair of table compared once
				Table t2 = tables.get(j);
				int pkey2[] = new int[t2.getPrimaryKey().size()];
				pkey1 = new int[t1.getPrimaryKey().size()];
				int flag1 = 1, flag2 = 1;
				for (int k1 = 0; k1 < t1.getPrimaryKey().size(); k1++) {
					for (int k2 = 0; k2 < t2.getPrimaryKey().size(); k2++) {
						for (Node node : conds) {
							if (node.getOperator() != "=")
								continue;
							if (node.getLeft() != null && node.getLeft().getType() == Node.getColRefType()
									&& node.getRight() != null && node.getRight().getType() == Node.getColRefType()) {
								if ((t1.getPrimaryKey().get(k1) == node.getLeft().getColumn()
										&& t2 == node.getRight().getTable())
										||
										(t1.getPrimaryKey().get(k1) == node.getRight().getColumn()
												&& t2.getTableName()
														.equalsIgnoreCase(node.getLeft().getTable().getTableName()))
										|| (t2 == node.getLeft().getTable()
												&& t1.getPrimaryKey().get(k1) == node.getRight().getColumn())) {
									pkey1[k1] = 1;
								}
								if ((t2.getPrimaryKey().get(k2) == node.getLeft().getColumn()
										&& t1 == node.getRight().getTable())
										||
										(t2.getPrimaryKey().get(k2) == node.getRight().getColumn()
												&& t1.getTableName()
														.equalsIgnoreCase(node.getLeft().getTable().getTableName()))
										||
										(t1 == node.getLeft().getTable()
												&& t2.getPrimaryKey().get(k2) == node.getRight().getColumn())) {
									pkey2[k2] = 1;
								}
							}
						}
					}
				}
				for (int pk : pkey1)
					if (pk != 1)
						flag1 = 0;
				for (int pk : pkey2)
					if (pk != 1)
						flag2 = 0;
				if (flag1 == 1 && flag2 == 1) {
					if (cvc.getNoOfOutputTuples(t1.getTableName()) >= cvc.getNoOfOutputTuples(t2.getTableName()))
						multiplicity.put(t1, 1);
					else
						multiplicity.put(t2, 1);
				} else if (flag1 == 1) {
					multiplicity.put(t1, 1);
				} else if (flag2 == 1) {
					multiplicity.put(t2, 1);
				}
			}

		}
		// case 4
		for (Node node : conds) {
			if (node.getOperator() != "=")
				continue;
			if (node.getLeft() != null && node.getLeft().getTable() != null
					&& node.getLeft().getType() == Node.getColRefType() && node.getRight() != null
					&& node.getRight().getTable() != null && node.getRight().getType() == Node.getColRefType()) {
				if (multiplicity.get(node.getLeft().getTable()) != null
						&& multiplicity.get(node.getRight().getTable()) != null
						&& multiplicity.get(node.getLeft().getTable()) != 1 && multiplicity
								.get(node.getLeft().getTable()) <= multiplicity.get(node.getRight().getTable())) {
					multiplicity.put(node.getLeft().getTable(), 2);
				} else if (multiplicity.get(node.getRight().getTable()) != null
						&& multiplicity.get(node.getLeft().getTable()) != null
						&& multiplicity.get(node.getRight().getTable()) != 1
						&& multiplicity.get(node.getLeft().getTable()) >= multiplicity.get(node.getRight().getTable()))
					multiplicity.put(node.getRight().getTable(), 2);
			}
		}
		// case 4 end
		tuplesInJoinTable = 1;
		for (Table cvcTable : tables) {
			tuplesInJoinTable = tuplesInJoinTable * multiplicity.get(cvcTable);
		}
		if (tuplesInJoinTable > 16) { // sunanda - heuristic
			return 16;
		}
		return tuplesInJoinTable;
	}

	public static List<List<Integer>> generateDomains(List<Integer> ks) {
		List<List<Integer>> domains = new ArrayList<>();
		for (Integer k : ks) {
			List<Integer> domain = new ArrayList<>();
			for (int i = 1; i <= k; i++) {
				domain.add(i);
			}
			domains.add(domain);
		}
		return domains;
	}

	public static List<List<Integer>> generateCombinations(List<List<Integer>> domains) {
		List<List<Integer>> combinations = new ArrayList<>();
		generateCombinationsRecursive(domains, 0, new ArrayList<>(), combinations);
		return combinations;
	}

	private static void generateCombinationsRecursive(List<List<Integer>> domains, int index,
			List<Integer> currentCombination, List<List<Integer>> combinations) {
		if (index == domains.size()) {
			combinations.add(new ArrayList<>(currentCombination));
			return;
		}

		for (Integer value : domains.get(index)) {
			currentCombination.add(value);
			generateCombinationsRecursive(domains, index + 1, currentCombination, combinations);
			currentCombination.remove(currentCombination.size() - 1);
		}
	}

	static public String getNullConstraints(Expr column, String dataType, String columnName) {

		if (dataType.equalsIgnoreCase("INT"))
			return "(CHECKALL_NULLInt" + column.toString() + ")";
		if (dataType.equalsIgnoreCase("REAL"))
			return "(CHECKALL_NULLReal" + column.toString() + ")";
		return "(ISNULL_" + dataType + " " + column.toString() + ")";
	}

	private static BoolExpr getComparisonExpr(Column col, String op, Expr l, Expr r) {
		String datatype = col.getCvcDatatype();
		if (datatype.equalsIgnoreCase("INT") || datatype.equalsIgnoreCase("REAL")) {
			if (op.equalsIgnoreCase("=")) {
				return ConstraintGenerator.ctx.mkEq(l, r);
			} else if (op.equalsIgnoreCase("/=") || op.equalsIgnoreCase("!=")) {
				return ConstraintGenerator.ctx.mkNot(ConstraintGenerator.ctx.mkEq(l, r));
			} else if (op.equalsIgnoreCase("<")) {
				return ConstraintGenerator.ctx.mkLt((ArithExpr) l, (ArithExpr) r);
			} else if (op.equalsIgnoreCase("<=")) {
				return ConstraintGenerator.ctx.mkLe((ArithExpr) l, (ArithExpr) r);
			} else if (op.equalsIgnoreCase(">")) {
				return ConstraintGenerator.ctx.mkGt((ArithExpr) l, (ArithExpr) r);
			} else if (op.equalsIgnoreCase(">=")) {
				return ConstraintGenerator.ctx.mkGe((ArithExpr) l, (ArithExpr) r);
			}
		}
		// Custom domain comparison
		Sort colSort = ConstraintGenerator.getColumnSort(datatype);
		if (op.equalsIgnoreCase("=")) {
			return ConstraintGenerator.ctx.mkEq(l, r);
		} else if (op.equalsIgnoreCase("/=") || op.equalsIgnoreCase("!=")) {
			return ConstraintGenerator.ctx.mkNot(ConstraintGenerator.ctx.mkEq(l, r));
		} else if (op.equalsIgnoreCase("<") || op.equalsIgnoreCase(">")) {
			String opName = op.equalsIgnoreCase("<") ? "lt" : "gt";
			FuncDecl customOp = ConstraintGenerator.ctx.mkFuncDecl(
					opName + datatype,
					new Sort[] { colSort, colSort },
					ConstraintGenerator.ctx.getBoolSort());
			return (BoolExpr) customOp.apply(l, r);
		} else if (op.equalsIgnoreCase("<=") || op.equalsIgnoreCase(">=")) {
			String opName = op.equalsIgnoreCase("<=") ? "lt" : "gt";
			FuncDecl customOp = ConstraintGenerator.ctx.mkFuncDecl(
					opName + datatype,
					new Sort[] { colSort, colSort },
					ConstraintGenerator.ctx.getBoolSort());
			BoolExpr cmp = (BoolExpr) customOp.apply(l, r);
			BoolExpr eq = ConstraintGenerator.ctx.mkEq(l, r);
			return ConstraintGenerator.ctx.mkOr(cmp, eq);
		}

		return null;
	}

	private static BoolExpr buildLexicographicalComparison(GenerateCVC1 cvc, QueryBlockDetails queryBlock,
			List<Node> leftNodes, String leftIndex, List<Node> rightNodes, String rightIndex,
			ConstraintGenerator cg, boolean isBaseComparison) {

		int orderByColCount = Math.min(leftNodes.size(), rightNodes.size());
		List<BoolExpr> equalityHistory = new ArrayList<>();
		List<BoolExpr> orClauses = new ArrayList<>();
		// Build bound variable/index expressions
		Expr leftIdxExpr = leftIndex.matches("-?\\d+")
				? ConstraintGenerator.ctx.mkInt(leftIndex)
				: ConstraintGenerator.ctx.mkIntConst(leftIndex);
		if (Configuration.isEnumInt.equalsIgnoreCase("true")) {
			EnumSort currentSort = (EnumSort) ConstraintGenerator.ctxSorts.get(cvc.enumArrayIndex);
			leftIdxExpr = ConstraintGenerator.ctx.mkConst(leftIndex, currentSort);
		}
		Expr rightIdxExpr = rightIndex.matches("-?\\d+")
				? ConstraintGenerator.ctx.mkInt(rightIndex)
				: ConstraintGenerator.ctx.mkIntConst(rightIndex);
		if (Configuration.isEnumInt.equalsIgnoreCase("true")) {
			EnumSort currentSort = (EnumSort) ConstraintGenerator.ctxSorts.get(cvc.enumArrayIndex);
			rightIdxExpr = ConstraintGenerator.ctx.mkConst(rightIndex, currentSort);
		}
		for (int k = 0; k < orderByColCount; k++) {
			Column col = leftNodes.get(k).getColumn();
			Expr expr1 = ConstraintGenerator.smtMap(leftNodes.get(k).getColumn(), leftIdxExpr);
			Expr expr2 = ConstraintGenerator.smtMap(rightNodes.get(k).getColumn(), rightIdxExpr);
			boolean isLast = (k == orderByColCount - 1);
			String op;
			// Logic for Ascending/Descending and Base vs Result comparison
			if (leftNodes.get(k).orderByDirAsc) {
				if (isBaseComparison) {
					op = isLast ? ">=" : ">";
				} else {
					op = isLast ? "<=" : "<";
				}
			} else {
				if (isBaseComparison) {
					op = isLast ? "<=" : "<";
				} else {
					op = isLast ? ">=" : ">";
				}
			}
			BoolExpr comparison = getComparisonExpr(col, op, expr1, expr2);

			if (equalityHistory.isEmpty()) {
				orClauses.add(comparison);
			} else {
				List<BoolExpr> andTerms = new ArrayList<>(equalityHistory);
				andTerms.add(comparison);
				orClauses.add(ConstraintGenerator.ctx.mkAnd(andTerms.toArray(new BoolExpr[0])));
			}

			equalityHistory.add(getComparisonExpr(col, "=", expr1, expr2));
		}
		if (orClauses.size() == 1) {
			return orClauses.get(0);
		} else {
			return ConstraintGenerator.ctx.mkOr(orClauses.toArray(new BoolExpr[0]));
		}
	}

	/**
	 * Condition 1: Sort based on columns given in order by
	 */
	private static String getSortOrderConstraints(GenerateCVC1 cvc, QueryBlockDetails queryBlock,
			List<Node> orderByNodes, int limit, ConstraintGenerator cg) {
		StringBuilder sb = new StringBuilder();
		sb.append(ConstraintGenerator.addCommentLine("Condition 1: Sort based on order by"));
		for (int i = 1; i < limit; i++) {
			String comparision = buildLexicographicalComparison(cvc, queryBlock, orderByNodes, String.valueOf(i),
					orderByNodes, String.valueOf(i + 1), cg, false).toString();
			sb.append(String.format("(assert %s)\n", comparision));
		}
		return sb.toString();
	}

	/**
	 * Condition 2: Contiguity Constraint (Make sure only top rows are valid)
	 */
	private static String getContiguityConstraints(GenerateCVC1 cvc, String resTableName, int resCntColIndex,
			int limit) {
		StringBuilder sb = new StringBuilder();
		sb.append(ConstraintGenerator.addCommentLine("Condition 2: Top rows are valid"));
		for (int i = 1; i < limit; i++) {
			Expr cnt_i = ConstraintGenerator.genSelectTest(cvc, resTableName, resCntColIndex, i);
			Expr cnt_iplus1 = ConstraintGenerator.genSelectTest(cvc, resTableName, resCntColIndex, i + 1);
			BoolExpr valid_i = ConstraintGenerator.ctx.mkGt((ArithExpr) cnt_i,
					(ArithExpr) ConstraintGenerator.ctx.mkInt(0));
			BoolExpr valid_iplus1 = ConstraintGenerator.ctx.mkGt((ArithExpr) cnt_iplus1,
					(ArithExpr) ConstraintGenerator.ctx.mkInt(0));
			BoolExpr implies = ConstraintGenerator.ctx.mkImplies(valid_iplus1, valid_i);
			sb.append(String.format("(assert %s)\n", implies.toString()));
		}
		return sb.toString();
	}

	/**
	 * Condition 3: Total Cardinality Constraint
	 */
	private static String getTotalCardinalityConstraints(GenerateCVC1 cvc, String resTableName, int resCntColIndex,
			String baseTableName, int baseCntColIndex, int baseTuples, int limit) {
		StringBuilder sb = new StringBuilder();
		sb.append(ConstraintGenerator.addCommentLine("Condition 3: Total Result Size = MIN(Limit,Total Input)"));

		List<String> inputCnts = new ArrayList<>();
		for (int j = 1; j <= baseTuples; j++) {
			String cnt_j = ConstraintGenerator.genSelectTest(cvc, baseTableName, baseCntColIndex, j).toString();
			inputCnts.add(cnt_j);
		}
		String sum_I = inputCnts.isEmpty() ? "0"
				: (inputCnts.size() == 1 ? inputCnts.get(0) : "(+ " + String.join(" ", inputCnts) + ")");
		List<String> outputCnts = new ArrayList<>();
		for (int i = 1; i <= limit; i++) {
			String cnt_i = ConstraintGenerator.genSelectTest(cvc, resTableName, resCntColIndex, i).toString();
			outputCnts.add(cnt_i);
		}
		String sum_A = outputCnts.isEmpty() ? "0"
				: (outputCnts.size() == 1 ? outputCnts.get(0) : "(+ " + String.join(" ", outputCnts) + ")");
		sb.append(String.format(
				"(assert (let ((sum_I %s) (sum_A %s))\n" +
						"  (= sum_A (ite (>= sum_I %d) %d sum_I))))\n",
				sum_I, sum_A, limit, limit));
		return sb.toString();
	}

	/**
	 * Condition 4: Backward Mapping
	 */
	private static String getBackwardMappingConstraints(GenerateCVC1 cvc, String resTableName, int resCntColIndex,
			String baseTableName, int baseCntColIndex, int baseTuples, int limit) {
		StringBuilder sb = new StringBuilder();
		sb.append(ConstraintGenerator.addCommentLine("Condition 4: Backward Mapping"));
		Expr j = ConstraintGenerator.ctx.mkIntConst("j");
		FuncDecl mapFunc = ConstraintGenerator.ctx.mkFuncDecl(
				resTableName + "_map_" + baseTableName,
				new Sort[] { ConstraintGenerator.ctx.getIntSort(), ConstraintGenerator.ctx.getIntSort() },
				ConstraintGenerator.ctx.getBoolSort());
		for (int i = 1; i <= limit; i++) {
			Expr cnt_i = ConstraintGenerator.genSelectTest(cvc, resTableName, resCntColIndex, i);

			// O[i].CNT > 0
			BoolExpr gt_i = ConstraintGenerator.ctx.mkGt((ArithExpr) cnt_i,
					(ArithExpr) ConstraintGenerator.ctx.mkInt(0));
			// I[j].CNT
			Expr base_cnt_j = ConstraintGenerator.genSelectTest2(cvc, baseTableName, baseCntColIndex, "j");
			// Inner mapping count logic:
			// If i < L and O[i+1].CNT > 0 then O[i].CNT = I[j].CNT else O[i].CNT <=
			// I[j].CNT
			Expr innerExpr;
			if (i < limit) {
				Expr cnt_iplus1 = ConstraintGenerator.genSelectTest(cvc, resTableName, resCntColIndex, i + 1);
				BoolExpr gt_iplus1 = ConstraintGenerator.ctx.mkGt((ArithExpr) cnt_iplus1,
						(ArithExpr) ConstraintGenerator.ctx.mkInt(0));
				BoolExpr eq_cnt = ConstraintGenerator.ctx.mkEq(cnt_i, base_cnt_j);
				BoolExpr le_cnt = ConstraintGenerator.ctx.mkLe((ArithExpr) cnt_i, (ArithExpr) base_cnt_j);
				innerExpr = ConstraintGenerator.ctx.mkITE(gt_iplus1, eq_cnt, le_cnt);
			} else {
				innerExpr = ConstraintGenerator.ctx.mkLe((ArithExpr) cnt_i, (ArithExpr) base_cnt_j);
			}
			// (>= j 1)
			BoolExpr j_ge = ConstraintGenerator.ctx.mkGe((ArithExpr) j, (ArithExpr) ConstraintGenerator.ctx.mkInt(1));

			// (<= j baseTuples)
			BoolExpr j_le = ConstraintGenerator.ctx.mkLe((ArithExpr) j,
					(ArithExpr) ConstraintGenerator.ctx.mkInt(baseTuples));
			// (res_map_base j i)
			BoolExpr mapApp = (BoolExpr) mapFunc.apply(j, ConstraintGenerator.ctx.mkInt(i));
			// Combine all conditions inside existential quantifier:
			// (and (>= j 1) (<= j baseTuples) (res_map_base j i) innerExpr)
			BoolExpr existsBody = ConstraintGenerator.ctx.mkAnd(j_ge, j_le, mapApp, (BoolExpr) innerExpr);
			// (exists ((j Int)) existsBody)
			BoolExpr existsExpr = ConstraintGenerator.ctx.mkExists(
					new Expr[] { j },
					existsBody,
					1,
					null,
					null,
					null,
					null);
			// (=> (> cnt_i 0) existsExpr)
			BoolExpr backwardAssert = ConstraintGenerator.ctx.mkImplies(gt_i, existsExpr);
			sb.append(String.format("(assert %s)\n", backwardAssert.toString()));
		}
		return sb.toString();
	}

	/**
	 * Condition 5: Forward Mapping (Top-K Guarantee)
	 */
	private static String getForwardMappingConstraints(GenerateCVC1 cvc, QueryBlockDetails queryBlock,
			List<Node> baseNodes, List<Node> resultNodes, String resTableName, int resCntColIndex, String baseTableName,
			int baseCntColIndex, int baseTuples, int limit, ConstraintGenerator cg) {
		StringBuilder sb = new StringBuilder();
		sb.append(ConstraintGenerator.addCommentLine("Condition 5: Forward Mapping"));

		Expr j = ConstraintGenerator.ctx.mkIntConst("j");
		// (and (>= j 1) (<= j baseTuples) (> base_cnt_j 0))
		Expr base_cnt_j = ConstraintGenerator.genSelectTest2(cvc, baseTableName, baseCntColIndex, "j");

		BoolExpr j_ge = ConstraintGenerator.ctx.mkGe((ArithExpr) j, (ArithExpr) ConstraintGenerator.ctx.mkInt(1));
		BoolExpr j_le = ConstraintGenerator.ctx.mkLe((ArithExpr) j,
				(ArithExpr) ConstraintGenerator.ctx.mkInt(baseTuples));
		BoolExpr base_cnt_gt = ConstraintGenerator.ctx.mkGt((ArithExpr) base_cnt_j,
				(ArithExpr) ConstraintGenerator.ctx.mkInt(0));

		BoolExpr antecedent = ConstraintGenerator.ctx.mkAnd(j_ge, j_le, base_cnt_gt);

		FuncDecl mapFunc = ConstraintGenerator.ctx.mkFuncDecl(
				resTableName + "_map_" + baseTableName,
				new Sort[] { ConstraintGenerator.ctx.getIntSort(), ConstraintGenerator.ctx.getIntSort() },
				ConstraintGenerator.ctx.getBoolSort());
		List<BoolExpr> mapExprs = new ArrayList<>();
		List<BoolExpr> greaterThanExprs = new ArrayList<>();
		for (int i = 1; i <= limit; i++) {
			// (res_map_base j i)
			mapExprs.add((BoolExpr) mapFunc.apply(j, ConstraintGenerator.ctx.mkInt(i)));
			// (> cnt_i 0)
			Expr cnt_i = ConstraintGenerator.genSelectTest(cvc, resTableName, resCntColIndex, i);
			BoolExpr gt_i = ConstraintGenerator.ctx.mkGt((ArithExpr) cnt_i,
					(ArithExpr) ConstraintGenerator.ctx.mkInt(0));
			// Generate base_ge_res_i comparison string
			BoolExpr base_ge_res_i = buildLexicographicalComparison(cvc, queryBlock, baseNodes, "j",
					resultNodes, String.valueOf(i), cg, true);

			// (=> (> cnt_i 0) base_ge_res_i)
			greaterThanExprs.add(ConstraintGenerator.ctx.mkImplies(gt_i, base_ge_res_i));
		}
		// (and (=> (> cnt_1 0) base_ge_res_1) ...)
		BoolExpr andOfGreater = ConstraintGenerator.ctx.mkAnd(greaterThanExprs.toArray(new BoolExpr[0]));
		// (or map_1 ... map_L andOfGreater)
		List<BoolExpr> orElements = new ArrayList<>(mapExprs);
		orElements.add(andOfGreater);
		BoolExpr consequent = ConstraintGenerator.ctx.mkOr(orElements.toArray(new BoolExpr[0]));
		BoolExpr forallBody = ConstraintGenerator.ctx.mkImplies(antecedent, consequent);
		// Wrap in (forall ((j Int)) forallBody)
		BoolExpr forallExpr = ConstraintGenerator.ctx.mkForall(
				new Expr[] { j },
				forallBody,
				1,
				null,
				null,
				null,
				null);
		sb.append(String.format("(assert %s)\n", forallExpr.toString()));
		return sb.toString();
	}

	/*
	 * ORDER BY with LIMIT L
	 */
	static public String getLimitAndOrderByConstraints(GenerateCVC1 cvc, QueryBlockDetails queryBlock,
			Table resultTable, ArrayList<String> resultColumns, String baseTableName) {
		List<Node> baseNodes = queryBlock.getOrderByNodes();
		if (baseNodes.isEmpty())
			return "";
		List<Node> resultNodes = new ArrayList<>();
		for (Node baseNode : baseNodes) {
			String baseTab = baseNode.getTable().getTableName();
			String baseCol = baseNode.getColumn().getColumnName();
			for (String resColName : resultColumns) {
				if (resColName.contains(baseTab) && resColName.contains(baseCol)) {
					Node temp = new Node(baseNode);
					temp.setTable(resultTable);
					temp.setTableNameNo(resultTable.toString());
					temp.setColumn(resultTable.getColumn(resColName));
					resultNodes.add(temp);
					break;
				}
			}
		}
		Table baseSQTable = cvc.getTableMap().getTables().containsKey(baseTableName.toUpperCase())
				? cvc.getTableMap().getTable(baseTableName.toUpperCase())
				: cvc.getTableMap().getSQTableByName(baseTableName);
		if (cvc.getTableMap().getSQTables().containsKey(baseTableName)) {
			for (int i = 0; i < baseNodes.size(); i++) {
				String baseTab = baseNodes.get(i).getTable().getTableName();
				String baseCol = baseNodes.get(i).getColumn().getColumnName();
				for (String col : baseSQTable.getColumns().keySet()) {
					if (col.contains(baseTab) && col.contains(baseCol)) {
						baseNodes.get(i).setTable(baseSQTable);
						baseNodes.get(i).setTableNameNo(baseTableName);
						baseNodes.get(i).setColumn(baseSQTable.getColumn(col));
					}
				}
			}

		}
		int limit = queryBlock.getLimit();

		int baseTuples = cvc.getNoOfOutputTuples(baseTableName);
		if (limit == 0) {
			limit = baseTuples;
		}

		int colCntBaseTable = baseSQTable.getNoOfColumn();
		int baseCntColIndex = colCntBaseTable - 1;
		int resCntColIndex = resultTable.getNoOfColumn() - 1;
		String resTableName = resultTable.getTableName();
		ConstraintGenerator cg = new ConstraintGenerator();
		StringBuilder sb = new StringBuilder();
		sb.append(getSortOrderConstraints(cvc, queryBlock, resultNodes, limit, cg));
		sb.append(getContiguityConstraints(cvc, resTableName, resCntColIndex, limit));
		sb.append(getTotalCardinalityConstraints(cvc, resTableName, resCntColIndex, baseTableName, baseCntColIndex,
				baseTuples, limit));
		sb.append(getBackwardMappingConstraints(cvc, resTableName, resCntColIndex, baseTableName, baseCntColIndex,
				baseTuples, limit));
		sb.append(getForwardMappingConstraints(cvc, queryBlock, baseNodes, resultNodes, resTableName, resCntColIndex,
				baseTableName, baseCntColIndex, baseTuples, limit, cg));
		return sb.toString();
	}

	static public String getConstraintsForSelectionConds(GenerateCVC1 cvc, QueryBlockDetails queryBlock,
			Vector<String> joinTables, String joinTable, Table sqTable, boolean isExist, ArrayList<String> jtColumns,
			Vector<String> cntColumnNames, Table baseTable, Vector<Node> correlationConds) throws Exception {
		String constr = "";

		// Safety check: if there are no join tables, return empty constraint
		if (joinTables == null || joinTables.isEmpty()) {
			return "";
		}

		int tuplesInJoinTable = cvc.getNoOfOutputTuples(joinTables.get(0));
		cvc.putNoOfOutputTuples(joinTable, tuplesInJoinTable);
		cvc.getNoOfTuples().put(joinTable, tuplesInJoinTable);
		int cnt = 0;
		boolean isCorrCondPresent = false;

		// HashMap<Node, correlationStructure> correlationHashMap = new HashMap<>();
		// if (cvc.correlationHashMap != null) {
		// correlationHashMap = cvc.correlationHashMap;
		// cvc.correlationHashMap.clear();
		// }
		// for (int i = 1; i <= tuplesInJoinTable; i++) {

		// List<Integer> indList = new ArrayList<>();
		// indList.add(i);

		// Map<String, Object> returnVal =
		// getForwardPassJoinandSelectionConstraints(cvc, queryBlock,
		// queryBlock.getConjunctsQs().get(0), sqTable, joinTables,
		// queryBlock.getConjunctsQs().get(0).getSelectionConds(),
		// queryBlock.getConjunctsQs().get(0).getJoinCondsForEquivalenceClasses(),
		// queryBlock.getConjunctsQs().get(0).getJoinCondsAllOther(),
		// queryBlock.getConjunctsQs().get(0).getStringSelectionConds(),
		// queryBlock.getConjunctsQs().get(0).getInClauseConds(),
		// queryBlock.getConjunctsQs().get(0).getIsNullConds(), true, indList, cnt,
		// isExist);
		// isCorrCondPresent = (Boolean) returnVal.get("isCorrCondPresent");
		// correlationConds = (Vector<Node>) returnVal.get("correlationConds");
		// String selCond = (String) returnVal.get("constr");

		// isCorrCondPresent = (Boolean) returnVal.get("isCorrCondPresent");
		// String cntColumnsInBaseTableValid = ConstraintGenerator.ctx.mkGt(
		// ConstraintGenerator.genSelectTest(cvc, joinTables.get(0),
		// baseTable.getNoOfColumn() - 1, i),
		// ConstraintGenerator.ctx.mkInt(0)).toString();
		// String mapPart = "(" + joinTable + "_map_" + joinTables.get(0) + " " + i + "
		// " + i + ")";
		// constr += "(assert\n(=> (and \n" + selCond + "\n\n" +
		// cntColumnsInBaseTableValid + ")\n" + mapPart
		// + ")\n)\n\n";
		// }
		// Processing correlation conditions
		// for(Node n:new ArrayList<>(cvc.correlationHashMap.keySet())){
		// if (n.getExpired() == false) {
		// correlationStructure cs = cvc.correlationHashMap.get(n);
		// if (cs != null && cs.getProcessLevel() < queryBlock.getLevel()) {
		// isCorrCondPresent = true;
		// // update the table name and column in node from below level JSQ
		// updateTableAndColumnOfCorrelatedConditionWithAboveLevel(cvc, queryBlock, n,
		// sqTable, queryBlock.getLevel(), false);
		// }
		// }
		// }
		Vector<Table> tables = new Vector<>();
		tables.add(baseTable);
		Expr cntOfSQColumnSQforAllTuples = ConstraintGenerator.genSelectTest2(cvc, joinTable,
				jtColumns.indexOf(cntColumnNames.get(cntColumnNames.size() - 1)), "i1");
		// JSQ0_cnt>0
		Expr greaterCnt = ConstraintGenerator.ctx.mkGt((ArithExpr) cntOfSQColumnSQforAllTuples,
				(ArithExpr) ConstraintGenerator.ctx.mkInt(0));
		greaterCnt = ConstraintGenerator.ctx.mkGt((ArithExpr) cntOfSQColumnSQforAllTuples,
				(ArithExpr) ConstraintGenerator.ctx.mkInt(0));
		// if (isCorrCondPresent)
		// greaterCnt = ConstraintGenerator.ctx.mkGt((ArithExpr)
		// cntOfSQColumnSQforAllTuples,
		// (ArithExpr) ConstraintGenerator.ctx.mkInt(0));
		// else if (!isExist)
		// greaterCnt = ConstraintGenerator.ctx.mkEq((ArithExpr)
		// cntOfSQColumnSQforAllTuples,
		// (ArithExpr) ConstraintGenerator.ctx.mkInt(0));
		// t=(and (> (JSQ0__XDATA_CNT (select O_JSQ0 i1 )) 0 ) (not (CHECKALL_NULLInt
		// (JSQ0__XDATA_CNT (select O_JSQ0 i1))))
		// (>= (JSQ0_JSQ1_student__TOT_CRED33 (select O_JSQ0 i1)) 5 )
		// (ISNULL_ID (JSQ0_JSQ1_takes__ID05 (select O_JSQ0 i1)))
		// )
		// String t = getBackwardPassJoinandSelectionConstraints(cvc, queryBlock,
		// queryBlock.getConjunctsQs().get(0), sqTable, tables,
		// queryBlock.getConjunctsQs().get(0).getSelectionConds(),
		// queryBlock.getConjunctsQs().get(0).getJoinCondsForEquivalenceClasses(),
		// queryBlock.getConjunctsQs().get(0).getJoinCondsAllOther(),
		// queryBlock.getConjunctsQs().get(0).getStringSelectionConds(),
		// queryBlock.getConjunctsQs().get(0).getInClauseConds(),
		// queryBlock.getConjunctsQs().get(0).getIsNullConds(),
		// jtColumns, joinTable, true);
		if (queryBlock.getLimit() != 0 || queryBlock.getOrderByNodes().size() > 0) {
			int limit = queryBlock.getLimit();
			if (limit == 0) {
				limit = tuplesInJoinTable;
			}
			tuplesInJoinTable = limit;
			cvc.putNoOfOutputTuples(joinTable, tuplesInJoinTable);
			cvc.getNoOfTuples().put(joinTable, tuplesInJoinTable);
			String orderByConst = getLimitAndOrderByConstraints(cvc, queryBlock, sqTable, jtColumns, joinTables.get(0));
			return orderByConst;
		}

		String t = "";
		String forallConstr = "(assert (forall ((i1 Int)) \n" +
				" (=> " + greaterCnt.toString() + "\n" +
				"(and \n" +
				"    (> i1 0)\n" +
				"    (<= i1 " + tuplesInJoinTable + ")\n" +
				"    " + t + "\n" +
				"    (" + joinTable + "_map_" + joinTables.get(0) + " i1 i1)\n" +
				" )\n" +
				")))\n";
		// String forallConstr = "(assert (forall ((i1 Int)) \n" +
		// " (" + joinTable + "_map_" + joinTables.get(0) + " i1 i1)\n" +
		// " )\n)" ;

		constr += forallConstr;
		// Expr baseTableCnt = ConstraintGenerator.genSelectTest2(cvc,
		// joinTables.get(0),
		// baseTable.getNoOfColumn() - 1, "i1");
		// Expr baseCntGt0 = ConstraintGenerator.ctx.mkGt((ArithExpr) baseTableCnt,
		// (ArithExpr) ConstraintGenerator.ctx.mkInt(0));

		// String mapCall = "(" + joinTable + "_map_" + joinTables.get(0) + " i1 i1)";

		// String backwardConstr = "(assert (forall ((i1 Int)) \n" +
		// " (=> (and (> i1 0) (<= i1 " + tuplesInJoinTable + ") " +
		// baseCntGt0.toString() + ")\n" +
		// " (and \n" +
		// " " + greaterCnt.toString() + "\n" + // Using your variable here
		// " " + mapCall + "\n" +
		// " )\n" +
		// " )))\n";

		// constr += backwardConstr;

		// if (correlationHashMap.size() > 0) {
		// cvc.correlationHashMap = correlationHashMap;
		// }
		return constr;
	}

	// TODO: Need to remove this
	static public boolean checkForOuterJoin(Vector<String> v) {
		for (int i = 0; i < v.size(); i++) {
			if (v.get(i).equals(JoinClauseInfo.fullOuterJoin) || v.get(i).equals(JoinClauseInfo.leftOuterJoin)
					|| v.get(i).equals(JoinClauseInfo.rightOuterJoin))
				return true;
		}
		return false;
	}

	public static String getMappingFunctions(GenerateCVC1 cvc, Vector<Table> tables, Table resultSQTable,
			String joinType) {

		String constr = "";
		int joincol = 0, resTableColCnt = resultSQTable.getNoOfColumn();
		String joinTable = resultSQTable.toString();
		Vector<String> joinTables = new Vector<>();
		joinTables.add(tables.get(0).toString());
		if (!(joinType.equals(JoinClauseInfo.semiJoin) || joinType.equals(JoinClauseInfo.antiJoin)))
			joinTables.add(tables.get(1).toString());
		String indexType = "Int";
		ConstraintGenerator cg = new ConstraintGenerator();
		for (int i = 0; i < joinTables.size(); i++) {//
			HashMap<String, Column> columns = tables.get(i).getColumns();

			Vector<String> columnString = new Vector<String>(columns.keySet());
			String fun = ("define-fun " + joinTable + "_map_" + joinTables.get(i) + "((x!0 " + indexType + ") (x!1 "
					+ indexType + ")) Bool\n");
			if ((!joinType.equals(JoinClauseInfo.innerJoin)) && (joinType.equals(JoinClauseInfo.fullOuterJoin)
					|| (i == 0 && joinType.equals(JoinClauseInfo.rightOuterJoin))
					|| (i == 1 && joinType.equals(JoinClauseInfo.leftOuterJoin)))) {

				String NullFun = ("define-fun " + joinTable + "_map_" + joinTables.get(i) + "_NULL" + "((x!0 "
						+ indexType + ")) Bool\n");
				String isNull = "\n(" + NullFun + "(and \n";
				int colj = 0;
				int temp = joincol;
				while (colj < columns.size() && temp < resTableColCnt) {
					// (JSQ0_student__NAME1 (select O_JSQ0 x!1))
					Column col = columns.get(columnString.get(colj));
					Expr right = ConstraintGenerator.genSelectTest2(cvc, joinTable, temp, "x!0");
					String baseTableCol = col.toString();
					String resTableCol = resultSQTable.getColumn(temp).toString();
					if (resTableCol.contains("__"))
						resTableCol = resTableCol.split("__")[1];
					if (baseTableCol.contains("__"))
						baseTableCol = baseTableCol.split("__")[1];
					resTableCol = resTableCol.replaceAll("\\d+$", "");
					baseTableCol = baseTableCol.replaceAll("\\d+$", "");
					if (!baseTableCol.equals(resTableCol)) {
						colj++;
						continue;
					}
					if (columnString.get(colj).contains("CNT")) {
						isNull += "( = " + right.toString() + " 1 )";
					} else {
						// getAssertNotNullConditionForSQTable(cvc,)
						isNull += cg.getAssertNullConditionForSQTable(col.getCvcDatatype(), right, "x!1",
								columnString.get(colj));
					}
					isNull += "\n";

					colj++;
					temp++;
				}
				isNull += ")\n)\n";
				constr += isNull;
			}

			constr += "\n(" + fun + "(and \n";
			int col1 = 0;
			while (col1 < columns.size() && joincol < resTableColCnt) {
				Expr left = ConstraintGenerator.genSelectTest2(cvc, joinTables.get(i),
						tables.get(i).getColumnIndex(columnString.get(col1)), "x!0");
				// (JSQ0_student__NAME1 (select O_JSQ0 x!1))
				Expr right = ConstraintGenerator.genSelectTest2(cvc, joinTable, joincol, "x!1");
				String baseCol = columnString.get(col1);
				String resCol = resultSQTable.getColumn(joincol).toString();
				baseCol = baseCol.contains("__") ? baseCol = baseCol.split("__")[1] : baseCol;
				resCol = resCol.contains("__") ? resCol.split("__")[1] : resCol;
				baseCol = baseCol.replaceAll("\\d+$", "");
				resCol = resCol.replaceAll("\\d+$", "");
				if (baseCol.equals(resCol)) {
					Expr eq = ConstraintGenerator.ctx.mkEq(left, right);
					constr += eq.toString() + "\n";
					joincol++;
				}

				col1++;
			}
			constr += ")\n)\n";
		}
		return constr;
	}

	public static int getTupleCount(GenerateCVC1 cvc, QueryBlockDetails queryBlock, Vector<Table> tables,
			String joinTable) throws Exception {
		int tuplesInJoinTable;
		Vector<String> joinTables = new Vector<>();
		for (int i = 0; i < tables.size(); i++)
			joinTables.add(tables.get(i).toString());
		Vector<Node> CondForCount = new Vector<>();

		CondForCount.addAll(queryBlock.getConjunctsQs().get(0).getSelectionConds());
		CondForCount.addAll(queryBlock.getConjunctsQs().get(0).getJoinCondsForEquivalenceClasses());
		CondForCount.addAll(queryBlock.getConjunctsQs().get(0).getJoinCondsAllOther());
		CondForCount.addAll(queryBlock.getConjunctsQs().get(0).getStringSelectionConds());

		tuplesInJoinTable = getOptimalTupleCountForJoinTable(cvc, CondForCount, tables);
		// chaitra changed here for case no of tuples
		if (cvc.noOfOutputTuplesContains(joinTable))
			tuplesInJoinTable = Math.max(tuplesInJoinTable, cvc.getNoOfOutputTuples(joinTable));
		if (cvc.getqStructure().isCase > 0)
			tuplesInJoinTable = Math.max(tuplesInJoinTable, cvc.getqStructure().isCase + 1);
		int base = 2;

		int baseTableSize = 0;
		for (int i = 0; i < tables.size(); i++) {
			if (joinTables.size() == 1) {
				baseTableSize++;
			} else if (joinTables.get(i).contains("JSQ") && !tables.get(i).getSQType().equalsIgnoreCase("from")
					|| joinTables.get(i).contains("GSQ") || joinTables.get(i).contains("DSQ"))
				continue;
			else
				baseTableSize++;
		}

		int updatedTuplesInJoinTable = (int) Math.round(Math.pow(base, baseTableSize));
		if (queryBlock.getLimit() > 0)
			updatedTuplesInJoinTable = Math.max(updatedTuplesInJoinTable, queryBlock.getLimit() + 1);
		tuplesInJoinTable = Math.max(tuplesInJoinTable, cvc.getNoOfMaxOutputTuples(joinTable));
		updatedTuplesInJoinTable = Math.max(Math.min(updatedTuplesInJoinTable, tuplesInJoinTable),
				cvc.getNoOfMaxOutputTuples(joinTable));
		if (tuplesInJoinTable > 10)
			tuplesInJoinTable = updatedTuplesInJoinTable;

		if (tuplesInJoinTable < 4) {
			if (cvc.getCurrentMutant() != null && (cvc.getCurrentMutant().getMutationTypeNumber() == 7
					|| cvc.getCurrentMutant().getMutationTypeNumber() == 8
					|| cvc.getCurrentMutant().getMutationTypeNumber() == 2)) {
				tuplesInJoinTable = tuplesInJoinTable + 3;
			}
			if (cvc.getCurrentMutant() != null && (cvc.getCurrentMutant().getMutationTypeNumber() == 5)) {
				tuplesInJoinTable = updatedTuplesInJoinTable;
			}
		}
		return tuplesInJoinTable;
	}

	static String getJoinConditionConstraints(GenerateCVC1 cvc, QueryBlockDetails queryBlock, Vector<String> joinTables,
			Vector<Node> joinCondNodes,
			List<Integer> indList) {
		if (joinCondNodes == null || joinCondNodes.isEmpty())
			return "";

		ConstraintGenerator constrGen = new ConstraintGenerator();
		StringBuilder combinedConstr = new StringBuilder();

		if (joinCondNodes.size() > 1) {
			combinedConstr.append("(and \n");
		}

		for (Node n : joinCondNodes) {
			String leftIndex = "i1";
			String rightIndex = "j1";

			String leftTablename = "", leftColumnname = "", rightColumnname = "", rightTableName = "";
			if (n.getLeft() != null && n.getLeft().getType().equals(Node.getColRefType())) {
				leftTablename = n.getLeft().getTable() == null ? n.getLeft().getTableAlias()
						: n.getLeft().getTable().getTableName();
				leftColumnname = n.getLeft().getColumn().getColumnName();
				if (n.getLeft().sqTableAliasName != null) {
					leftTablename = cvc.aliasMappingToLevels
							.get(n.getLeft().sqTableAliasName.toLowerCase()).repSQTable;
					Table aliasTable = cvc.getTableMap().getSQTableByName(leftTablename);
					n.getLeft().setTable(aliasTable);
					n.getLeft().setTableNameNo(aliasTable.toString());
					n.getLeft().setTableNameNo(aliasTable.toString());
					for (Column col : aliasTable.getColumns().values()) {
						if (col.toString().contains(leftColumnname)) {
							n.getLeft().setColumn(col);
							leftColumnname = col.toString();
							break;
						}
					}

				}
			}

			if (n.getRight() != null && n.getRight().getType().equals(Node.getColRefType())) {
				rightTableName = n.getRight().getTable() == null ? n.getRight().getTableAlias()
						: n.getRight().getTable().getTableName();
				rightColumnname = n.getRight().getColumn().getColumnName();

			}
			int li = joinTables.indexOf(leftTablename);
			int ri = joinTables.indexOf(rightTableName);

			leftIndex = li != -1 ? indList.get(li) + "" : "";
			rightIndex = ri != -1 ? indList.get(ri) + "" : "";

			String s1 = ConstraintGenerator.genPositiveCondsForPredF(cvc, queryBlock, n.getLeft(), leftIndex);
			String s2 = ConstraintGenerator.genPositiveCondsForPredF(cvc, queryBlock, n.getRight(), rightIndex);

			// get non null constraints
			String nonConstr = constrGen.getAssertNotNullCondition(cvc, n.getLeft(), leftIndex);
			nonConstr += constrGen.getAssertNotNullCondition(cvc, n.getRight(), rightIndex);

			String op = "";
			String tempConstr = "";
			if (s1 != null && s2 != null && s1.contains("select") && s2.contains("select")) {
				op = constrGen.getUserDefinedComparisionOperator(n.getOperator(), n.getLeft().getColumn(),
						s1, s2);
				tempConstr += "\t\t" + ((n.isNegated) ? "(not " : " ") + op + ((n.isNegated) ? " )" : " ")
						+ "\n";

			} else {
				tempConstr += "\t\t" + ((n.isNegated) ? "(not " : " ") + "("
						+ (n.getOperator().equals("/=") ? "not (= " : n.getOperator()) + "  " + s1
						+ "  " + s2 + (n.getOperator().equals("/=") ? " ) )" : " " + ")")
						+ ((n.isNegated) ? " )" : " ") + "\n";
			}

			if (leftTablename.equalsIgnoreCase(rightTableName)
					&& leftColumnname.equalsIgnoreCase(rightColumnname)
					&& leftIndex.equalsIgnoreCase(rightIndex) && n.isNegated) {
				combinedConstr.append("");
			} else {
				if ((tempConstr + nonConstr) != "")
					combinedConstr.append("(and ").append(tempConstr).append(nonConstr).append(")"); // with non-null
			}
		}

		if (joinCondNodes.size() > 1) {
			combinedConstr.append(") ");
		}
		return combinedConstr.toString();
	}

	public static String generateAntiJoinForwardMapping(GenerateCVC1 cvc, QueryBlockDetails queryBlock,
			Vector<Table> tables, Table resultTable, Vector<Node> joinCondNodes,
			int tupleInResultTable, HashMap<String, Object> jtColumnNamesAndDataTypes) throws Exception {

		StringBuilder finalConstraints = new StringBuilder();
		Table it1 = tables.get(0);
		Table it2 = tables.get(1);

		int it1Size = cvc.getNoOfOutputTuples(it1.toString());
		int it2Size = cvc.getNoOfOutputTuples(it2.toString());

		String joinTable = resultTable.toString();
		Vector<String> cntColumnNames = (Vector<String>) jtColumnNamesAndDataTypes.get("CountColumns");
		ArrayList<String> jtColumns = (ArrayList<String>) jtColumnNamesAndDataTypes.get("Names");
		int resCntIdx = jtColumns.indexOf(cntColumnNames.get(cntColumnNames.size() - 1));

		for (int j = 1; j <= it1Size; j++) {

			String t1Valid = "(> " + ConstraintGenerator.genSelectTest(cvc, it1.toString(), it1.getNoOfColumn() - 1, j)
					+ " 0)";

			StringBuilder noMatchInIT2 = new StringBuilder();
			noMatchInIT2.append("(and ");
			for (int k = 1; k <= it2Size; k++) {
				String t2Valid = "(> "
						+ ConstraintGenerator.genSelectTest(cvc, it2.toString(), it2.getNoOfColumn() - 1, k) + " 0)";

				StringBuilder joinConditionFalse = new StringBuilder();
				joinConditionFalse.append("(or ");
				for (Node node : joinCondNodes) {
					int it1Col = it1.getColumnIndex(node.getLeft().getColumn().getColumnName());
					int it2Col = it2.getColumnIndex(node.getRight().getColumn().getColumnName());
					String s1 = ConstraintGenerator.genSelectTest(cvc, it1.toString(), it1Col, j).toString();
					String s2 = ConstraintGenerator.genSelectTest(cvc, it2.toString(), it2Col, k).toString();

					joinConditionFalse.append("(not (= ").append(s1).append(" ").append(s2).append(")) ");
				}
				joinConditionFalse.append(")");

				noMatchInIT2.append("\n\t\t\t(or (not ").append(t2Valid).append(") ").append(joinConditionFalse)
						.append(") ");
			}
			noMatchInIT2.append(")");

			StringBuilder resultExists = new StringBuilder();
			resultExists.append("(or ");
			for (int i = 1; i <= tupleInResultTable; i++) {
				String resValid = "(> " + ConstraintGenerator.genSelectTest(cvc, joinTable, resCntIdx, i) + " 0)";
				String mapping = "(" + joinTable + "_map_" + it1.getTableName() + " " + j + " " + i + ")";
				resultExists.append("\n\t\t(and ").append(resValid).append(" ").append(mapping).append(") ");
			}
			resultExists.append(")");

			finalConstraints.append("\n(assert (=> (and ").append(t1Valid).append(" ").append(noMatchInIT2)
					.append(")\n\t")
					.append(resultExists).append("\n))");
		}

		return finalConstraints.toString();
	}

	static String getForwardMapping(GenerateCVC1 cvc, QueryBlockDetails queryBlock,
			Vector<Table> tables, Table resultTable, Vector<Node> joinCond, boolean isExist, String joinType,
			int tupleInResultTable, HashMap<String, Object> jtColumnNamesAndDataTypes) throws Exception {
		Vector<String> joinTables = new Vector<>();
		joinTables.add(tables.get(0).toString());
		joinTables.add(tables.get(1).toString());
		String joinTable = resultTable.toString();
		ArrayList<String> jtColumns = (ArrayList<String>) jtColumnNamesAndDataTypes.get("Names");
		Vector<String> cntColumnNames = new Vector<String>();
		String constraintString = "";
		String finalString = "";
		cntColumnNames = (Vector<String>) jtColumnNamesAndDataTypes.get("CountColumns");
		String indexType = "Int";
		String enumIndexVar = "";
		if (Configuration.isEnumInt.equalsIgnoreCase("true")) {
			indexType = cvc.enumArrayIndex;
			enumIndexVar = cvc.enumIndexVar;
		}
		List<Integer> ks = new ArrayList<>(); // Define the list of k's for each element
		for (Table table : tables) {
			String tablename = table.getTableName();
			ks.add(cvc.getNoOfOutputTuples(tablename));
		}
		String constr = "";
		if (joinType.equals(JoinClauseInfo.antiJoin)) {
			constr = generateAntiJoinForwardMapping(cvc, queryBlock, tables, resultTable, joinCond, tupleInResultTable,
					jtColumnNamesAndDataTypes);
			return constr;
		}
		// Generate the domains for each element
		List<List<Integer>> domains = generateDomains(ks);

		// Generate all combinations
		List<List<Integer>> combinations = generateCombinations(domains);

		String unrolldFor = "";
		for (List<Integer> indList : combinations) {

			constr += getJoinConditionConstraints(cvc, queryBlock, joinTables, joinCond, indList);

			Boolean existsUnroll;
			if (Configuration.getProperty("existsUnrollFlag").equalsIgnoreCase("true")) {
				existsUnroll = true;
			} else {
				existsUnroll = false;
			}
			String andExpr = "";
			if (existsUnroll) {
				// Subquery table forward pass with unrolled exist
				String tableIter = "";

				String cntColumnsInBaseTableValid = "";
				// Writing valid tuples in base table for forward pass implies condition
				for (int i = 0; i < tables.size(); i++) {
					tableIter += "(" + joinTables.get(i) + "_i  " + indexType + ")";// (i1 Int)(j1 Int)
					if (joinTables.get(i).contains("JSQ") && !tables.get(i).getIsExist())
						cntColumnsInBaseTableValid += ConstraintGenerator.ctx.mkEq(
								ConstraintGenerator.genSelectTest(cvc, joinTables.get(i),
										tables.get(i).getNoOfColumn() - 1, indList.get(i)),
								ConstraintGenerator.ctx.mkInt(0)).toString();
					else
						cntColumnsInBaseTableValid += ConstraintGenerator.ctx.mkGt(
								ConstraintGenerator.genSelectTest(cvc, joinTables.get(i),
										tables.get(i).getNoOfColumn() - 1, indList.get(i)),
								ConstraintGenerator.ctx.mkInt(0)).toString();
				}
				Expr cntColumnInBaseTable = ConstraintGenerator.ctx.mkTrue();

				// Writing forward pass mapping constraints

				for (int j = 1; j <= tupleInResultTable; j++) {
					String tempStr = "", tableCond = "";
					for (int i = 0; i < tables.size(); i++) {
						HashMap<String, Column> columnsNeedMapping = tables.get(i).getColumns();
						if ((tables.get(i).getTableName().contains("JSQ")
								|| tables.get(i).getTableName().contains("GSQ")
								|| tables.get(i).getTableName().contains("DSQ"))
								&& !tables.get(i).getSQType().equalsIgnoreCase("from")) {
							cntColumnInBaseTable = ConstraintGenerator.genSelectTest(cvc, joinTables.get(i),
									tables.get(i).getNoOfColumn() - 1, j);
							columnsNeedMapping = getRequiredMappingFromSubquery(cvc,
									tables.get(i), queryBlock.getLevel());
							if (columnsNeedMapping.size() == 0)
								continue;
						}

						tableCond += "(" + joinTable + "_map_" + joinTables.get(i) + " " + indList.get(i) + " "
								+ enumIndexVar + j
								+ ")\n";// (SQ1_pred2 j1 k1)\n

					}
					Expr cntOfSQColumnSQjth = ConstraintGenerator.genSelectTest(cvc, joinTable,
							jtColumns.indexOf(cntColumnNames.get(cntColumnNames.size() - 1)), j);

					tempStr += "\t"
							+ ConstraintGenerator.ctx
									.mkGt((ArithExpr) cntOfSQColumnSQjth, ConstraintGenerator.ctx.mkInt(0))
									.toString()
							+ "\n";// constraints for value of cnt > 0

					andExpr += "\n\t(and \n\t\t" + tempStr + "\t\t" + tableCond + "\t)";
				}
				// System.out.println(andExpr);
				constr += cntColumnsInBaseTableValid;
				if (constr != "")
					constr = "(and \n" + constr + "\t\t)";

				unrolldFor = "\n" + (constr != "" ? ("(=> " + constr) + "\n(or" + andExpr : "") + "))";
				constr = "";
				finalString += "\n(assert\t " + (unrolldFor + "\n)");
			} else {
				// Subquery table forward pass using exist in smt
				String tableIter = "", tableCond = "";
				for (int i = 0; i < tables.size(); i++) {
					tableIter += "(" + joinTables.get(i) + "_i  " + indexType + ")";// (i1 Int)(j1 Int)

					tableCond += "(" + joinTable + "_map_" + joinTables.get(i) + " " + joinTables.get(i) + "_i "
							+ joinTable + "_i)\n";// (SQ1_pred2 j1 k1)\n

					Expr cntColumnInBaseTable = ConstraintGenerator.genSelectTest2(cvc, joinTables.get(i),
							tables.get(i).getNoOfColumn() - 1, joinTables.get(i) + "_i");
					if (isExist == false) // sunanda for Not
					{
						constr += ConstraintGenerator.ctx
								.mkEq((ArithExpr) cntColumnInBaseTable, ConstraintGenerator.ctx.mkInt(0)).toString()
								+ "\n";// constraints for value of cnt = 0

					} else
						constr += ConstraintGenerator.ctx
								.mkGt((ArithExpr) cntColumnInBaseTable, ConstraintGenerator.ctx.mkInt(0)).toString()
								+ "\n";// constraints for value of cnt > 0
				}
				constraintString += "(assert (forall (" + tableIter + ") \n\t"
						+ (constr != "" ? ("(=> " + constr) : "")
						+ "  ";
				constraintString += "\n \t(exists ((" + joinTable + "_i " + indexType + ")) ";
				constr = "";
				constr += ConstraintGenerator.ctx
						.mkGt(ConstraintGenerator.ctx.mkIntConst(joinTable + "_i"),
								ConstraintGenerator.ctx.mkInt(0))
						.toString() + "\n";
				constr += ConstraintGenerator.ctx.mkLe(ConstraintGenerator.ctx.mkIntConst(joinTable + "_i"),
						ConstraintGenerator.ctx.mkInt(tupleInResultTable)).toString() + "\n";
				constr += ConstraintGenerator.ctx.mkGt(
						(ArithExpr) ConstraintGenerator.genSelectTest2(cvc, joinTable,
								jtColumns.indexOf(cntColumnNames.get(cntColumnNames.size() - 1)), joinTable + "_i"),
						ConstraintGenerator.ctx.mkInt(0)).toString() + "\n";

				constraintString += "\n\t (and \n" + constr + tableCond + "))\n)\n)" + (constr != "" ? "\n)" : "");
				finalString += constraintString;
			}

		}
		return finalString;
	}

	public static String getBackwardMapping(GenerateCVC1 cvc, QueryBlockDetails queryBlock, Vector<Node> n,
			String joinTable,
			ArrayList<String> jtColumns,
			Vector<Table> tables, int tuplesInJoinTable, Vector<String> cntColumnNames, String joinClauseType) {

		Vector<String> joinTables = new Vector<>();
		joinTables.add(tables.get(0).toString());
		joinTables.add(tables.get(1).toString());
		String enumIndexVar = "";
		String constr = "";
		String indexType = "Int";
		Boolean isCorrCondPresent = false;
		if (Configuration.isEnumInt.equalsIgnoreCase("true")) {
			indexType = cvc.enumArrayIndex;
			enumIndexVar = cvc.enumIndexVar;
		}
		if (joinClauseType.equals(JoinClauseInfo.semiJoin) || joinClauseType.equals(JoinClauseInfo.antiJoin)) {
			isCorrCondPresent = true;

			if (n != null && !n.isEmpty() && joinClauseType.equals(JoinClauseInfo.semiJoin)) {
				constr += generateConstraintsForCorrelationConditionsBackwardPass(cvc, n, joinTable, joinClauseType);
			} else {
				constr += generateCompleteAntiJoinBackwardMapping(cvc, queryBlock, n, joinTable, jtColumns, tables,
						tuplesInJoinTable);
				return constr;
			}
		} else {
			if (n != null) {
				String joinConds = "";
				for (Node node : n) {
					joinConds += generateConstraintsForSelectionConditions(cvc, node, jtColumns, joinTable, tables,
							"i1", "i1") + "\n";
				}
				constr += "( and " + joinConds + " ) \n ";
			}
		}
		String tempBoundaries = "";
		tempBoundaries += ConstraintGenerator.ctx
				.mkGt(ConstraintGenerator.ctx.mkIntConst("i1"), ConstraintGenerator.ctx.mkInt(0)).toString() + "\n";
		tempBoundaries += ConstraintGenerator.ctx
				.mkLe(ConstraintGenerator.ctx.mkIntConst("i1"), ConstraintGenerator.ctx.mkInt(tuplesInJoinTable))
				.toString() + "\n";
		Expr cntOfSQColumnSQi1;
		Expr cntOfSQColumnSQ = ConstraintGenerator.genSelectTest2(cvc, joinTable,
				jtColumns.indexOf(cntColumnNames.get(cntColumnNames.size() - 1)), "i1");
		String mappingConstraints = "";
		Vector<Integer> tuplesInTable = new Vector<Integer>();
		int tupleNo = cvc.getNoOfOutputTuples(tables.get(0).toString());
		tuplesInTable.add(tupleNo);
		tupleNo = cvc.getNoOfOutputTuples(tables.get(1).toString());
		tuplesInTable.add(tupleNo);

		int level = queryBlock.getLevel();
		for (int index = 0; index < tables.size(); index++) {
			String tempconstrTable1 = "";
			for (int i = 1; i <= tuplesInTable.get(index); i++) {
				if (joinTables.get(index).contains("JSQ") && !tables.get(index).getSQType().equalsIgnoreCase("from")
						|| joinTables.get(index).contains("GSQ") || joinTables.get(index).contains("DSQ")) {
					HashMap<String, Column> columnsNeedMapping = getRequiredMappingFromSubquery(cvc,
							tables.get(index), level);
					if (columnsNeedMapping.size() == 0 && !isCorrCondPresent) {
						if (!tables.get(index).getIsExist())
							tempconstrTable1 += ConstraintGenerator.getConstraintsForInValidCountUsingTable(
									tables.get(index), tables.get(index).getTableName(), i, 0);
						else
							tempconstrTable1 += ConstraintGenerator.getConstraintsForValidCountUsingTable(
									tables.get(index), tables.get(index).getTableName(), i, 0);

					}
				} else {
					tempconstrTable1 += "\t\t(" + joinTable + "_map_" + joinTables.get(index) + " \t"
							+ enumIndexVar + Integer.toString(i) + "\t" + "i1" + ")\n";
				}

			}
			if (!tempconstrTable1.isEmpty())
				mappingConstraints += "\t(or " + tempconstrTable1 + "\n\t)\n ";
		}

		// TODO:Add not null condition on join attribute of result table
		// String finalConstraints = "\n" + "( and " + constr + "\n" +
		// mappingConstraints + ")" + " \n ";
		String finalConstraints = "\n" + constr + mappingConstraints;

		String finalOuterJoinCond = getBackwardPassForOuterJoin(cvc, queryBlock, joinClauseType, n, joinTable,
				joinTables, tables, jtColumns);
		cntOfSQColumnSQi1 = ConstraintGenerator.ctx.mkGt((ArithExpr) cntOfSQColumnSQ,
				(ArithExpr) ConstraintGenerator.ctx.mkInt(0));
		// String finalConstraints = "\n" + "( and " + constr + "\n" + tempConstraints +
		// ")" + " \n ";
		if (finalOuterJoinCond.length() > 0) {
			finalConstraints = "\n(and " + finalConstraints + "\n)";
			finalConstraints = "\n(or " + finalConstraints + finalOuterJoinCond + ")";
		}
		// String finalOuterJoinConstraints="\n"+"( and "+negationCond+mapping+")";
		finalConstraints = "\n(assert (forall ((" + "i1 " + "Int" + ")) \n (=> " + cntOfSQColumnSQi1
				+ "\n(and \n\t"
				+ tempBoundaries + "\n\n\t" + finalConstraints + "\n )\n)\n))\n";
		return finalConstraints;
	}

	public static String getConstraintsForNullMutation(GenerateCVC1 cvc, String resultTable,
			ArrayList<String> jtColumns,
			int tuplesInJoinTable, Node n) {
		String constr = "";
		if (n.getRight() != null || n.getLeft() == null)
			return constr;

		Node left = n.getLeft();
		for (String col : jtColumns) {
			if (col.contains("__") && col.contains(left.getTable().toString())
					&& col.split("__")[1].replaceAll("\\d", "").equalsIgnoreCase(left.getColumn().toString())) {
				Table res = cvc.getTableMap().getSQTableByName(resultTable);
				left.setColumn(res.getColumn(col));
				left.setTable(res);
				break;
			}
		}
		ConstraintGenerator constrGen = new ConstraintGenerator();
		constr = "(or\n";

		for (int i = 1; i <= tuplesInJoinTable; i++) {
			// get "not-null" condition and negate it → becomes "is-null"
			String nonConstr = constrGen.getAssertNotNullCondition(cvc, left, String.valueOf(i));
			nonConstr = "(not " + nonConstr + ")\n";
			Expr cntOfSQColumnSQ = ConstraintGenerator.genSelectTest(cvc, resultTable,
					jtColumns.size() - 1, i);
			cntOfSQColumnSQ = ConstraintGenerator.ctx.mkGe((ArithExpr) cntOfSQColumnSQ,
					(ArithExpr) ConstraintGenerator.ctx.mkInt(1));
			nonConstr = "\t(and " + cntOfSQColumnSQ.toString() + nonConstr + " )";
			constr += nonConstr;
		}

		constr += ")";
		constr = "(assert\n" + constr + "\n)";
		return constr;
	}

	public static String getConstraintsForTwoTables(GenerateCVC1 cvc, QueryBlockDetails queryBlock,
			Vector<Table> tables, String resultTable, Vector<Node> joinCond, boolean isExist, String joinType,
			int tuplesInJoinTable, HashMap<String, String> getNewTableMapping, String leftTableNameNo,
			String rightTableNameNo, String subQueryType)
			throws Exception {
		String constr = "";
		HashMap<String, Object> jtColumnNamesAndDataTypes = createTempTableColumnsForJoins(cvc, queryBlock, resultTable,
				tables,
				isExist, subQueryType, queryBlock.getLevel());
		int leftTableTuple = cvc.getNoOfOutputTuples(tables.get(0).toString());
		int rightTableTuple = cvc.getNoOfOutputTuples(tables.get(1).toString());
		if (joinType.equals(JoinClauseInfo.crossJoin))
			tuplesInJoinTable = leftTableTuple * rightTableTuple;
		if (joinType.equals(JoinClauseInfo.leftOuterJoin) || joinType.equals(JoinClauseInfo.antiJoin))
			tuplesInJoinTable = leftTableTuple;
		else if (joinType.equals(JoinClauseInfo.rightOuterJoin))
			tuplesInJoinTable = rightTableTuple;
		else if (joinType.equals(JoinClauseInfo.fullOuterJoin))
			tuplesInJoinTable = Math.max(tuplesInJoinTable, Math.max(leftTableTuple, rightTableTuple));
		else if (joinType.equals(JoinClauseInfo.innerJoin)) {
			tuplesInJoinTable = getTupleCount(cvc, queryBlock, tables, resultTable);
		} else
			tuplesInJoinTable = Math.min(leftTableTuple, rightTableTuple);
		cvc.putNoOfOutputTuples(resultTable, tuplesInJoinTable);
		cvc.getNoOfTuples().put(resultTable, tuplesInJoinTable);
		cvc.jtObj.put(resultTable, jtColumnNamesAndDataTypes);

		ArrayList<String> jtColumns = (ArrayList<String>) jtColumnNamesAndDataTypes.get("Names");
		ArrayList<Sort> jtColumnDataTypes = (ArrayList<Sort>) jtColumnNamesAndDataTypes.get("DataTypes");
		ArrayList<String> primaryKeyOfJoinTable = (ArrayList<String>) jtColumnNamesAndDataTypes.get("PrimaryKey");
		Vector<String> cntColumnNames = new Vector<String>();

		cntColumnNames = (Vector<String>) jtColumnNamesAndDataTypes.get("CountColumns");
		for (int i = cntColumnNames.size() - 2; i >= 0; i--) {
			String col = cntColumnNames.get(i);

			if (!col.contains(tables.get(0).toString() + "__XDATA_CNT")
					&& !col.contains(tables.get(1).toString() + "__XDATA_CNT")) {
				cntColumnNames.remove(i);
			}
		}
		if (cvc.getTableMap().getSQTables() == null)
			cvc.getTableMap().setSQTables((Map<String, Table>) jtColumnNamesAndDataTypes.get("TableMap"));
		else
			cvc.getTableMap().putSQTables((Map<String, Table>) jtColumnNamesAndDataTypes.get("TableMap"));
		Table resultSQTable = cvc.getTableMap().getSQTableByName(resultTable);
		getNewTableMapping.put(leftTableNameNo, resultSQTable.toString());
		getNewTableMapping.put(rightTableNameNo, resultSQTable.toString());
		Expr aex = ConstraintGenerator.putTableInCtx(cvc,
				jtColumns.toArray(new String[jtColumns.size()]),
				jtColumnDataTypes.toArray(new Sort[jtColumnDataTypes.size()]),
				resultTable);
		for (String statement : ConstraintGenerator.declareRelation(aex)) {
			if (statement.contains(resultTable + "_TupleType"))
				constr += statement;
		}
		constr += getMappingFunctions(cvc, tables, resultSQTable, joinType);
		int cntColSize = cntColumnNames.size();
		Vector<ArithExpr> cntOfBaseColumnSQVector = new Vector<ArithExpr>();
		if (cntColSize - 3 >= 0)
			cntOfBaseColumnSQVector.add((ArithExpr) ConstraintGenerator.genSelectTest2(cvc, resultTable,
					jtColumns.indexOf(cntColumnNames.get(cntColSize - 3)), "i1"));

		cntOfBaseColumnSQVector.add((ArithExpr) ConstraintGenerator.genSelectTest2(cvc, resultTable,
				jtColumns.indexOf(cntColumnNames.get(cntColSize - 2)), "i1"));
		ArithExpr[] cntOfBaseColumnSQ = new ArithExpr[cntOfBaseColumnSQVector.size()];
		for (int i = 0; i < cntOfBaseColumnSQVector.size(); i++) {
			cntOfBaseColumnSQ[i] = cntOfBaseColumnSQVector.get(i);
		}
		Expr cntOfSQColumnSQ = ConstraintGenerator.genSelectTest2(cvc, resultTable,
				jtColumns.indexOf(cntColumnNames.get(cntColSize - 1)), "i1");
		Expr[] andExprTemp = new Expr[3];
		andExprTemp[0] = ConstraintGenerator.ctx.mkGe((ArithExpr) cntOfSQColumnSQ,
				(ArithExpr) ConstraintGenerator.ctx.mkInt(0));
		andExprTemp[1] = ConstraintGenerator.ctx.mkLe((ArithExpr) cntOfSQColumnSQ,
				(ArithExpr) ConstraintGenerator.ctx.mkInt(tuplesInJoinTable));
		Expr multipExprOfCounts = ConstraintGenerator.ctx.mkMul(cntOfBaseColumnSQ);
		andExprTemp[2] = ConstraintGenerator.ctx.mkOr(
				ConstraintGenerator.ctx.mkEq(cntOfSQColumnSQ, multipExprOfCounts),
				ConstraintGenerator.ctx.mkEq(cntOfSQColumnSQ, ConstraintGenerator.ctx.mkInt(0)));
		Expr andExprForCountLimit = ConstraintGenerator.ctx.mkAnd((BoolExpr) andExprTemp[0],
				(BoolExpr) andExprTemp[1], (BoolExpr) andExprTemp[2]);
		constr += "\n(assert (forall ((i1 " + "Int" + ")) \n\t" + andExprForCountLimit + "))\n";
		constr += ConstraintGenerator.addCommentLine("CONSTRAINTS FOR PK IN INTERMIDIATE TABLE STARTS");
		// Constraints for primary key
		Expr cntOfSQColumnSQi1 = ConstraintGenerator.genSelectTest2(cvc, resultTable,
				jtColumns.indexOf(cntColumnNames.get(cntColumnNames.size() - 1)), "i1");
		Expr cntOfSQColumnSQj1 = ConstraintGenerator.genSelectTest2(cvc, resultTable,
				jtColumns.indexOf(cntColumnNames.get(cntColumnNames.size() - 1)), "j1");
		Expr orExprTempForPK = ConstraintGenerator.ctx.mkOr(
				ConstraintGenerator.ctx.mkEq((ArithExpr) cntOfSQColumnSQi1,
						(ArithExpr) ConstraintGenerator.ctx.mkInt(0)),
				ConstraintGenerator.ctx.mkEq((ArithExpr) cntOfSQColumnSQj1,
						(ArithExpr) ConstraintGenerator.ctx.mkInt(0)));
		// chaitra PK - if no primary key then skip this.
		if (primaryKeyOfJoinTable.size() != 0) {
			BoolExpr[] andexprConstraintsTemp = new BoolExpr[primaryKeyOfJoinTable.size() + 1];
			int p = 0;
			for (int i = 0; i < primaryKeyOfJoinTable.size(); i++) {
				Expr selecti1 = ConstraintGenerator.genSelectTest2(cvc, resultTable,
						jtColumns.indexOf(primaryKeyOfJoinTable.get(i)), "i1");
				Expr selectj1 = ConstraintGenerator.genSelectTest2(cvc, resultTable,
						jtColumns.indexOf(primaryKeyOfJoinTable.get(i)), "j1");
				andexprConstraintsTemp[p] = (BoolExpr) ConstraintGenerator.ctx.mkEq(selecti1, selectj1);
				p++;
			}

			andexprConstraintsTemp[p] = ConstraintGenerator.ctx.mkNot(ConstraintGenerator.ctx.mkEq(
					(Expr) ConstraintGenerator.ctx.mkIntConst("i1"), (Expr) ConstraintGenerator.ctx.mkIntConst("j1")));
			Expr andExprTempForPK = ConstraintGenerator.ctx.mkAnd(andexprConstraintsTemp);
			constr += "\n(assert (forall ((i1 " + "Int" + ") (j1 " + "Int" + ")) \n\t (=> \n\t"
					+ andExprTempForPK.toString()
					+ "\n\t\t" + orExprTempForPK + ")))\n\n";
		}
		constr += ConstraintGenerator.addCommentLine("CONSTRAINTS FOR PK IN INTERMIDIATE TABLE ENDS");
		constr += getForwardMapping(cvc, queryBlock, tables, resultSQTable, joinCond, isExist, joinType,
				tuplesInJoinTable, jtColumnNamesAndDataTypes);
		constr += getForwardPassForOuterJoin(cvc, queryBlock, joinType, resultSQTable, tables, jtColumns, joinCond);
		constr += getBackwardMapping(cvc, queryBlock, joinCond, resultTable, jtColumns, tables, tuplesInJoinTable,
				cntColumnNames, joinType);
		if (cvc.getCurrentMutant() != null && cvc.getCurrentMutant().getMutationNode() != null
				&& !(cvc.getCurrentMutant().getMutationNode() instanceof parsing.Column)) {
			constr += getConstraintsForNullMutation(cvc, resultTable, jtColumns, tuplesInJoinTable,
					(Node) cvc.getCurrentMutant().getMutationNode());
		}
		return constr;
	}

	public static void transformNodeWithNewTable(GenerateCVC1 cvc, Node n, Table newTable,
			HashMap<String, String> getNewTableMapping) {
		String oldColName = n.getColumn().toString();
		if (oldColName.contains("__")) {
			oldColName = oldColName.split("__")[1].replaceAll("\\d", "");
		}

		// Try to map column to new table column
		for (String col : newTable.getColumns().keySet()) {
			String t = col;
			if (t.contains("__")) {
				t = t.split("__")[1].replaceAll("\\d", "");
			}
			if (t.equalsIgnoreCase(oldColName) && col.contains(n.getTable().toString())) {
				n.setColumn(newTable.getColumn(col));
				break;
			}
		}

		// Update table references
		n.setTable(newTable);
		n.setTableNameNo(newTable.toString());
		n.setTableAlias(newTable.toString());
		if (getNewTableMapping.containsKey(newTable.toString())
				&& getNewTableMapping.get(newTable.toString()).equalsIgnoreCase(newTable.toString()))
			getNewTableMapping.remove(newTable.toString());
		// If this new table is also mapped further, chase the mapping
		String mappedName = getNewTableMapping.get(newTable.toString());
		if (mappedName != null) {
			Table t = cvc.getTableMap().getSQTableByName(mappedName);
			transformNodeWithNewTable(cvc, n, t, getNewTableMapping);
		}
	}

	public static Vector<Node> getJoinNode(GenerateCVC1 cvc, QueryBlockDetails queryBlock, String leftTable,
			String rightTable,
			HashMap<String, String> getNewTableMapping) {
		Set<Node> allCond = new HashSet<>();
		allCond.addAll(queryBlock.getConjunctsQs().get(0).getJoinCondsForEquivalenceClasses());
		allCond.addAll(queryBlock.getConjunctsQs().get(0).getJoinCondsAllOther());
		Vector<Node> joinNodes = new Vector<>();
		for (Node node : allCond) {
			// Transform left side
			Node n = new Node(node);
			String leftMap = getNewTableMapping.get(n.getLeft().getTableNameNo());
			if (leftMap != null) {
				Table newTable = cvc.getTableMap().getSQTableByName(leftMap);
				transformNodeWithNewTable(cvc, n.getLeft(), newTable, getNewTableMapping);
			}

			// Transform right side
			String rightMap = getNewTableMapping.get(n.getRight().getTableNameNo());
			if (rightMap != null) {
				Table newTable = cvc.getTableMap().getSQTableByName(rightMap);
				transformNodeWithNewTable(cvc, n.getRight(), newTable, getNewTableMapping);
				// rightTable = rightMap;
			}

			// Return if this join matches requested pair
			if (n.getLeft().getTableNameNo().equalsIgnoreCase(leftTable)
					&& n.getRight().getTableNameNo().equalsIgnoreCase(rightTable)) {
				joinNodes.add(n);
			} else if (n.getLeft().getTableNameNo().equalsIgnoreCase(rightTable)
					&& n.getRight().getTableNameNo().equalsIgnoreCase(leftTable)) {
				Node left = n.getLeft();
				Node right = n.getRight();
				if (n.getOperator().contains("<") || n.getOperator().contains(">")) {
					if (n.getOperator().equals("<"))
						n.setOperator(">");
					else if (n.getOperator().equals("<="))
						n.setOperator(">=");
					else if (n.getOperator().equals(">"))
						n.setOperator("<=");
					else
						n.setOperator("<");
				}
				n.setRight(left);
				n.setLeft(right);
				joinNodes.add(n);
			}
		}
		if (joinNodes.isEmpty())
			return null;
		return joinNodes;
	}
	// Search join node in correlation hash map.

	public static Vector<Node> getCorrelationJoinNodes(GenerateCVC1 cvc, QueryBlockDetails queryBlock, String leftTable,
			String rightTable, HashMap<String, String> getNewTableMapping) {
		Set<Node> correlationKeys = new HashSet<>(cvc.correlationHashMap.keySet());
		Vector<Node> joinNodes = new Vector<>();

		for (Node originalKey : correlationKeys) {

			correlationStructure cs = cvc.correlationHashMap.get(originalKey);

			if (cs.getProcessLevel() == queryBlock.getLevel()) {

				cvc.correlationHashMap.remove(originalKey);
				Node n = new Node(originalKey);
				String lTable = n.getLeft().getTableNameNo();
				String rTable = n.getRight().getTableNameNo();
				String newLeftResultTable = lTable;
				while (getNewTableMapping.containsKey(newLeftResultTable)) {
					newLeftResultTable = getNewTableMapping.get(newLeftResultTable);
				}
				String newRightResultTable = rTable;
				while (getNewTableMapping.containsKey(newRightResultTable)) {
					newRightResultTable = getNewTableMapping.get(newRightResultTable);
				}

				// direct matching
				if (newLeftResultTable.equalsIgnoreCase(leftTable) &&
						newRightResultTable.equalsIgnoreCase(rightTable)) {

					if (!newLeftResultTable.equalsIgnoreCase(lTable)) {
						Table t1 = cvc.getTableMap()
								.getSQTableByName(newLeftResultTable);
						transformNodeWithNewTable(t1, n.getLeft());
					}

					if (!newRightResultTable.equalsIgnoreCase(rTable)) {
						Table t2 = cvc.getTableMap()
								.getSQTableByName(newRightResultTable);
						transformNodeWithNewTable(t2, n.getRight());
					}

					cvc.correlationHashMap.put(n, cs);
					joinNodes.add(n);
				}

				// reverse matching
				else if (newLeftResultTable.equalsIgnoreCase(rightTable) &&
						newRightResultTable.equalsIgnoreCase(leftTable)) {

					// swap first
					Node temp = n.getLeft();
					n.setLeft(n.getRight());
					n.setRight(temp);

					// transform AFTER swap
					if (!newLeftResultTable.equalsIgnoreCase(lTable)) {
						Table t1 = cvc.getTableMap()
								.getSQTableByName(newLeftResultTable);
						transformNodeWithNewTable(t1, n.getRight());
					}

					if (!newRightResultTable.equalsIgnoreCase(rTable)) {
						Table t2 = cvc.getTableMap()
								.getSQTableByName(newRightResultTable);
						transformNodeWithNewTable(t2, n.getLeft());
					}

					cvc.correlationHashMap.put(n, cs);
					joinNodes.add(n);
				} else if (getNewTableMapping.containsKey(leftTable) || getNewTableMapping.containsKey(rightTable)) {
					while (getNewTableMapping.containsKey(leftTable)) {
						leftTable = getNewTableMapping.get(leftTable);
					}
					while (getNewTableMapping.containsKey(rightTable)) {
						rightTable = getNewTableMapping.get(rightTable);
					}

					// direct matching
					if (newLeftResultTable.equalsIgnoreCase(leftTable) &&
							newRightResultTable.equalsIgnoreCase(rightTable)) {

						if (!newLeftResultTable.equalsIgnoreCase(lTable)) {
							Table t1 = cvc.getTableMap()
									.getSQTableByName(newLeftResultTable);
							transformNodeWithNewTable(t1, n.getLeft());
						}

						if (!newRightResultTable.equalsIgnoreCase(rTable)) {
							Table t2 = cvc.getTableMap()
									.getSQTableByName(newRightResultTable);
							transformNodeWithNewTable(t2, n.getRight());
						}

						cvc.correlationHashMap.put(n, cs);
						joinNodes.add(n);
					}

					// reverse matching
					else if (newLeftResultTable.equalsIgnoreCase(rightTable) &&
							newRightResultTable.equalsIgnoreCase(leftTable)) {

						// swap first
						Node temp = n.getLeft();
						n.setLeft(n.getRight());
						n.setRight(temp);

						// transform AFTER swap
						if (!newLeftResultTable.equalsIgnoreCase(lTable)) {
							Table t1 = cvc.getTableMap()
									.getSQTableByName(newLeftResultTable);
							transformNodeWithNewTable(t1, n.getRight());
						}

						if (!newRightResultTable.equalsIgnoreCase(rTable)) {
							Table t2 = cvc.getTableMap()
									.getSQTableByName(newRightResultTable);
							transformNodeWithNewTable(t2, n.getLeft());
						}

						cvc.correlationHashMap.put(n, cs);
						joinNodes.add(n);
					}
				} else {
					// no match -> restore
					cvc.correlationHashMap.put(n, cs);
				}

			}
		}

		if (joinNodes.isEmpty())
			return null;
		return joinNodes;
	}

	private static void transformNodeWithNewTable(Table res, Node n) {
		if (n == null || n.getType().equals(Node.getValType()) || n.getType().equals(Node.getCompositeNodeType()))
			return;
		if ((n.getOperator() != null && n.getOperator().length() != 0)
				|| n.getNodeType().equals(Node.getInNodeType())) {
			transformNodeWithNewTable(res, n.getLeft());
			transformNodeWithNewTable(res, n.getRight());
			return;
		}
		if (n.getColumn() == null)
			return;
		for (String col : res.getColumns().keySet()) {
			if (col.contains(n.getColumn().toString().replaceAll("\\d+$", ""))
					&& col.contains(n.getTable().toString())) {
				n.setColumn(res.getColumn(col));
				n.setTable(res);
				n.setTableNameNo(res.toString());
				n.setTableAlias(res.toString());
				return;
			}
		}
	}

	private static Node getMutatedNode(GenerateCVC1 cvc, Node originalNode) {
		if (cvc == null || cvc.getCurrentMutant() == null)
			return originalNode;
		Object mutationLoc = cvc.getCurrentMutant().getMutationLoc();
		Object mutationNode = cvc.getCurrentMutant().getMutationNode();
		if (mutationLoc instanceof Node && mutationNode instanceof Node) {
			Node loc = (Node) mutationLoc;
			if (loc.equals(originalNode)) {
				return (Node) mutationNode;
			}
		}
		return originalNode;
	}

	private static String getSingleFilterCondForTuple(GenerateCVC1 cvc, QueryBlockDetails queryBlock,
			ConstraintGenerator constrGen, Node n, String index) {
		String s1 = ConstraintGenerator.genPositiveCondsForPredF(cvc, queryBlock, n.getLeft(), index);
		String s2 = ConstraintGenerator.genPositiveCondsForPredF(cvc, queryBlock, n.getRight(), index);

		// get non null constraints
		String nonConstr = constrGen.getAssertNotNullCondition(cvc, n.getLeft(), index);
		nonConstr += constrGen.getAssertNotNullCondition(cvc, n.getRight(), index);
		String op = "";
		String tempConstr = "";
		if (s1 != null && s2 != null && s1.contains("select") && s2.contains("select")) {
			op = constrGen.getUserDefinedComparisionOperator(n.getOperator(), n.getLeft().getColumn(), s1, s2);
			tempConstr += (n.isNegated ? "(not " : "") + op + (n.isNegated ? ")" : "");
		} else {
			String operator = n.getOperator().equals("/=") ? "not (= " : n.getOperator();
			String closing = n.getOperator().equals("/=") ? "))" : ")";
			tempConstr += (n.isNegated ? "(not " : "") + "(" + operator + " " + s1 + " " + s2 + closing
					+ (n.isNegated ? ")" : "");
		}

		return "(and " + tempConstr + " " + nonConstr + ")";
	}

	private static String getSingleIsNullCondForTuple(GenerateCVC1 cvc, ConstraintGenerator constrGen, Node nCond,
			String index) {
		String nonConstr = constrGen.getAssertNotNullCondition(cvc, nCond.getLeft(), index);
		if (nCond.getNodeType().equalsIgnoreCase(Node.getIsNullNodeType())
				&& nCond.getOperator().equalsIgnoreCase("=")) {
			nonConstr = "(not " + nonConstr + ")";
		}
		return nonConstr;
	}

	private static String getSingleStringCondForTuple(GenerateCVC1 cvc, QueryBlockDetails queryBlock,
			ConstraintGenerator constrGen, Node n, String index) throws Exception {
		Vector<String> stringConstraints = new Vector<>();
		String strConstr = ConstraintGenerator.genPositiveCondsForPredF(cvc, queryBlock, n, index);
		stringConstraints.add(strConstr);
		Vector<String> solvedStringConstraint = cvc.getStringSolver().solveConstraints(
				stringConstraints, cvc.getResultsetColumns(), cvc.getTableMap(), true);
		String nonConstr = "";
		if (n.getLeft().getType().equals(Node.getColRefType()))
			nonConstr += constrGen.getAssertNotNullCondition(cvc, n.getLeft(), index);
		if (n.getRight().getType().equals(Node.getColRefType()))
			nonConstr += constrGen.getAssertNotNullCondition(cvc, n.getRight(), index);

		String finalStrCond = "";
		for (String str : solvedStringConstraint) {
			str = str.substring(str.indexOf('(') + 1, str.lastIndexOf(')'));
			finalStrCond += "\t\t" + str.replace("assert", "") + " \n";
		}
		return "(and " + finalStrCond + nonConstr + ")";
	}

	private static String getSingleInCondForTuple(GenerateCVC1 cvc, QueryBlockDetails queryBlock,
			ConstraintGenerator constrGen, Node n, String index) throws Exception {
		String s1 = ConstraintGenerator.genPositiveCondsForPredF(cvc, queryBlock, n.getLeft(), index);
		String rowInValuesConstr = "";
		for (Node valNode : n.getRight().getComponentNodes()) {
			String s2 = ConstraintGenerator.genPositiveCondsForPredF(cvc, queryBlock, valNode, index);
			String operator = n.getType().equalsIgnoreCase("NOT IN") ? "not (= " : "=";
			String closing = n.getType().equalsIgnoreCase("NOT IN") ? " ))" : ")";

			String predicate = (n.isNegated ? "(not " : "") + "(" + operator + " " + s1 + " " + s2 + closing
					+ (n.isNegated ? ")" : "");
			String dataType = n.getLeft().getColumn().getCvcDatatype();
			boolean isNumericOrDate = dataType.equalsIgnoreCase("int")
					|| dataType.equalsIgnoreCase("real")
					|| dataType.equalsIgnoreCase("time")
					|| dataType.equalsIgnoreCase("date")
					|| dataType.equalsIgnoreCase("timestamp");
			if (!isNumericOrDate) {
				Vector<String> inStrConstraints = new Vector<>();
				inStrConstraints.add(predicate);
				Vector<String> solvedStringConstraint = cvc.getStringSolver().solveConstraints(
						inStrConstraints, cvc.getResultsetColumns(), cvc.getTableMap(), true);

				String solvedStr = "";
				for (String str : solvedStringConstraint) {
					str = str.substring(str.indexOf('(') + 1, str.lastIndexOf(')'));
					solvedStr += str.replace("assert", "").trim() + " ";
				}
				rowInValuesConstr += " " + solvedStr;
			} else {
				rowInValuesConstr += " " + predicate;
			}
		}
		return "(or " + rowInValuesConstr + ")";
	}

	private static Boolean processCorrelationNodeIfPresent(GenerateCVC1 cvc, Table resultTable, int currentLevel,
			Node n) {
		if (n.getLeft() != null && n.getRight() != null &&
				!n.getRight().getNodeType().equals(Node.getValType()) &&
				n.getLeft().getLevel() != n.getRight().getLevel() && n.isCorrelated) {
			// n=new Node(n);
			correlationStructure cs = null;
			if (cvc.correlationHashMap.containsKey(n)) {
				cs = cvc.correlationHashMap.remove(n);
			}
			if (n.getRight().getLevel() == currentLevel) {
				transformNodeWithNewTable(resultTable, n.getRight());
			} else {
				transformNodeWithNewTable(resultTable, n.getLeft());
			}
			if (cs == null) {
				cs = new correlationStructure(n, n.getQueryTypeStr());
			}
			cs.setProcessLevel(Math.min(n.getLeft().getLevel(), n.getRight().getLevel()));

			cvc.correlationHashMap.put(n, cs);

			return true;
		}
		return false;
	}

	private static void insertBaseToResultMapping(GenerateCVC1 cvc, QueryBlockDetails queryBlock, String resTable) {
		for (String str : queryBlock.getBaseRelations()) {
			cvc.baseToResultTableMap.put(str, resTable);
		}
		for (String str : queryBlock.getBaseSQRelations()) {
			cvc.baseToResultTableMap.put(str, resTable);
		}
		if (queryBlock.baseSQ != null && !queryBlock.baseSQ.equalsIgnoreCase(resTable)) {
			cvc.baseToResultTableMap.put(resTable, queryBlock.baseSQ);
		}
	}

	private static String evaluateQueryBlockForTuple(GenerateCVC1 cvc, QueryBlockDetails queryBlock,
			ConstraintGenerator constrGen, Table resultTable, String index) {
		String constr = "";
		boolean hasMultiple = queryBlock.getConjunctsQs().size() > 1;

		if (hasMultiple)
			constr += "(or\n";
		for (int i = 0; i < queryBlock.getConjunctsQs().size(); i++) {
			try {
				constr += " " + evaluateConjunctForTuple(cvc, queryBlock, queryBlock.getConjunctsQs().get(i), constrGen,
						resultTable, index);
			} catch (Exception e) {
				System.out.println("Exception while solving conjunct SQ");
				e.printStackTrace();
			}
		}
		if (hasMultiple)
			constr += ")";

		return constr;
	}

	private static String evaluateConjunctForTuple(GenerateCVC1 cvc, QueryBlockDetails queryBlock,
			ConjunctQueryStructure cqs, ConstraintGenerator constrGen, Table resultTable, String index)
			throws Exception {
		String constr = "";
		int currentLevel = queryBlock.getLevel();

		for (int i = 0; i < cqs.getSelectionConds().size(); i++) {
			Node n = getMutatedNode(cvc, cqs.getSelectionConds().get(i));
			// if (!processCorrelationNodeIfPresent(cvc, resultTable, currentLevel, n)) {
			// constr += " " + getSingleFilterCondForTuple(cvc, queryBlock, constrGen, n,
			// index);
			// }
			if (!n.isCorrelated) {
				transformNodeWithNewTable(resultTable, n);
				constr += " " + getSingleFilterCondForTuple(cvc, queryBlock, constrGen, n, index);

			}
		}
		for (int i = 0; i < cqs.getIsNullConds().size(); i++) {
			Node n = getMutatedNode(cvc, cqs.getIsNullConds().get(i));
			transformNodeWithNewTable(resultTable, n);
			constr += " " + getSingleIsNullCondForTuple(cvc, constrGen, n, index);
		}
		for (int i = 0; i < cqs.getLikeConds().size(); i++) {
			Node n = getMutatedNode(cvc, cqs.getLikeConds().get(i));
			transformNodeWithNewTable(resultTable, n);
			constr += " " + getSingleStringCondForTuple(cvc, queryBlock, constrGen, n, index);
		}
		for (int i = 0; i < cqs.getStringSelectionConds().size(); i++) {
			Node n = getMutatedNode(cvc, cqs.getStringSelectionConds().get(i));
			transformNodeWithNewTable(resultTable, n);
			constr += " " + getSingleStringCondForTuple(cvc, queryBlock, constrGen, n, index);
		}
		for (int i = 0; i < cqs.getInClauseConds().size(); i++) {
			Node n = getMutatedNode(cvc, cqs.getInClauseConds().get(i));
			transformNodeWithNewTable(resultTable, n);
			constr += " " + getSingleInCondForTuple(cvc, queryBlock, constrGen, n, index);
		}

		if (cqs.getDisjuncts().size() > 0) {
			for (int i = 0; i < cqs.getDisjuncts().size(); i++) {
				constr += " " + evaluateDisjunctForTuple(cvc, queryBlock, cqs.getDisjuncts().get(i), constrGen,
						resultTable, index);
			}
		}
		constr += getNonCorrelatedConstraints(cvc, queryBlock);
		int colSize = resultTable.getNoOfColumn();
		Expr cntOfSQColumnSQforAllTuples = ConstraintGenerator.genSelectTest2(cvc, resultTable.toString(),
				colSize - 1, "i1");
		// cnt>0
		Expr greaterCnt = ConstraintGenerator.ctx.mkGt((ArithExpr) cntOfSQColumnSQforAllTuples,
				(ArithExpr) ConstraintGenerator.ctx.mkInt(0));
		greaterCnt = ConstraintGenerator.ctx.mkGt((ArithExpr) cntOfSQColumnSQforAllTuples,
				(ArithExpr) ConstraintGenerator.ctx.mkInt(0));

		if (constr.trim().length() > 0)
			return "(and" + constr + greaterCnt.toString() + ")";

		return greaterCnt.toString();
	}

	private static String evaluateDisjunctForTuple(GenerateCVC1 cvc, QueryBlockDetails queryBlock,
			DisjunctQueryStructure dqs, ConstraintGenerator constrGen, Table resultTable, String index)
			throws Exception {
		String constr = "";

		for (int i = 0; i < dqs.getSelectionConds().size(); i++) {
			Node n = getMutatedNode(cvc, dqs.getSelectionConds().get(i));
			transformNodeWithNewTable(resultTable, n);
			constr += " " + getSingleFilterCondForTuple(cvc, queryBlock, constrGen, n, index);
		}
		for (int i = 0; i < dqs.getIsNullConds().size(); i++) {
			Node n = getMutatedNode(cvc, dqs.getIsNullConds().get(i));
			transformNodeWithNewTable(resultTable, n);
			constr += " " + getSingleIsNullCondForTuple(cvc, constrGen, n, index);
		}
		for (int i = 0; i < dqs.getLikeConds().size(); i++) {
			Node n = getMutatedNode(cvc, dqs.getLikeConds().get(i));
			transformNodeWithNewTable(resultTable, n);
			constr += " " + getSingleStringCondForTuple(cvc, queryBlock, constrGen, n, index);
		}
		for (int i = 0; i < dqs.getStringSelectionConds().size(); i++) {
			Node n = getMutatedNode(cvc, dqs.getStringSelectionConds().get(i));
			transformNodeWithNewTable(resultTable, n);
			constr += " " + getSingleStringCondForTuple(cvc, queryBlock, constrGen, n, index);
		}

		if (dqs.getConjuncts().size() > 0) {
			for (int i = 0; i < dqs.getConjuncts().size(); i++) {
				constr += " " + evaluateConjunctForTuple(cvc, queryBlock, dqs.getConjuncts().get(i), constrGen,
						resultTable, index);
			}
		}

		if (constr.trim().length() > 0)
			return "(or" + constr + ")";
		return "";
	}

	/**
	 * Helper function to generate Z3 non-null assertion on base tables safely
	 * handling
	 * non-numeric tuple iterators like "i1".
	 */
	private static String getBaseTableAssertNotNullCondition(GenerateCVC1 cvc, Node n, String index) {
		if (n.getType().equalsIgnoreCase(Node.getColRefType())) {
			String dataType = n.getColumn().getCvcDatatype();
			Expr isNullExprs;

			Expr[] nullArr = new Expr[] { ConstraintGenerator.ctx.mkIntConst(String.valueOf(index)) };
			if (Configuration.isEnumInt.equalsIgnoreCase("true")) {
				EnumSort currentSort = (EnumSort) ConstraintGenerator.ctxSorts.get(cvc.enumArrayIndex);
				nullArr = new Expr[] { ConstraintGenerator.ctx.mkConst(String.valueOf(index), currentSort) };
			}

			if (dataType.equalsIgnoreCase("int") || dataType.equalsIgnoreCase("real")) {
				isNullExprs = ConstraintGenerator.ctx.mkNot(
						ConstraintGenerator.ctxFuncDecls
								.get("CHECKALL_NULL" + (dataType.equalsIgnoreCase("Int") ? "Int" : "Real"))
								.apply(ConstraintGenerator.smtMap(n.getColumn(), nullArr[0])));
			} else if (dataType.equalsIgnoreCase("date") || dataType.equalsIgnoreCase("time")
					|| dataType.equalsIgnoreCase("timestamp")) {
				isNullExprs = ConstraintGenerator.ctx.mkNot(
						ConstraintGenerator.ctxFuncDecls
								.get("ISNULL_" + n.getColumn().getColumnName())
								.apply(ConstraintGenerator.smtMap(n.getColumn(), nullArr[0])));
			} else {
				isNullExprs = ConstraintGenerator.ctx.mkNot(
						ConstraintGenerator.ctxFuncDecls
								.get("ISNULL_" + dataType)
								.apply(ConstraintGenerator.smtMap(n.getColumn(), nullArr[0])));
			}
			return isNullExprs.toString();
		}
		return "";
	}

	/**
	 * Compiles the unified nested let and ite constraints using modular Z3 API
	 * expressions.
	 */
	public static String solveConjunctSQs(GenerateCVC1 cvc, QueryBlockDetails queryBlock,
			Vector<Table> tables, Vector<String> joinTables, String joinTable, String indexType,
			ArrayList<String> resultColumns) throws Exception {

		Context ctx = ConstraintGenerator.ctx;
		ConstraintGenerator cg = new ConstraintGenerator();
		Expr i1 = ctx.mkIntConst("i1");
		int baseTableTuples = cvc.getNoOfOutputTuples(joinTables.get(0));
		cvc.putNoOfOutputTuples(joinTable, baseTableTuples);
		cvc.getNoOfTuples().put(joinTable, baseTableTuples);
		String baseTable = tables.get(0).getTableName();
		if (cvc.getTableMap().getTables().containsKey(baseTable))
			baseTable = baseTable.toLowerCase();
		if (queryBlock.getLimit() != 0 || queryBlock.getOrderByNodes().size() > 0) {
			int limit = queryBlock.getLimit();
			if (limit == 0) {
				limit = baseTableTuples;
			}
			baseTableTuples = limit;
			cvc.putNoOfOutputTuples(joinTable, baseTableTuples);
			cvc.getNoOfTuples().put(joinTable, baseTableTuples);
			Table sqTable = cvc.getTableMap().getSQTableByName(joinTable);
			String orderByConst = getLimitAndOrderByConstraints(cvc, queryBlock, sqTable, resultColumns,
					joinTables.get(0));
			return orderByConst;
		}
		BoolExpr inRangeLogic = ctx.mkAnd(
				ctx.mkGt((ArithExpr) i1, ctx.mkInt(0)),
				ctx.mkLe((ArithExpr) i1, ctx.mkInt(baseTableTuples)));

		String meetsSqlFilterStr = evaluateQueryBlockForTuple(cvc, queryBlock, cg, tables.get(0), "i1");

		BoolExpr inRangeVar = ctx.mkBoolConst("in_range");
		BoolExpr meetsFilterVar = ctx.mkBoolConst("meets_sql_filter");

		FuncDecl mappingFun = ConstraintGenerator.ctxFuncDecls.get(joinTable + "_map_" + baseTable);
		if (mappingFun == null) {
			mappingFun = ctx.mkFuncDecl(joinTable + "_map_" + baseTable,
					new Sort[] { ctx.getIntSort(), ctx.getIntSort() }, ctx.getBoolSort());
		}
		BoolExpr mappingFunCall = (BoolExpr) mappingFun.apply(i1, i1);

		Table sqTable = cvc.getTableMap().getSQTableByName(joinTable);
		int cntColIndex = sqTable.getNoOfColumn() - 1;
		Expr sqCountSelect = ConstraintGenerator.genSelectTest2(cvc, joinTable, cntColIndex, "i1");

		BoolExpr condition = ctx.mkAnd(inRangeVar, meetsFilterVar);
		BoolExpr thenExpr = ctx.mkAnd(
				ctx.mkGt((ArithExpr) sqCountSelect, ctx.mkInt(0)),
				mappingFunCall);
		BoolExpr elseExpr = ctx.mkEq(sqCountSelect, ctx.mkInt(0));
		Expr iteExpr = ctx.mkITE(condition, thenExpr, elseExpr);

		return "\n(assert (forall ((i1 " + indexType + "))\n" +
				"    (let ((in_range " + inRangeLogic.toString() + "))\n" +
				"        (let ((meets_sql_filter " + meetsSqlFilterStr + "))\n" +
				"            " + iteExpr.toString() + "\n" +
				"        )\n" +
				"    )\n" +
				"))\n";
	}

	private static String solveConjunctSQs(GenerateCVC1 cvc, QueryBlockDetails queryBlock, Table resultTable) {
		int resTableSize = cvc.getNoOfTuples().get(resultTable.toString());
		ConstraintGenerator constrGen = new ConstraintGenerator();
		Context ctx = constrGen.getCtx();
		int cntIdx = resultTable.getNoOfColumn() - 1;

		String constr = "";
		for (int i = 1; i <= resTableSize; i++) {
			String index = Integer.toString(i);

			Expr cntExpr = ConstraintGenerator.genSelectTest(cvc, resultTable.toString(), cntIdx, i);
			// cntExpr = ctx.mkGt(cntExpr, ctx.mkInt(0));

			String tupleCondition = evaluateQueryBlockForTuple(cvc, queryBlock, constrGen, resultTable, index);

			if (tupleCondition.trim().length() > 0) {
				// constr += "\t(=> " + cntExpr.toString() + "\n\t\t" + tupleCondition +
				// "\n\t)\n";
				// constr+= "\t(=> " + tupleCondition + "\n\t\t" + cntExpr.toString() +
				// "\n\t)\n";
				constr += "\t(ite " + tupleCondition + " (> " + cntExpr.toString() + " 0) (= " + cntExpr.toString()
						+ " 0))\n";

			}
		}
		if (constr.trim().length() > 0)
			constr = "(and\n " + constr + ")";
		// constr += ")\n";

		if (constr.trim().length() > 0 && !constr.trim().equals("(and)")) {
			return "\n(assert\n" + constr + ")";
		}
		return "";
	}

	private static String nonCorrelatedConstriants(GenerateCVC1 cvc, QueryBlockDetails queryBlock,
			Vector<Table> joinTables, int indx) {
		Table targetTable = null;
		Table left = joinTables.get(indx);
		Table right = joinTables.get(indx + 1);
		// 1. Identify which table contains the EXISTS/NOT EXISTS property
		if (left != null && left.getIsExist() != null) {
			targetTable = left;
			joinTables.set(indx, null);
		} else if (right != null && right.getIsExist() != null) {
			targetTable = right;
			joinTables.set(indx + 1, null);
		}

		if (targetTable != null) {
			queryBlock.nonCorrelatedTables.add(targetTable);
		}
		targetTable = null;

		return "";
	}

	private static String getNonCorrelatedConstraints(GenerateCVC1 cvc, QueryBlockDetails queryBlock) {
		if (queryBlock.nonCorrelatedTables == null || queryBlock.nonCorrelatedTables.isEmpty()) {
			return "";
		}

		StringBuilder sb = new StringBuilder();
		int tableCount = queryBlock.nonCorrelatedTables.size();

		if (tableCount > 1) {
			sb.append("(and\n");
		}

		for (Table targetTable : queryBlock.nonCorrelatedTables) {
			String tableName = targetTable.getTableName();
			int tupleSize = cvc.getNoOfOutputTuples(tableName);
			String accessor = targetTable.getColumn(targetTable.getNoOfColumn() - 1).getColumnName();

			boolean isExist = targetTable.getIsExist();
			String logicOp = isExist ? "or" : "and";
			String compOp = isExist ? ">" : "=";

			sb.append("  (").append(logicOp);
			for (int i = 1; i <= tupleSize; i++) {
				sb.append("\n    (")
						.append(compOp).append(" (").append(accessor)
						.append(" (select O_").append(tableName).append(" ").append(i).append(")) 0)");
			}
			sb.append("\n  )\n");
		}

		if (tableCount > 1) {
			sb.append(")");
		}

		return sb.toString();
	}

	static void removeJoinCond(ConjunctQueryStructure cqs) {
		cqs.getJoinCondsAllOther().clear();
		cqs.getEquivalenceClasses().clear();
		cqs.getJoinCondsForEquivalenceClasses().clear();
	}

	private static String swapJoinType(String joinType) {
		if (JoinClauseInfo.leftOuterJoin.equals(joinType)) {
			return JoinClauseInfo.rightOuterJoin;
		}
		if (JoinClauseInfo.rightOuterJoin.equals(joinType)) {
			return JoinClauseInfo.leftOuterJoin;
		}
		return joinType;
	}

	private static String getJoinType(GenerateCVC1 cvc, QueryBlockDetails queryBlock, String tableNameA,
			String tableNameB) {
		if (queryBlock.getConjunctsQs() != null && !queryBlock.getConjunctsQs().isEmpty()) {
			ConjunctQueryStructure cqs = queryBlock.getConjunctsQs().get(0);
			if (cqs != null) {
				Set<Node> allCond = new HashSet<>();
				if (cqs.getJoinCondsForEquivalenceClasses() != null) {
					allCond.addAll(cqs.getJoinCondsForEquivalenceClasses());
				}
				if (cqs.getJoinCondsAllOther() != null) {
					allCond.addAll(cqs.getJoinCondsAllOther());
				}
				for (Node node : allCond) {
					if (node.getLeft() != null && node.getRight() != null) {
						String leftName = node.getLeft().getTableNameNo();
						String rightName = node.getRight().getTableNameNo();
						if ((leftName.equalsIgnoreCase(tableNameA) && rightName.equalsIgnoreCase(tableNameB))
								|| (leftName.equalsIgnoreCase(tableNameB) && rightName.equalsIgnoreCase(tableNameA))) {
							boolean swapped = leftName.equalsIgnoreCase(tableNameB)
									&& rightName.equalsIgnoreCase(tableNameA);
							String jt = node.getJoinType();
							if (jt != null) {
								if (swapped) {
									return swapJoinType(jt);
								}
								return jt;
							}
							String qts = node.getQueryTypeStr();
							if (qts != null) {
								if (qts.equalsIgnoreCase("exists")) {
									return JoinClauseInfo.semiJoin;
								} else if (qts.equalsIgnoreCase("not exists")) {
									return JoinClauseInfo.antiJoin;
								}
							}
						}
					}
				}
			}
		}

		if (cvc.correlationHashMap != null) {
			for (Node n : cvc.correlationHashMap.keySet()) {
				if (n.getLeft() != null && n.getRight() != null) {
					correlationStructure cs = cvc.correlationHashMap.get(n);
					if (cs != null && cs.getProcessLevel() == queryBlock.getLevel()) {
						String leftName = n.getLeft().getTableNameNo();
						String rightName = n.getRight().getTableNameNo();
						if ((leftName.equalsIgnoreCase(tableNameA) && rightName.equalsIgnoreCase(tableNameB))
								|| (leftName.equalsIgnoreCase(tableNameB) && rightName.equalsIgnoreCase(tableNameA))) {
							boolean swapped = leftName.equalsIgnoreCase(tableNameB)
									&& rightName.equalsIgnoreCase(tableNameA);
							String jt = n.getJoinType();
							if (jt != null) {
								if (swapped) {
									return swapJoinType(jt);
								}
								return jt;
							}
							String qts = n.getQueryTypeStr();
							if (qts != null) {
								if (qts.equalsIgnoreCase("exists")) {
									return JoinClauseInfo.semiJoin;
								} else if (qts.equalsIgnoreCase("not exists")) {
									return JoinClauseInfo.antiJoin;
								}
							}
						}
					}
				}
			}
		}
		return JoinClauseInfo.innerJoin;
	}

	private static void sortJoinTables(GenerateCVC1 cvc, QueryBlockDetails queryBlock, Vector<Table> joinTables,
			Vector<String> joinTableNames) {

		if (queryBlock.joinInfo == null || queryBlock.joinInfo.isEmpty())
			return;

		Vector<String> sortedJoinTableNames = new Vector<>(joinTableNames.size());
		sortedJoinTableNames.setSize(joinTableNames.size());
		// Map table name -> Table object
		Map<String, Table> tableMap = new HashMap<>();
		for (int i = 0; i < joinTableNames.size(); i++) {
			tableMap.put(joinTableNames.get(i), joinTables.get(i));
		}

		Vector<Table> sortedJoinTables = new Vector<>();
		Vector<String> sortedJoinClauseTypes = new Vector<>();

		// First table
		JoinClauseInfo first = queryBlock.joinInfo.get(0);
		sortedJoinTables.add(tableMap.get(first.getLeftTable()));

		// Remaining tables and join types
		for (JoinClauseInfo info : queryBlock.joinInfo) {

			String baseRelations = info.getRightTable();
			if (tableMap.containsKey(baseRelations)) {
				sortedJoinTables.add(tableMap.get(baseRelations));
			} else {
				Table cvcTable = cvc.getTableMap().getTable(baseRelations.replaceAll("\\d", "").toUpperCase());
				if (cvcTable == null) {
					cvcTable = cvc.getTableMap().getSQTableByName(
							cvc.aliasMappingToLevels.get(baseRelations.replaceAll("\\d", "").toLowerCase()).repSQTable);
				}
				sortedJoinTables.add(cvcTable);
			}

			sortedJoinClauseTypes.add(info.getJoinType());
		}
		for (int i = 0; i < joinTables.size(); i++) {
			int idx = sortedJoinTables.indexOf(joinTables.get(i));
			sortedJoinTableNames.set(idx, joinTableNames.get(i));
		}
		// Update join tables
		joinTables.clear();
		joinTables.addAll(sortedJoinTables);
		joinTableNames.clear();
		joinTableNames.addAll(sortedJoinTableNames);

	}

	public static String getConstraintsForOuterJoinsInSameQueryBlock(GenerateCVC1 cvc, QueryBlockDetails queryBlock,
			String operator, boolean isExist, String subqueryType, Vector<Table> joinTables, String joinTable)
			throws Exception {

		String constr = "";
		if (joinTables.size() == 1) {
			joinTables.add(joinTables.get(0));
		}
		// Initialize Table Mapping
		HashMap<String, String> tableMapping = buildTableMapping(queryBlock);

		// Collect Table Names
		Vector<String> joinTableNames = new Vector<>();
		joinTableNames.addAll(queryBlock.getBaseRelations());
		joinTableNames.addAll(queryBlock.getBaseSQRelations());
		sortJoinTables(cvc, queryBlock, joinTables, joinTableNames);
		queryBlock.getBaseSQRelations().clear();
		// Process the First Join (Tables at index 0 and 1)
		int tuplesInJoinTable = getTupleCount(cvc, queryBlock, joinTables, joinTable);
		String intermediateResultTable = joinTable;
		int newLevel = 1;

		if (joinTables.size() > 1) {
			intermediateResultTable += "_" + newLevel;
		}

		Vector<Table> twoTables = new Vector<>();
		twoTables.add(joinTables.get(0));
		twoTables.add(joinTables.get(1));

		// Determine Join Node and Type for the first join
		Vector<Node> n = findJoinNode(cvc, queryBlock, joinTableNames.get(0), joinTableNames.get(1), tableMapping,
				twoTables, true, 0);

		String currentSubQueryType = (joinTables.size() == 2) ? subqueryType : "from";

		// Handle first join constraints
		if (n == null && !JoinClauseInfo.crossJoin.equals(queryBlock.JoinClauseTypes.get(0))) {
			constr += nonCorrelatedConstriants(cvc, queryBlock, joinTables, 0);
			intermediateResultTable = (joinTables.get(0) == null) ? joinTableNames.get(1) : joinTableNames.get(0);
			updateNonCorrelatedTupleCount(cvc, joinTables, intermediateResultTable);
		} else {
			constr += getConstraintsForTwoTables(cvc, queryBlock, twoTables, intermediateResultTable, n, isExist,
					queryBlock.JoinClauseTypes.get(0), tuplesInJoinTable, tableMapping,
					joinTableNames.get(0), joinTableNames.get(1), currentSubQueryType);
		}

		// Process Subsequent Joins (Index 2 onwards)
		for (int i = 2; i < joinTables.size(); i++) {
			twoTables = new Vector<>();
			twoTables.add(cvc.getTableMap().getSQTableByName(intermediateResultTable));
			twoTables.add(joinTables.get(i));

			newLevel++;
			// String nextIntermediateTable = (i == joinTables.size() - 1) ? joinTable :
			// joinTable + "_" + newLevel;
			String nextIntermediateTable = joinTable + "_" + newLevel;
			currentSubQueryType = (i == joinTables.size() - 1) ? subqueryType : "from";

			tuplesInJoinTable = cvc.getNoOfOutputTuples(intermediateResultTable);

			// Determine Join Node and Type for subsequent joins
			n = findJoinNode(cvc, queryBlock, intermediateResultTable, joinTableNames.get(i), tableMapping, twoTables,
					false, i - 1);

			if (n == null && !JoinClauseInfo.crossJoin.equals(queryBlock.JoinClauseTypes.get(i - 1))) {
				constr += nonCorrelatedConstriants(cvc, queryBlock, joinTables, i - 1);

				// intermediateResultTable = (joinTables.get(i - 1) == null) ?
				// joinTableNames.get(i)
				// : joinTableNames.get(i - 1);
				updateNonCorrelatedTupleCount(cvc, joinTables, intermediateResultTable); // Note: Original code uses
																							// index
																							// 0/1 even here
				System.out.println("Join Node not found");
				continue;
			}

			constr += getConstraintsForTwoTables(cvc, queryBlock, twoTables, nextIntermediateTable, n, isExist,
					queryBlock.JoinClauseTypes.get(i - 1), tuplesInJoinTable, tableMapping,
					intermediateResultTable, joinTableNames.get(i), currentSubQueryType);

			intermediateResultTable = nextIntermediateTable;
		}

		finalizeOutputState(cvc, queryBlock, joinTables, intermediateResultTable);

		return constr;
	}

	private static Vector<Node> findJoinNode(GenerateCVC1 cvc, QueryBlockDetails queryBlock, String tableA,
			String tableB,
			HashMap<String, String> mapping, Vector<Table> pair, boolean isFirst, int typeIndex) {

		Vector<Node> n = getJoinNode(cvc, queryBlock, tableA, tableB, mapping);

		if (n == null) {
			// For subsequent joins, the original code looks at joinTableNames[i-1]
			// We replicate that by passing appropriate names from the loop
			n = getCorrelationJoinNodes(cvc, queryBlock, tableA, tableB, mapping);

			boolean table0Exist = pair.get(0) != null && pair.get(0).getIsExist() != null && !pair.get(0).getIsExist();
			boolean table1Exist = pair.get(1) != null && pair.get(1).getIsExist() != null && !pair.get(1).getIsExist();

			if (table0Exist || table1Exist) {
				queryBlock.JoinClauseTypes.add(JoinClauseInfo.antiJoin);
			} else if (n != null) {
				queryBlock.JoinClauseTypes.add(JoinClauseInfo.semiJoin);
			}
		}

		// Default to inner join if no type was added yet
		if (queryBlock.JoinClauseTypes.size() == typeIndex) {
			queryBlock.JoinClauseTypes.add(JoinClauseInfo.innerJoin);
		}

		return n;
	}

	/**
	 * Replicates the mapping logic for base and subquery relations.
	 */
	private static HashMap<String, String> buildTableMapping(QueryBlockDetails queryBlock) {
		HashMap<String, String> mapping = new HashMap<>();
		if (queryBlock.getBaseSQRelations().isEmpty())
			return mapping;

		for (String baseSQ : queryBlock.getBaseSQRelations()) {
			for (QueryBlockDetails fsq : queryBlock.getFromClauseSubQueries()) {
				if (fsq.baseSQ.equalsIgnoreCase(baseSQ)) {
					for (String str : fsq.getBaseRelations())
						mapping.put(str, baseSQ);
					for (String str : fsq.getBaseSQRelations())
						mapping.put(str, baseSQ);
				}

			}
			for (QueryBlockDetails wsq : queryBlock.getWhereClauseSubQueries()) {
				if (wsq.baseSQ.equalsIgnoreCase(baseSQ)) {
					for (String str : wsq.getBaseRelations())
						mapping.put(str, baseSQ);
					for (String str : wsq.getBaseSQRelations())
						mapping.put(str, baseSQ);
				}
			}
		}
		return mapping;
	}

	/**
	 * Preserves the specific tuple count behavior for non-correlated constraints.
	 */
	private static void updateNonCorrelatedTupleCount(GenerateCVC1 cvc, Vector<Table> joinTables, String targetTable) {
		int t = 0;
		// Original code quirk: it always checks joinTables index 0 and 1 even inside
		// the loop for i > 2
		if (joinTables.get(0) != null) {
			t = cvc.getNoOfOutputTuples(joinTables.get(0).toString());
		} else {
			t = cvc.getNoOfOutputTuples(joinTables.get(1).toString());
		}
		cvc.putNoOfOutputTuples(targetTable, t);
	}

	/**
	 * Cleans up and populates the global variables as the original code did.
	 */
	private static void finalizeOutputState(GenerateCVC1 cvc, QueryBlockDetails queryBlock, Vector<Table> joinTables,
			String lastTable) {
		joinTables.clear();
		Table res = cvc.getTableMap().getSQTableByName(lastTable);
		if (res == null) {
			res = cvc.getTableMap().getTable(lastTable.replaceAll("\\d+$", ""));
		}
		joinTables.add(res);

		joinTypeCopy = new Vector<>(queryBlock.JoinClauseTypes);
		queryBlock.JoinClauseTypes.clear();

		oldBaseRelation = new ArrayList<>(queryBlock.getBaseRelations());
		oldBaseSQRelation = new ArrayList<>(queryBlock.getBaseSQRelations());
	}

	public static void updateTableNames(GenerateCVC1 cvc, QueryBlockDetails queryBlock) {
		for (JoinClauseInfo join : queryBlock.joinInfo) {
			String leftTable = join.leftTable, rightTable = join.rightTable;
			if (queryBlock.aliasHashMap.containsKey(leftTable))
				leftTable = queryBlock.aliasHashMap.get(leftTable);
			if (queryBlock.aliasHashMap.containsKey(rightTable))
				rightTable = queryBlock.aliasHashMap.get(rightTable);
			if (cvc.aliasMappingToLevels.containsKey(leftTable))
				leftTable = cvc.aliasMappingToLevels.get(leftTable).repSQTable;
			if (cvc.aliasMappingToLevels.containsKey(rightTable))
				rightTable = cvc.aliasMappingToLevels.get(rightTable).repSQTable;
			join.leftTable = leftTable;
			join.rightTable = rightTable;

		}
	}

	/**
	 * Gets constraints for nodes which are involved in join conditions which are in
	 * same query block
	 * 
	 * @author parismita, sunanda
	 * @param cvc
	 * @param queryBlock
	 * @param n1
	 * @param n2
	 * @param string
	 * @return
	 * @throws Exception
	 */
	public static String getConstraintsForJoinsInSameQueryBlockWithCount(GenerateCVC1 cvc, QueryBlockDetails queryBlock,
			Node n1, Node n2, String operator, boolean isExist, String subqueryType) throws Exception {

		String constraintString = "";
		Vector<Table> tables = new Vector<Table>();
		Vector<String> joinTables = new Vector<String>();
		Vector<Integer> tuplesInTable = new Vector<Integer>();
		String indexType = "Int";
		String enumIndexVar = "";
		Boolean primaryKeyMethod = false;
		if (Configuration.isEnumInt.equalsIgnoreCase("true")) {
			indexType = cvc.enumArrayIndex;
			enumIndexVar = cvc.enumIndexVar;
		}
		int level = queryBlock.getLevel();
		int tuplesInJoinTable = 1, tupleNo = 0;
		fixBaseRelations(cvc, queryBlock);
		updateTableNames(cvc, queryBlock);
		boolean isNotDirectMapping = queryBlock.getConjunctsQs().size() > 0
				? queryBlock.getConjunctsQs().get(0).getAllConds().size() > 0
						|| queryBlock.getConjunctsQs().get(0).getAllSubQueryConds().size() > 0
						|| queryBlock.getConjunctsQs().get(0).getDisjuncts().size() > 0
						|| queryBlock.getConjunctsQs().get(0).getInClauseConds().size() > 0
						|| queryBlock.getConjunctsQs().get(0).getIsNullConds().size() > 0
						|| queryBlock.getConjunctsQs().get(0).getLikeConds().size() > 0
						|| queryBlock.getConjunctsQs().get(0).getSelectionConds().size() > 0
						|| queryBlock.getConjunctsQs().get(0).getStringSelectionConds().size() > 0
				: false;
		// need to check which SQ condition it is in its level -
		queryBlock.getBaseRelations().removeIf(rel -> {
			String normalizedRel = rel.toLowerCase().replaceAll("//d$", "");
			if (cvc.aliasMappingToLevels.containsKey(normalizedRel)) {
				String resSQTable = cvc.aliasMappingToLevels.get(normalizedRel).repSQTable;
				return queryBlock.getBaseSQRelations().contains(resSQTable);
			}
			return false;
		});
		queryBlock.getBaseRelations().removeIf(rel -> {
			String normalizedRel = rel.toLowerCase().replaceAll("\\d+$", "");

			if (cvc.aliasMappingToLevelsForWith != null && cvc.aliasMappingToLevelsForWith.containsKey(normalizedRel)) {
				String resSQTable = cvc.aliasMappingToLevelsForWith.get(normalizedRel).repSQTable;
				return queryBlock.getBaseSQRelations().contains(resSQTable);
			}
			return false;
		});
		for (String baseRelations : queryBlock.getBaseRelations()) {
			Table cvcTable = cvc.getTableMap().getTable(baseRelations.replaceAll("\\d", "").toUpperCase());
			if (cvcTable == null) {
				cvcTable = cvc.getTableMap().getSQTableByName(
						cvc.aliasMappingToLevels.get(baseRelations.replaceAll("\\d", "").toLowerCase()).repSQTable);
			}
			if (!tables.contains(cvcTable)) {
				tables.add(cvcTable);
				joinTables.add(cvcTable.getTableName());
				tupleNo = cvc.getNoOfOutputTuples(cvcTable.getTableName());
				tuplesInTable.add(tupleNo);
				tuplesInJoinTable = tuplesInJoinTable * tupleNo;// INIT
			}
		}
		for (String baseSQRelations : queryBlock.getBaseSQRelations()) {
			Table cvcTable = cvc.getTableMap().getSQTableByName(baseSQRelations.toUpperCase());
			if (cvcTable != null && !tables.contains(cvcTable)) {
				tables.add(cvcTable);
				joinTables.add(cvcTable.getTableName());
				tupleNo = cvc.getNoOfOutputTuples(cvcTable.getTableName());
				tuplesInTable.add(tupleNo);
			}
		}
		for (int i = 0; i < queryBlock.getBaseSQRelations().size(); i++) {
			if (!joinTables.contains(queryBlock.getBaseSQRelations().get(i))) {
				String tempTable = queryBlock.getBaseSQRelations().get(i);
				Table cvcTable = cvc.getTableMap().getSQTableByName(tempTable);
				if (cvcTable != null) {
					tables.add(cvcTable);
					joinTables.add(tempTable);
					tupleNo = cvc.getNoOfOutputTuples(cvcTable.getTableName());
					tuplesInTable.add(tupleNo);
					tuplesInJoinTable = tuplesInJoinTable * tupleNo;// INIT
				}
			}
		}
		if (Configuration.getProperty("tempJoins").equalsIgnoreCase("true")) {
			ConstraintGenerator constrGen = new ConstraintGenerator();
			String joinTable = "JSQ" + String.valueOf(level);

			if (tablesAdded.contains(joinTable)) {
				return "";
			}
			// *********************added by sunanda - end********************

			// pushing tables down for not exist correlation
			pushTablesFromAboveLevelsForCorrelation(cvc, tables, level, joinTables, tuplesInTable);
			if (joinTables.size() > 1) {

				constraintString += getConstraintsForOuterJoinsInSameQueryBlock(cvc, queryBlock, operator,
						isExist, subqueryType,
						tables, joinTable);
				joinTables.clear();
				joinTables.add(tables.get(0).toString());
				tables.get(0).setSQType("from");
				// if(tables.get(0).toString().equals(joinTable)){
				// constraintString+=solveConjunctSQs(cvc, queryBlock, sqTable);
				// insertBaseToResultMapping(cvc, queryBlock, sqTable.toString());
				// joinTables.clear();
				// joinTables.add(tables.get(0).toString());
				// ArrayList<String> typeCastedJt = new ArrayList<String>();
				// for (Sort s : jtColumnDataTypes) {
				// typeCastedJt.add(s.toString());
				// }
				// ArrayList<String> s = new ArrayList<String>();
				// s.addAll(0, joinTables);
				// Vector<Node> correlationConds = new Vector<>();
				// Vector<Node> selectionAndJoinConds = new Vector<Node>();
				// SubqueryStructure sqs = new SubqueryStructure();
				// sqs.SQTableName.put(joinTable, s);
				// sqs.SQjoinWithEXISTS.put(joinTable, true);
				// sqs.SQDefine.put(joinTable, constraintString);
				// sqs.SQColumnsDataTypes.put(joinTable, typeCastedJt);
				// sqs.SQColumns.put(joinTable, jtColumns);
				// sqs.SQJoinSelectionAndJoinConds.put(joinTable, selectionAndJoinConds);
				// sqs.SQJoinCorrelationConds.put(joinTable, correlationConds);

				// if (subqueryType.equalsIgnoreCase("from")) {
				// cvc.subqueryConstraintsMap.put("from", sqs);
				// } else if (subqueryType.equalsIgnoreCase("outer")) {
				// cvc.subqueryConstraintsMap.put("outer", sqs);
				// } else {
				// String temp = "where_" + String.valueOf(level);
				// sqs.SQjoinWithEXISTS.put(joinTable, isExist);
				// cvc.subqueryConstraintsMap.put(temp, sqs);
				// }
				// if (queryBlock.isSet == 1) {
				// cvc.subqueryConstraintsMap.put(joinTable, sqs);
				// }
				// if (isChanged) {
				// queryBlock.getConjunctsQs().set(0, old);
				// queryBlock.JoinClauseTypes = joinTypeCopy;
				// queryBlock.setBaseRelations(oldBaseRelation);
				// queryBlock.setBaseSQRelations(oldBaseSQRelation);
				// isChanged = false;
				// }
				// return "";
				// }else{
				// joinTables.clear();
				// joinTables.add(tables.get(0).toString());
				// }
			}
			HashMap<String, Object> jtColumnNamesAndDataTypes = createTempTableColumnsForJoins(cvc, queryBlock,
					joinTable, tables,
					isExist, subqueryType, level);

			cvc.jtObj.put(joinTable, jtColumnNamesAndDataTypes);

			ArrayList<String> jtColumns = (ArrayList<String>) jtColumnNamesAndDataTypes.get("Names");
			ArrayList<Sort> jtColumnDataTypes = (ArrayList<Sort>) jtColumnNamesAndDataTypes.get("DataTypes");
			ArrayList<String> primaryKeyOfJoinTable = (ArrayList<String>) jtColumnNamesAndDataTypes.get("PrimaryKey");
			if (cvc.getTableMap().getSQTables() == null)
				cvc.getTableMap().setSQTables((Map<String, Table>) jtColumnNamesAndDataTypes.get("TableMap"));
			else
				cvc.getTableMap().putSQTables((Map<String, Table>) jtColumnNamesAndDataTypes.get("TableMap"));
			Table sqTable = cvc.getTableMap().getSQTableByName(joinTable);

			// testcode by deeksha--------------------------------------------------
			String tempConstraints = "";
			Expr aex = ConstraintGenerator.putTableInCtx(cvc,
					jtColumns.toArray(new String[jtColumns.size()]),
					jtColumnDataTypes.toArray(new Sort[jtColumnDataTypes.size()]),
					joinTable); // will be stored table1's cols with count then table2's then 3's - parismita

			for (String statement : ConstraintGenerator.declareRelation(aex)) {
				if (statement.contains(joinTable + "_TupleType"))
					tempConstraints += statement;
			}

			// step 2 : sq1 and sq2 functions for matching join relation with original
			HashSet<String> funDefined = new HashSet<>();
			int joincol = 0;
			for (int i = 0; i < tables.size(); i++) {//
				HashMap<String, Column> columns = tables.get(i).getColumns();
				if ((tables.get(i).getTableName().contains("JSQ") || tables.get(i).getTableName().contains("GSQ")
						|| tables.get(i).getTableName().contains("DSQ"))
						&& !tables.get(i).getSQType().equalsIgnoreCase("from")) { // check if table is not from clause
																					// subquery
					HashMap<String, Column> columnsNeedMapping = getRequiredMappingFromSubquery(cvc, tables.get(i),
							level);
					if (columnsNeedMapping.size() == 0)
						continue;
					else {
						columns = columnsNeedMapping;
					}
				}
				Vector<String> columnString = new Vector<String>(columns.keySet());
				// INFO: Write JSQ0_map_table_null function :-done
				String fun = ("define-fun " + joinTable + "_map_" + joinTables.get(i) + "((x!0 " + indexType + ") (x!1 "
						+ indexType + ")) Bool\n");
				if (funDefined.contains(fun))
					continue;
				funDefined.add(fun);
				if (queryBlock.JoinClauseTypes.size() > 0) {

					if ((i < queryBlock.JoinClauseTypes.size()
							&& (queryBlock.JoinClauseTypes.get(i).equals(JoinClauseInfo.fullOuterJoin)
									|| queryBlock.JoinClauseTypes.get(i).equals(JoinClauseInfo.rightOuterJoin)))
							|| (i - 1 >= 0 && i - 1 < queryBlock.JoinClauseTypes.size()
									&& (queryBlock.JoinClauseTypes.get(i - 1)
											.equals(JoinClauseInfo.leftOuterJoin)
											|| queryBlock.JoinClauseTypes.get(i - 1)
													.equals(JoinClauseInfo.fullOuterJoin)))) {
						String NullFun = ("define-fun " + joinTable + "_map_" + joinTables.get(i) + "_NULL" + "((x!0 "
								+ indexType + ")) Bool\n");

						String isNull = "\n(" + NullFun + "(and \n";
						if (funDefined.contains(NullFun))
							continue;
						funDefined.add(NullFun);
						int colj = 0;
						int temp = joincol;
						while (colj < columns.size()) {
							// (JSQ0_student__NAME1 (select O_JSQ0 x!1))

							Expr right = ConstraintGenerator.genSelectTest2(cvc, joinTable, temp, "x!0");
							if (columnString.get(colj).contains("CNT")) {
								isNull += "( = " + right.toString() + " 1 )";
							} else {
								isNull += getNullConstraints(right,
										columns.get(columnString.get(colj)).getCvcDatatype().toString(),
										columnString.get(colj));
							}
							isNull += "\n";

							colj++;
							temp++;
						}
						isNull += ")\n)\n";
						tempConstraints += isNull;
					}
				}

				tempConstraints += "\n(" + fun + "(and \n";
				int col1 = 0;
				while (col1 < columns.size()) {
					Expr left = ConstraintGenerator.genSelectTest2(cvc, joinTables.get(i),
							tables.get(i).getColumnIndex(columnString.get(col1)), "x!0");
					// (JSQ0_student__NAME1 (select O_JSQ0 x!1))
					Expr right = ConstraintGenerator.genSelectTest2(cvc, joinTable, joincol, "x!1");
					Expr eq = ConstraintGenerator.ctx.mkEq(left, right);
					tempConstraints += eq.toString() + "\n";
					col1++;
					joincol++;
				}
				tempConstraints += ")\n)\n";
			}

			// selection and join conditions from subquery :POOJA
			// String constr = "";
			Vector<Node> selectionAndJoinConds = new Vector<Node>();

			// tuples count - parismSELECT name FROM instructor WHERE EXISTS (SELECT * FROM
			// department WHERE instructor.dept_name = department.dept_name)ita
			Vector<Node> CondForCount = new Vector<>();

			CondForCount.addAll(queryBlock.getConjunctsQs().get(0).getSelectionConds());
			CondForCount.addAll(queryBlock.getConjunctsQs().get(0).getJoinCondsForEquivalenceClasses());
			CondForCount.addAll(queryBlock.getConjunctsQs().get(0).getJoinCondsAllOther());
			CondForCount.addAll(queryBlock.getConjunctsQs().get(0).getStringSelectionConds());

			tuplesInJoinTable = getOptimalTupleCountForJoinTable(cvc, CondForCount, tables);
			// chaitra changed here for case no of tuples
			if (cvc.noOfOutputTuplesContains(joinTable))
				tuplesInJoinTable = Math.max(tuplesInJoinTable, cvc.getNoOfOutputTuples(joinTable));
			if (joinTables.size() == 1)
				tuplesInJoinTable = cvc.getNoOfOutputTuples(joinTables.get(0));
			if (cvc.getqStructure().isCase > 0)
				tuplesInJoinTable = Math.max(tuplesInJoinTable, cvc.getqStructure().isCase + 1);
			// chaitra changed here for case no of tuples
			// power 2 hueristic - sunanda
			int base = 2;
			// base^tables.size();
			// hueristic for #tuples > 10
			int baseTableSize = 0;
			for (int i = 0; i < tables.size(); i++) {
				if (joinTables.size() == 1) {
					baseTableSize++;
				} else if (joinTables.get(i).contains("JSQ") && !tables.get(i).getSQType().equalsIgnoreCase("from")
						|| joinTables.get(i).contains("GSQ") || joinTables.get(i).contains("DSQ"))
					continue;
				else
					baseTableSize++;
			}

			int updatedTuplesInJoinTable = (int) Math.round(Math.pow(base, baseTableSize));
			if (queryBlock.getLimit() > 0)
				updatedTuplesInJoinTable = Math.max(updatedTuplesInJoinTable, queryBlock.getLimit() + 1);
			// updatedTuplesInJoinTable = Math.max(updatedTuplesInJoinTable,
			// cvc.getNoOfOutputTuples(joinTable));
			tuplesInJoinTable = Math.max(tuplesInJoinTable, cvc.getNoOfMaxOutputTuples(joinTable));
			updatedTuplesInJoinTable = Math.max(Math.min(updatedTuplesInJoinTable, tuplesInJoinTable),
					cvc.getNoOfMaxOutputTuples(joinTable));
			if (tuplesInJoinTable > 10)
				tuplesInJoinTable = updatedTuplesInJoinTable;

			if (tuplesInJoinTable < 4) {
				if (cvc.getCurrentMutant() != null && (cvc.getCurrentMutant().getMutationTypeNumber() == 7
						|| cvc.getCurrentMutant().getMutationTypeNumber() == 8
						|| cvc.getCurrentMutant().getMutationTypeNumber() == 2)) {
					tuplesInJoinTable = tuplesInJoinTable + 3;
				}
				if (cvc.getCurrentMutant() != null && (cvc.getCurrentMutant().getMutationTypeNumber() == 5)) {
					tuplesInJoinTable = updatedTuplesInJoinTable;
				}
			}
			// hueristic commented for testing

			cvc.putNoOfOutputTuples(joinTable, tuplesInJoinTable);

			cvc.getNoOfTuples().put(joinTable, tuplesInJoinTable);

			// step 1.5 : for loop for asserting count values for join subquery table
			Vector<String> cntColumnNames = new Vector<String>();

			cntColumnNames = (Vector<String>) jtColumnNamesAndDataTypes.get("CountColumns");
			Vector<ArithExpr> cntOfBaseColumnSQVector = new Vector<ArithExpr>();
			for (int i = cntColumnNames.size() - 2; i < cntColumnNames.size() - 1; i++) {
				// || (cntColumnNames.get(i).contains("JSQ") )
				String tableTemp = cvc.getTableMap().getSQTableByName(joinTable).getColumn(cntColumnNames.get(i))
						.getBaseRelation();

				if (cntColumnNames.get(i).contains("JSQ") && cvc.getTableMap().getSQTableByName(tableTemp) != null
						&& cvc.getTableMap().getSQTableByName(tableTemp).getTableName().contains("JSQ")
						&& cvc.getTableMap().getSQTableByName(tableTemp).getSQType().equalsIgnoreCase("from")) {
					// System.out.println(cvc.getTableMap().getSQTableByName(joinTable).getColumn(cntColumnNames.get(i)));
					cntOfBaseColumnSQVector.add((ArithExpr) ConstraintGenerator.genSelectTest2(cvc, joinTable,
							jtColumns.indexOf(cntColumnNames.get(i)), "i1"));
					// continue;
				} else if (cntColumnNames.get(i).split("JSQ").length > 2
						|| cntColumnNames.get(i).split("GSQ").length > 2
						|| cntColumnNames.get(i).split("DSQ").length > 2) {
					continue;
				} else
					cntOfBaseColumnSQVector.add((ArithExpr) ConstraintGenerator.genSelectTest2(cvc, joinTable,
							jtColumns.indexOf(cntColumnNames.get(i)), "i1"));
			}
			ArithExpr[] cntOfBaseColumnSQ = new ArithExpr[cntOfBaseColumnSQVector.size()];
			for (int i = 0; i < cntOfBaseColumnSQVector.size(); i++) {
				cntOfBaseColumnSQ[i] = cntOfBaseColumnSQVector.get(i);
			}
			Expr cntOfSQColumnSQ = ConstraintGenerator.genSelectTest2(cvc, joinTable,
					jtColumns.indexOf(cntColumnNames.get(cntColumnNames.size() - 1)), "i1");
			Expr[] andExprTemp = new Expr[3];
			andExprTemp[0] = ConstraintGenerator.ctx.mkGe((ArithExpr) cntOfSQColumnSQ,
					(ArithExpr) ConstraintGenerator.ctx.mkInt(0));
			andExprTemp[1] = ConstraintGenerator.ctx.mkLe((ArithExpr) cntOfSQColumnSQ,
					(ArithExpr) ConstraintGenerator.ctx.mkInt(tuplesInJoinTable));
			Expr multipExprOfCounts = ConstraintGenerator.ctx.mkMul(cntOfBaseColumnSQ);
			if (joinTables.size() > 1 || isNotDirectMapping)
				andExprTemp[2] = ConstraintGenerator.ctx.mkOr(
						ConstraintGenerator.ctx.mkEq(cntOfSQColumnSQ, multipExprOfCounts),
						ConstraintGenerator.ctx.mkEq(cntOfSQColumnSQ, ConstraintGenerator.ctx.mkInt(0)));
			else
				andExprTemp[2] = ConstraintGenerator.ctx.mkEq(cntOfSQColumnSQ, multipExprOfCounts);
			Expr andExprForCountLimit = ConstraintGenerator.ctx.mkAnd((BoolExpr) andExprTemp[0],
					(BoolExpr) andExprTemp[1], (BoolExpr) andExprTemp[2]);
			if (!(queryBlock.getLimit() != 0 || queryBlock.getOrderByNodes().size() > 0))
				tempConstraints += "\n(assert (forall ((i1 " + indexType + ")) \n\t" + andExprForCountLimit + "))\n";
			constraintString += tempConstraints;
			// end 1.5 step

			// step 1.75: Primary key for SQ table
			Expr cntOfSQColumnSQi1 = ConstraintGenerator.genSelectTest2(cvc, joinTable,
					jtColumns.indexOf(cntColumnNames.get(cntColumnNames.size() - 1)), "i1");
			Expr cntOfSQColumnSQj1 = ConstraintGenerator.genSelectTest2(cvc, joinTable,
					jtColumns.indexOf(cntColumnNames.get(cntColumnNames.size() - 1)), "j1");
			Expr orExprTempForPK = ConstraintGenerator.ctx.mkOr(
					ConstraintGenerator.ctx.mkEq((ArithExpr) cntOfSQColumnSQi1,
							(ArithExpr) ConstraintGenerator.ctx.mkInt(0)),
					ConstraintGenerator.ctx.mkEq((ArithExpr) cntOfSQColumnSQj1,
							(ArithExpr) ConstraintGenerator.ctx.mkInt(0)));
			BoolExpr[] andexprConstraintsTemp = new BoolExpr[primaryKeyOfJoinTable.size() + 1];
			int p = 0;
			for (int i = 0; i < primaryKeyOfJoinTable.size(); i++) {
				Expr selecti1 = ConstraintGenerator.genSelectTest2(cvc, joinTable,
						jtColumns.indexOf(primaryKeyOfJoinTable.get(i)), "i1");
				;
				Expr selectj1 = ConstraintGenerator.genSelectTest2(cvc, joinTable,
						jtColumns.indexOf(primaryKeyOfJoinTable.get(i)), "j1");
				;
				andexprConstraintsTemp[p] = (BoolExpr) ConstraintGenerator.ctx.mkEq(selecti1, selectj1);
				p++;
			}
			andexprConstraintsTemp[p] = ConstraintGenerator.ctx.mkNot(ConstraintGenerator.ctx.mkEq(
					(Expr) ConstraintGenerator.ctx.mkIntConst("i1"), (Expr) ConstraintGenerator.ctx.mkIntConst("j1")));

			Expr andExprTempForPK = null;
			if (primaryKeyOfJoinTable.size() != 0) {
				andExprTempForPK = ConstraintGenerator.ctx.mkAnd(andexprConstraintsTemp);
				String pkconstUsingNeq = "";
				if (primaryKeyMethod == true) {
					ArrayList<Column> primaryKeycols = new ArrayList<>();
					for (String a : primaryKeyOfJoinTable) {
						primaryKeycols.add(cvc.getTableMap().getSQTableByName(joinTable).getColumn(a));
					}
					pkconstUsingNeq = AddDataBaseConstraints.getPrimaryKeyConstUsingNonEquiMethod(primaryKeycols,
							tuplesInJoinTable);

				}
				if (pkconstUsingNeq.equalsIgnoreCase("")) {
					tempConstraints = "\n(assert (forall ((i1 " + indexType + ") (j1 " + indexType + ")) \n\t (=> \n\t"
							+ andExprTempForPK.toString()
							+ "\n\t\t" + orExprTempForPK + ")))\n\n";
				} else {
					if (pkconstUsingNeq.contains("select"))
						tempConstraints = "\n(assert \n" + pkconstUsingNeq + "\n)";
					else
						tempConstraints = "";
				}
			} else {
				tempConstraints = "";
			}

			constraintString += tempConstraints;
			if (joinTables.size() == 1) {
				Vector<Node> correlationConds = new Vector<>();
				correlationConds.addAll(cvc.correlationHashMap.keySet());
				// constraintString += getConstraintsForSelectionConds(cvc, queryBlock,
				// joinTables, joinTable, sqTable,
				// isExist, jtColumns,
				// cntColumnNames, tables.get(0), correlationConds);
				// constraintString += solveConjunctSQs(cvc, queryBlock, sqTable);
				constraintString += solveConjunctSQs(cvc, queryBlock, tables, joinTables, joinTable, indexType,
						jtColumns);

				insertBaseToResultMapping(cvc, queryBlock, sqTable.toString());
				ArrayList<String> typeCastedJt = new ArrayList<String>();
				for (Sort s : jtColumnDataTypes) {
					typeCastedJt.add(s.toString());
				}
				ArrayList<String> s = new ArrayList<String>();
				s.addAll(0, joinTables);

				SubqueryStructure sqs = new SubqueryStructure();
				sqs.SQTableName.put(joinTable, s);
				sqs.SQjoinWithEXISTS.put(joinTable, true);
				sqs.SQDefine.put(joinTable, constraintString);
				sqs.SQColumnsDataTypes.put(joinTable, typeCastedJt);
				sqs.SQColumns.put(joinTable, jtColumns);
				sqs.SQJoinSelectionAndJoinConds.put(joinTable, selectionAndJoinConds);
				sqs.SQJoinCorrelationConds.put(joinTable, correlationConds);

				if (subqueryType.equalsIgnoreCase("from")) {
					cvc.subqueryConstraintsMap.put("from", sqs);
				} else if (subqueryType.equalsIgnoreCase("outer")) {
					cvc.subqueryConstraintsMap.put("outer", sqs);
				} else {
					String temp = "where_" + String.valueOf(level);
					sqs.SQjoinWithEXISTS.put(joinTable, isExist);
					cvc.subqueryConstraintsMap.put(temp, sqs);
				}
				if (queryBlock.isSet == 1) {
					cvc.subqueryConstraintsMap.put(joinTable, sqs);
				}
				if (isChanged) {
					queryBlock.getConjunctsQs().set(0, old);
					queryBlock.JoinClauseTypes = joinTypeCopy;
					queryBlock.setBaseRelations(oldBaseRelation);
					queryBlock.setBaseSQRelations(oldBaseSQRelation);
					isChanged = false;
				}
				return "";
			}
			// test code for count ends
			// count assert
			// && correlationConds.size() == 0
			List<Integer> ks = new ArrayList<>(); // Define the list of k's for each element
			for (Table table : tables) {
				String tablename = table.getTableName();
				ks.add(cvc.getNoOfOutputTuples(tablename));
			}
			int n = ks.size(); // Number of elements

			// Generate the domains for each element
			List<List<Integer>> domains = generateDomains(ks);

			// Generate all combinations
			List<List<Integer>> combinations = generateCombinations(domains);

			String constr = "";
			Vector<Node> correlationConds = new Vector<>();
			int cnt = 0;
			boolean isCorrCondPresent = false;
			String unrolldFor = "";
			for (List<Integer> indList : combinations) {
				// System.out.println(indList);
				Map<String, Object> returnVal = getForwardPassJoinandSelectionConstraints(cvc, queryBlock,
						queryBlock.getConjunctsQs().get(0), sqTable, joinTables,
						queryBlock.getConjunctsQs().get(0).getSelectionConds(),
						queryBlock.getConjunctsQs().get(0).getJoinCondsForEquivalenceClasses(),
						queryBlock.getConjunctsQs().get(0).getJoinCondsAllOther(),
						queryBlock.getConjunctsQs().get(0).getStringSelectionConds(),
						queryBlock.getConjunctsQs().get(0).getInClauseConds(),
						queryBlock.getConjunctsQs().get(0).getIsNullConds(), true, indList, cnt, isExist);
				isCorrCondPresent = (Boolean) returnVal.get("isCorrCondPresent");
				correlationConds = (Vector<Node>) returnVal.get("correlationConds");
				constr += (String) returnVal.get("constr");

				isCorrCondPresent = (Boolean) returnVal.get("isCorrCondPresent");

				String OrExprForCount = "";
				if (cnt == 0 && (isExist || (!isExist)) && (level == 0 || !isCorrCondPresent)) {

					// // chaitra AND for case tuples
					// if (cvc.getqStructure().isCase > 0)
					// OrExprForCount = "\n(assert\n\t(and ";
					// // chaitra AND for case tuples end
					// else
					OrExprForCount = "\n(assert\n\t(or ";

					if (!isExist && !isCorrCondPresent)
						OrExprForCount = "\n(assert\n\t(and ";
					for (int j = 1; j <= tuplesInJoinTable; j++) {
						Expr cntOfSQColumnSQforAllTuples = ConstraintGenerator.genSelectTest(cvc, joinTable,
								jtColumns.indexOf(cntColumnNames.get(cntColumnNames.size() - 1)), j);

						Expr greaterCnt = ConstraintGenerator.ctx.mkGt((ArithExpr) cntOfSQColumnSQforAllTuples,
								(ArithExpr) ConstraintGenerator.ctx.mkInt(0));

						if (isCorrCondPresent)
							greaterCnt = ConstraintGenerator.ctx.mkGt((ArithExpr) cntOfSQColumnSQforAllTuples,
									(ArithExpr) ConstraintGenerator.ctx.mkInt(0));
						else if (!isExist)
							greaterCnt = ConstraintGenerator.ctx.mkEq((ArithExpr) cntOfSQColumnSQforAllTuples,
									(ArithExpr) ConstraintGenerator.ctx.mkInt(0));

						OrExprForCount += "\n\t\t" + greaterCnt.toString();
					}
					OrExprForCount += "\t))";
					// constraintString += "(assert (exists ((i1 Int)) "+greaterCnt+"))\n";

					if (cvc.getqStructure().isSetOp == false)
						constraintString += OrExprForCount + "\n";
				}

				Boolean existsUnroll;
				if (Configuration.getProperty("existsUnrollFlag").equalsIgnoreCase("true")) {
					existsUnroll = true;
				} else {
					existsUnroll = false;
				}
				String andExpr = "";
				if (existsUnroll) {
					// Subquery table forward pass with unrolled exist
					String tableIter = "";

					String cntColumnsInBaseTableValid = "";
					// Writing valid tuples in base table for forward pass implies condition
					for (int i = 0; i < tables.size(); i++) {
						tableIter += "(" + joinTables.get(i) + "_i  " + indexType + ")";// (i1 Int)(j1 Int)
						if (joinTables.get(i).contains("JSQ") && !tables.get(i).getIsExist())
							cntColumnsInBaseTableValid += ConstraintGenerator.ctx.mkEq(
									ConstraintGenerator.genSelectTest(cvc, joinTables.get(i),
											tables.get(i).getNoOfColumn() - 1, indList.get(i)),
									ConstraintGenerator.ctx.mkInt(0)).toString();
						else
							cntColumnsInBaseTableValid += ConstraintGenerator.ctx.mkGt(
									ConstraintGenerator.genSelectTest(cvc, joinTables.get(i),
											tables.get(i).getNoOfColumn() - 1, indList.get(i)),
									ConstraintGenerator.ctx.mkInt(0)).toString();
					}
					Expr cntColumnInBaseTable = ConstraintGenerator.ctx.mkTrue();

					// Writing forward pass mapping constraints

					for (int j = 1; j <= tuplesInJoinTable; j++) {
						String tempStr = "", tableCond = "";
						for (int i = 0; i < tables.size(); i++) {
							// if (joinTables.get(i).contains("JSQ") &&
							// !tables.get(i).getSQType().equalsIgnoreCase("from")
							// || joinTables.get(i).contains("GSQ") || joinTables.get(i).contains("DSQ"))
							// chaitra changed this if condition, made it similar to previous
							// chaitra initialized columns as base table columns
							HashMap<String, Column> columnsNeedMapping = tables.get(i).getColumns();
							if ((tables.get(i).getTableName().contains("JSQ")
									|| tables.get(i).getTableName().contains("GSQ")
									|| tables.get(i).getTableName().contains("DSQ"))
									&& !tables.get(i).getSQType().equalsIgnoreCase("from")) {
								cntColumnInBaseTable = ConstraintGenerator.genSelectTest(cvc, joinTables.get(i),
										tables.get(i).getNoOfColumn() - 1, j);
								columnsNeedMapping = getRequiredMappingFromSubquery(cvc,
										tables.get(i), level);
								if (columnsNeedMapping.size() == 0)
									continue;
							}
							// tableCond += "(" + joinTable + "map" + joinTables.get(i) + " " +
							// joinTables.get(i) + "_i "
							// + enumIndexVar + j
							// + ")\n";// (SQ1_pred2 j1 k1)\n

							tableCond += "( " + joinTable + "_map_" + joinTables.get(i) + " " + indList.get(i) + " "
									+ enumIndexVar + j
									+ " )\n";// (SQ1_pred2 j1 k1)\n

						}
						Expr cntOfSQColumnSQjth = ConstraintGenerator.genSelectTest(cvc, joinTable,
								jtColumns.indexOf(cntColumnNames.get(cntColumnNames.size() - 1)), j);

						tempStr += "\t"
								+ ConstraintGenerator.ctx
										.mkGt((ArithExpr) cntOfSQColumnSQjth, ConstraintGenerator.ctx.mkInt(0))
										.toString()
								+ "\n";// constraints for value of cnt > 0

						andExpr += "\n\t(and \n\t\t" + tempStr + "\t\t" + tableCond + "\t)";
					}
					// System.out.println(andExpr);
					constr += cntColumnsInBaseTableValid;
					if (constr != "")
						constr = "(and \n" + constr + "\t\t)";

					unrolldFor = "\n" + (constr != "" ? ("(=> " + constr) + "\n(or" + andExpr : "") + "))";
					constr = "";
					constraintString += "\n(assert\t " + (unrolldFor + "\n)");
				} else {
					// Subquery table forward pass using exist in smt
					String tableIter = "", tableCond = "";
					for (int i = 0; i < tables.size(); i++) {
						tableIter += "(" + joinTables.get(i) + "_i  " + indexType + ")";// (i1 Int)(j1 Int)
						if (joinTables.get(i).contains("JSQ") && !tables.get(i).getSQType().equalsIgnoreCase("from")
								|| joinTables.get(i).contains("GSQ") || joinTables.get(i).contains("DSQ")) {
							HashMap<String, Column> columnsNeedMapping = getRequiredMappingFromSubquery(cvc,
									tables.get(i),
									level);
							if (columnsNeedMapping.size() == 0)
								continue;
						}
						tableCond += "(" + joinTable + "_map_" + joinTables.get(i) + " " + joinTables.get(i) + "_i "
								+ joinTable + "_i)\n";// (SQ1_pred2 j1 k1)\n

						Expr cntColumnInBaseTable = ConstraintGenerator.genSelectTest2(cvc, joinTables.get(i),
								tables.get(i).getNoOfColumn() - 1, joinTables.get(i) + "_i");
						if (isExist == false) // sunanda for Not
						{
							constr += ConstraintGenerator.ctx
									.mkEq((ArithExpr) cntColumnInBaseTable, ConstraintGenerator.ctx.mkInt(0)).toString()
									+ "\n";// constraints for value of cnt = 0

						} else
							constr += ConstraintGenerator.ctx
									.mkGt((ArithExpr) cntColumnInBaseTable, ConstraintGenerator.ctx.mkInt(0)).toString()
									+ "\n";// constraints for value of cnt > 0
					}
					constraintString += "(assert (forall (" + tableIter + ") \n\t"
							+ (constr != "" ? ("(=> " + constr) : "")
							+ "  ";
					constraintString += "\n \t(exists ((" + joinTable + "_i " + indexType + ")) ";
					constr = "";
					constr += ConstraintGenerator.ctx
							.mkGt(ConstraintGenerator.ctx.mkIntConst(joinTable + "_i"),
									ConstraintGenerator.ctx.mkInt(0))
							.toString() + "\n";
					constr += ConstraintGenerator.ctx.mkLe(ConstraintGenerator.ctx.mkIntConst(joinTable + "_i"),
							ConstraintGenerator.ctx.mkInt(tuplesInJoinTable)).toString() + "\n";
					constr += ConstraintGenerator.ctx.mkGt(
							(ArithExpr) ConstraintGenerator.genSelectTest2(cvc, joinTable,
									jtColumns.indexOf(cntColumnNames.get(cntColumnNames.size() - 1)), joinTable + "_i"),
							ConstraintGenerator.ctx.mkInt(0)).toString() + "\n";

					constraintString += "\n\t (and \n" + constr + tableCond + "))\n)\n)" + (constr != "" ? "\n)" : "");
				}
				cnt++;

			}

			// ------------------forward pass------------

			String tempBoundaries = "";
			tempBoundaries += ConstraintGenerator.ctx
					.mkGt(ConstraintGenerator.ctx.mkIntConst("i1"), ConstraintGenerator.ctx.mkInt(0)).toString() + "\n";
			tempBoundaries += ConstraintGenerator.ctx
					.mkLe(ConstraintGenerator.ctx.mkIntConst("i1"), ConstraintGenerator.ctx.mkInt(tuplesInJoinTable))
					.toString() + "\n";
			constr = "\t";
			String t = getBackwardPassJoinandSelectionConstraints(cvc, queryBlock,
					queryBlock.getConjunctsQs().get(0), sqTable, tables,
					queryBlock.getConjunctsQs().get(0).getSelectionConds(),
					queryBlock.getConjunctsQs().get(0).getJoinCondsForEquivalenceClasses(),
					queryBlock.getConjunctsQs().get(0).getJoinCondsAllOther(),
					queryBlock.getConjunctsQs().get(0).getStringSelectionConds(),
					queryBlock.getConjunctsQs().get(0).getInClauseConds(),
					queryBlock.getConjunctsQs().get(0).getIsNullConds(),
					jtColumns, joinTable, true);
			constr += t;
			tempConstraints = "";
			for (int index = 0; index < tables.size(); index++) {
				String tempconstrTable1 = "";
				for (int i = 1; i <= tuplesInTable.get(index); i++) {
					if (joinTables.get(index).contains("JSQ") && !tables.get(index).getSQType().equalsIgnoreCase("from")
							|| joinTables.get(index).contains("GSQ") || joinTables.get(index).contains("DSQ")) {
						HashMap<String, Column> columnsNeedMapping = getRequiredMappingFromSubquery(cvc,
								tables.get(index), level);
						if (columnsNeedMapping.size() == 0 && !isCorrCondPresent) {
							if (!tables.get(index).getIsExist())
								tempconstrTable1 += ConstraintGenerator.getConstraintsForInValidCountUsingTable(
										tables.get(index), tables.get(index).getTableName(), i, 0);
							else
								tempconstrTable1 += ConstraintGenerator.getConstraintsForValidCountUsingTable(
										tables.get(index), tables.get(index).getTableName(), i, 0);

						}
					} else {
						tempconstrTable1 += "\t\t(" + joinTable + "_map_" + joinTables.get(index) + " \t"
								+ enumIndexVar + Integer.toString(i) + "\t" + "i1" + ")\n";
					}

				}
				if (!tempconstrTable1.isEmpty())
					tempConstraints += "\t(or " + tempconstrTable1 + "\n\t)\n ";
			}
			String finalOuterJoinCond = "";
			if (Configuration.isEnumInt.equalsIgnoreCase("true"))
				tempBoundaries = "";
			cntOfSQColumnSQi1 = ConstraintGenerator.ctx.mkGt((ArithExpr) cntOfSQColumnSQ,
					(ArithExpr) ConstraintGenerator.ctx.mkInt(0));
			String finalConstraints = "\n" + "( and " + constr + "\n" + tempConstraints + ")" + " \n  ";
			finalConstraints = "(or " + finalConstraints + finalOuterJoinCond + ")";
			// String finalOuterJoinConstraints="\n"+"( and "+negationCond+mapping+")";
			finalConstraints = "\n(assert (forall ((" + "i1 " + indexType + ")) \n (=> " + cntOfSQColumnSQi1
					+ "\n(and \n\t"
					+ tempBoundaries + "\n\n\t" + finalConstraints + "\n )\n)\n))";
			constraintString += finalConstraints;

			// end------------

			ArrayList<String> typeCastedJt = new ArrayList<String>();
			for (Sort s : jtColumnDataTypes) {
				typeCastedJt.add(s.toString());
			}
			ArrayList<String> s = new ArrayList<String>();
			s.addAll(0, joinTables);

			SubqueryStructure sqs = new SubqueryStructure();
			sqs.SQTableName.put(joinTable, s);
			sqs.SQjoinWithEXISTS.put(joinTable, true);
			sqs.SQDefine.put(joinTable, constraintString);
			sqs.SQColumnsDataTypes.put(joinTable, typeCastedJt);
			sqs.SQColumns.put(joinTable, jtColumns);
			sqs.SQJoinSelectionAndJoinConds.put(joinTable, selectionAndJoinConds);
			sqs.SQJoinCorrelationConds.put(joinTable, correlationConds);

			if (subqueryType.equalsIgnoreCase("from")) {
				cvc.subqueryConstraintsMap.put("from", sqs);
			} else if (subqueryType.equalsIgnoreCase("outer")) {
				cvc.subqueryConstraintsMap.put("outer", sqs);
			} else {
				String temp = "where_" + String.valueOf(level);
				sqs.SQjoinWithEXISTS.put(joinTable, isExist);
				cvc.subqueryConstraintsMap.put(temp, sqs);
			}
			if (queryBlock.isSet == 1) {
				cvc.subqueryConstraintsMap.put(joinTable, sqs);
			}
			if (isChanged) {
				queryBlock.getConjunctsQs().set(0, old);
				queryBlock.JoinClauseTypes = joinTypeCopy;
				queryBlock.setBaseRelations(oldBaseRelation);
				queryBlock.setBaseSQRelations(oldBaseSQRelation);
				isChanged = false;
			}

			return "";
		}
		return constraintString;

	}

	public static void fixBaseRelations(GenerateCVC1 cvc, QueryBlockDetails qbt) {
		Vector<Integer> tablesToRemove = new Vector<>();
		if (cvc.aliasMappingToLevelsForWith != null) {
			for (int i = 0; i < qbt.getBaseRelations().size(); i++) {
				String oldTable = qbt.getBaseRelations().get(i).toLowerCase().replaceAll("\\d+$", "");
				if (cvc.aliasMappingToLevelsForWith.containsKey(oldTable)) {
					tablesToRemove.add(i);

				}
			}
			for (int i = 0; i < tablesToRemove.size(); i++) {
				int index = tablesToRemove.get(i);
				String oldTable = qbt.getBaseRelations().get(index).toLowerCase().replaceAll("\\d+$", "");
				if (cvc.aliasMappingToLevelsForWith.containsKey(oldTable)) {
					String newTable = cvc.aliasMappingToLevelsForWith.get(oldTable).repSQTable;
					qbt.getBaseSQRelations().add(newTable);
					qbt.getBaseRelations().remove(index);

				}
			}
		}

	}

	private static String getBackwardPassJoinandSelectionConstraints(GenerateCVC1 cvc,
			QueryBlockDetails queryBlock, Object cqs, Table sqTable, Vector<Table> tables,
			Vector<Node> selConds,
			Vector<Node> joinConds,
			Vector<Node> otherConds,
			Vector<Node> stringSelectionConds,
			Vector<Node> inConds,
			Vector<Node> isNullNodes,
			ArrayList<String> jtColumns,
			String joinTable,
			Boolean andOr // false for or true for and
	) throws Exception {

		// Map<String, Object> returnValues = new HashMap<String, Object>();
		boolean isCorrCondPresent = false;
		Vector<Node> correlationConds = new Vector<Node>();
		ConstraintGenerator constrGen = new ConstraintGenerator();

		for (Node n : cvc.correlationHashMap.keySet()) {
			correlationStructure cs = cvc.correlationHashMap.get(n);
			if (cs.getProcessLevel() == queryBlock.getLevel()) {
				correlationConds.add(n);
			}
		}

		String constr = "";
		if (cqs == null) {
			// returnValues.put("constr", "");
			// returnValues.put("isCorrCondPresent", isCorrCondPresent);
			// returnValues.put("correlationConds", correlationConds);
			return "";
		}

		if (cqs instanceof ConjunctQueryStructure) {
			ConjunctQueryStructure cq = (ConjunctQueryStructure) cqs;
			if (cq.getDisjuncts() != null && cq.getDisjuncts().size() != 0) {
				String tempconstr = "";
				for (DisjunctQueryStructure dsj : cq.getDisjuncts()) {
					if (dsj.getSelectionConds().size() + dsj.getJoinCondsForEquivalenceClasses().size() +
							dsj.getJoinCondsAllOther().size() + dsj.getStringSelectionConds().size()
							+ isNullNodes.size() + inConds.size() == 0)
						continue;
					tempconstr += getBackwardPassJoinandSelectionConstraints(cvc, queryBlock, dsj, sqTable, tables,
							dsj.getSelectionConds(), dsj.getJoinCondsForEquivalenceClasses(),
							dsj.getJoinCondsAllOther(), dsj.getStringSelectionConds(), inConds, isNullNodes, jtColumns,
							joinTable,
							false);

				}
				constr += tempconstr;
				// constr += "\n\t(and " + tempconstr + ")\n" ;
			}
		}

		Vector<Node> selectionAndJoinConds = new Vector<Node>();
		Set<Node> uniqueNodes = new LinkedHashSet<>(); // maintains insertion order

		uniqueNodes.addAll(selConds);
		uniqueNodes.addAll(joinConds);
		uniqueNodes.addAll(otherConds);
		uniqueNodes.addAll(isNullNodes);
		selectionAndJoinConds.addAll(uniqueNodes);

		for (Node n : selectionAndJoinConds) {
			if (!n.isCorrelated)
				constr += generateConstraintsForSelectionConditions(cvc, n, jtColumns, joinTable, tables, "i1", "i1")
						+ "\n\t";
			// else{
			// correlationConds.add(n);
			// }
			// String nonConstr = constrGen.getAssertNotNullCondition(cvc, n.getLeft(),
			// "i1");
			// nonConstr += constrGen.getAssertNotNullCondition(cvc, n.getRight(), "i1");

		}
		String SolvedCondForThisConInBaseTable = "";
		String tempC = "";
		HashMap<Node, String> hash = new HashMap<>();
		for (Node n : stringSelectionConds) {
			if (n.getRight() != null && n.getRight().toString().contains("[")
					&& (n.getOperator().equalsIgnoreCase("=") || n.getOperator().equalsIgnoreCase("~")
							|| n.getOperator().equalsIgnoreCase("i~") || n.getOperator().equalsIgnoreCase(">=")
							|| n.getOperator().equalsIgnoreCase("<="))) {
				String s = generateConstraintsForStringConditions(cvc, n, jtColumns, joinTable, tables, "i1", "i1");
				if (s.length() == 0)
					s = "true";
				hash.put(n.getLeft(), s);
			} else {
				constr += generateConstraintsForStringConditions(cvc, n, jtColumns, joinTable, tables, "i1", "i1");
			}

			// get non null constraints

		}
		for (Map.Entry<Node, String> entry : hash.entrySet()) {
			constr += entry.getValue();
		}

		String strConstr = "";
		for (Node n : inConds) {
			// For non-correlated valid conditions
			if (n != null && n.isCorrelated == false && n.getExpired() == false) {
				String s1 = generateConstraintsForSelectionConditions(cvc, n, jtColumns, joinTable, tables, "i1", "i1");
				String tempConstr = "";

				// Vector<String> s2 = new Vector<>();
				for (Node i : n.getRight().getComponentNodes()) {
					String s2 = constrGen.genPositiveCondsForPredF(cvc, queryBlock, i, "i1");
					String tempS = "\t\t" + ((n.isNegated) ? "(not " : " ") + "("
							+ (n.getType().equalsIgnoreCase("NOT IN") ? "not (= " : "=") + "  " + s1
							+ "  " + s2 + (n.getType().equalsIgnoreCase("NOT IN") ? " ) )" : " " + ")")
							+ ((n.isNegated) ? " )" : " ") + "\n";
					if (!n.getLeft().getColumn().getCvcDatatype().equalsIgnoreCase("int")
							&& !n.getLeft().getColumn().getCvcDatatype().equalsIgnoreCase("real")
							&& !n.getLeft().getColumn().getCvcDatatype().equalsIgnoreCase("time")
							&& !n.getLeft().getColumn().getCvcDatatype().equalsIgnoreCase("date")
							&& !n.getLeft().getColumn().getCvcDatatype().equalsIgnoreCase("timestamp")) {
						Vector<String> instringConstraints = new Vector<String>();
						instringConstraints.add(tempS);
						strConstr = "";
						Vector<String> solvedStringConstraint = cvc.getStringSolver().solveConstraints(
								instringConstraints, cvc.getResultsetColumns(), cvc.getTableMap(), true);

						for (String str : solvedStringConstraint) {
							str = str.substring(str.indexOf('(') + 1, str.lastIndexOf(')'));
							strConstr += "\t\t" + str.replace("assert", "") + "\n";
						}
						tempConstr += strConstr;
					} else {
						tempConstr += tempS;
					}

				}
				// constr += "(and " + tempConstr + nonConstr + ")\n\n"; // with non-null
				constr += "(or " + tempConstr + ")\n\n"; // without non-null

			}
		}

		// backward pass constraints for correlation
		for (Node n : correlationConds) {
			String temp = "";
			if (n.getLeft() != null && n.getLeft().getTableNameNo() != null
					&& (n.getLeft().getTableNameNo().contains("JSQ") || n.getLeft().getTableNameNo().contains("GSQ")
							|| n.getLeft().getTableNameNo().contains("DSQ"))) {
				for (int i = 1; i <= cvc.getNoOfOutputTuples(n.getLeft().getTableNameNo()); i++)
					temp += generateConstraintsForCorrelationConditionsBackwardPass(cvc, n, jtColumns, joinTable,
							tables, Integer.toString(i), true, "i1", false);
			}
			Boolean a = (n.getRight().getTableNameNo().contains("JSQ")
					|| n.getRight().getTableNameNo().contains("GSQ")
					|| n.getRight().getTableNameNo().contains("DSQ"));
			if (n.getRight() != null && n.getRight().getTableNameNo() != null//
					&& (n.getRight().getTableNameNo().contains("JSQ")
							|| n.getRight().getTableNameNo().contains("GSQ")
							|| n.getRight().getTableNameNo().contains("DSQ"))) {
				for (int i = 1; i <= cvc.getNoOfOutputTuples(n.getRight().getTableNameNo()); i++)
					temp += generateConstraintsForCorrelationConditionsBackwardPass(cvc, n, jtColumns, joinTable,
							tables, "i1", false, Integer.toString(i), true);
			}
			if (cvc.correlationHashMap.get(n).getQueryType().equalsIgnoreCase("EXISTS") && !temp.isEmpty())
				constr += "\n\t( or \n\t\t" + temp + " )";
			else if (cvc.correlationHashMap.get(n).getQueryType().equalsIgnoreCase("NOT EXISTS") && !temp.isEmpty())
				constr += "\n\t(not ( or \n\t\t" + temp + " ))";
			else {
				constr += JoinCondForBackwardMapping(cvc, n, jtColumns, joinTable);
			}
		}
		String constrF = andOr ? "\n\t(and " : "\n\t(or ";
		constrF += constr + ")\n";
		if (!constr.equalsIgnoreCase(""))
			return constrF;
		else
			return "";

	}

	private static String JoinCondForBackwardMapping(GenerateCVC1 cvc, Node n, ArrayList<String> jtColumns,
			String joinTable) {
		String constr = "";
		int i = -1, j = -1;
		String leftCol = "", rightCol = "";
		if (n.getLeft() != null)
			leftCol = n.getLeft().getColumn().toString();
		if (n.getRight() != null)
			rightCol = n.getRight().getColumn().toString();
		if (leftCol.length() == 0 || rightCol.length() == 0)
			return "";
		for (int k = 0; k < jtColumns.size(); k++) {
			if (jtColumns.get(k).contains(leftCol) && jtColumns.get(k).contains(n.getLeft().getTable().toString()))
				i = k;
			else if (jtColumns.get(k).contains(rightCol)
					&& jtColumns.get(k).contains(n.getRight().getTable().toString()))
				j = k;
			if (i != -1 && j != -1)
				break;
		}
		if (i == -1 || j == -1)
			return "";
		ConstraintGenerator cg = new ConstraintGenerator();
		leftCol = " (" + jtColumns.get(i) + " " + "(select O_" + joinTable + " i1" + "))";
		rightCol = " (" + jtColumns.get(j) + " " + "(select O_" + joinTable + " i1" + "))";
		constr = cg.getUserDefinedComparisionOperator(n.getOperator(), n.getLeft().getColumn(), leftCol, rightCol);
		return constr;
	}

	private static String getJoinConditionConstraints(GenerateCVC1 cvc, QueryBlockDetails queryBlock,
			Vector<Node> joinNodes,
			String indexi, String indexj) {

		if (joinNodes == null || joinNodes.isEmpty())
			return "";

		ConstraintGenerator constrGen = new ConstraintGenerator();
		StringBuilder combinedConstr = new StringBuilder();

		if (joinNodes.size() > 1) {
			combinedConstr.append("(and \n");
		}

		for (Node n : joinNodes) {
			// 1. Identify Table and Column names for the identity check
			String leftTablename = "", leftColumnname = "", rightColumnname = "", rightTableName = "";

			if (n.getLeft() != null && n.getLeft().getType() == Node.getColRefType()) {
				leftTablename = n.getLeft().getTable() == null ? n.getLeft().getTableAlias()
						: n.getLeft().getTable().getTableName();
				leftColumnname = n.getLeft().getColumn().getColumnName();
			}

			if (n.getRight() != null && n.getRight().getType() == Node.getColRefType()) {
				rightTableName = n.getRight().getTable() == null ? n.getRight().getTableAlias()
						: n.getRight().getTable().getTableName();
				rightColumnname = n.getRight().getColumn().getColumnName();
			}

			// 2. Identity Check: Skip if comparing the same table/column/index while
			// negated
			if (leftTablename.equalsIgnoreCase(rightTableName)
					&& leftColumnname.equalsIgnoreCase(rightColumnname)
					&& indexi.equalsIgnoreCase(indexj) && n.isNegated) {
				continue;
			}

			// 3. Generate conditions for Left and Right sides
			String s1 = ConstraintGenerator.genPositiveCondsForPredF(cvc, queryBlock, n.getLeft(), indexi);
			String s2 = ConstraintGenerator.genPositiveCondsForPredF(cvc, queryBlock, n.getRight(), indexj);

			// 4. Get non-null constraints using ConstraintGenerator
			String nonConstr = constrGen.getAssertNotNullCondition(cvc, n.getLeft(), indexi);
			nonConstr += constrGen.getAssertNotNullCondition(cvc, n.getRight(), indexj);

			// 5. Build the operator constraint based on the snippet logic
			String op = "";
			StringBuilder tempConstr = new StringBuilder();

			if (s1 != null && s2 != null && s1.contains("select") && s2.contains("select")) {
				op = constrGen.getUserDefinedComparisionOperator(n.getOperator(), n.getLeft().getColumn(), s1, s2);
				tempConstr.append(n.isNegated ? "(not " : " ").append(op).append(n.isNegated ? " )" : " ");
			} else {
				// Handle standard operators and the specific /= case
				String operatorStr = n.getOperator();
				if (operatorStr.equals("/=")) {
					tempConstr.append(n.isNegated ? "(not " : " ").append("(not (= ").append(s1).append(" ").append(s2)
							.append(" ) )").append(n.isNegated ? " )" : " ");
				} else {
					tempConstr.append(n.isNegated ? "(not " : " ").append("(").append(operatorStr).append(" ")
							.append(s1).append(" ").append(s2).append(")").append(n.isNegated ? " )" : " ");
				}
			}

			// 6. Combine the condition with the null constraints
			if (!tempConstr.toString().isEmpty() || !nonConstr.isEmpty()) {
				combinedConstr.append(" (and ").append(tempConstr.toString().trim()).append(" ").append(nonConstr)
						.append(" )\n");
			}
		}

		if (joinNodes.size() > 1) {
			combinedConstr.append(") ");
		}

		return combinedConstr.toString();
	}

	private static String getForwardPassForOuterJoin(GenerateCVC1 cvc, QueryBlockDetails queryBlock,
			String joinClauseType, Table joinResultTable, Vector<Table> tables, ArrayList<String> jtColumns,
			Vector<Node> joinCondNodes) {
		if (joinClauseType.equals(JoinClauseInfo.innerJoin))
			return "";
		String constr = "";
		Vector<String> joinTables = new Vector<>();
		joinTables.add(tables.get(0).toString());
		joinTables.add(tables.get(1).toString());
		constr += ConstraintGenerator.addCommentLine("CONSTRAINTS FOR OUTERJOIN FORWARD MAPPING STARTS");
		boolean existsUnroll = "true".equalsIgnoreCase(Configuration.getProperty("existsUnrollFlag"));
		// existsUnroll = false;
		String resultJoinTable = joinResultTable.toString();
		String leftTable = joinTables.get(0);
		String rightTable = joinTables.get(1);

		int leftTuples = cvc.getNoOfOutputTuples(leftTable);
		int rightTuples = cvc.getNoOfOutputTuples(rightTable);
		int resultTuples = cvc.getNoOfOutputTuples(resultJoinTable);

		/* ================= LEFT OUTER JOIN ================= */
		if (joinClauseType.equals(JoinClauseInfo.leftOuterJoin)
				|| joinClauseType.equals(JoinClauseInfo.fullOuterJoin)) {

			if (!existsUnroll) {
				// quantified version
				Expr cntLeftExpr = ConstraintGenerator.genSelectTest2(
						cvc, leftTable,
						tables.get(joinTables.indexOf(leftTable)).getNoOfColumn() - 1, "i");
				Expr cntLeft = ConstraintGenerator.ctx.mkGt((ArithExpr) cntLeftExpr,
						ConstraintGenerator.ctx.mkInt(0));

				Expr cntRightExpr = ConstraintGenerator.genSelectTest2(
						cvc, rightTable,
						tables.get(joinTables.indexOf(rightTable)).getNoOfColumn() - 1, "j");
				Expr cntRight = ConstraintGenerator.ctx.mkGt((ArithExpr) cntRightExpr,
						ConstraintGenerator.ctx.mkInt(0));

				Expr cntResExpr = ConstraintGenerator.genSelectTest2(
						cvc, resultJoinTable, jtColumns.size() - 1, "k");
				Expr cntRes = ConstraintGenerator.ctx.mkGt((ArithExpr) cntResExpr,
						ConstraintGenerator.ctx.mkInt(0));

				String joinCondString = getJoinConditionConstraints(cvc, queryBlock, joinCondNodes, "i", "j");

				String fun = "(" + resultJoinTable + "_map_" + leftTable + " i k)\n";
				String nullFun = "(" + resultJoinTable + "_map_" + rightTable + "_NULL k)\n";

				String existsJ = "(exists ((j Int)) (and (>= j 1) (<= j " + rightTuples + ") "
						+ cntRight.toString() + " " + joinCondString + "))";

				String existsK = "(exists ((k Int)) (and (>= k 1) (<= k " + resultTuples + ") "
						+ cntRes.toString() + " " + fun + " " + nullFun + "))";

				constr += "(assert\n" +
						"  (forall ((i Int))\n" +
						"    (=> (and (>= i 1) (<= i " + leftTuples + ") " + cntLeft.toString() + ")\n" +
						"        (=> (not " + existsJ + ") " + existsK + ")))\n" +
						")\n";

			} else {
				// unrolled version
				for (int iVal = 1; iVal <= leftTuples; iVal++) {
					Expr cntLeftExpr = ConstraintGenerator.genSelectTest(
							cvc, leftTable,
							tables.get(joinTables.indexOf(leftTable)).getNoOfColumn() - 1, iVal);
					String cntLeft = ConstraintGenerator.ctx.mkGt((ArithExpr) cntLeftExpr,
							ConstraintGenerator.ctx.mkInt(0)).toString();

					// build existsJ
					String existsJ = "(or\n";
					for (int jVal = 1; jVal <= rightTuples; jVal++) {
						Expr cntRightExpr = ConstraintGenerator.genSelectTest(
								cvc, rightTable,
								tables.get(joinTables.indexOf(rightTable)).getNoOfColumn() - 1, jVal);
						String cntRight = ConstraintGenerator.ctx.mkGt((ArithExpr) cntRightExpr,
								ConstraintGenerator.ctx.mkInt(0)).toString();

						String joinCondString = getJoinConditionConstraints(cvc, queryBlock, joinCondNodes,
								String.valueOf(iVal), String.valueOf(jVal));

						existsJ += "  (and " + cntRight + " " + joinCondString + ")\n";
					}
					existsJ += ")";

					// build existsK fresh each loop
					String existsK = "(or\n";
					for (int kVal = 1; kVal <= resultTuples; kVal++) {
						Expr cntResExpr = ConstraintGenerator.genSelectTest(
								cvc, resultJoinTable,
								jtColumns.size() - 1, kVal);
						String cntRes = ConstraintGenerator.ctx.mkGt((ArithExpr) cntResExpr,
								ConstraintGenerator.ctx.mkInt(0)).toString();

						String fun = "(" + resultJoinTable + "_map_" + leftTable + " " + iVal + " " + kVal + ")\n";
						String nullFun = "(" + resultJoinTable + "_map_" + rightTable + "_NULL " + kVal + ")\n";

						existsK += "  (and " + cntRes + " " + fun + " " + nullFun + ")\n";
					}
					existsK += ")";

					constr += "(assert (=> " + cntLeft +
							" (=> (not " + existsJ + ") " + existsK + ")))\n";
				}
			}
		}

		/* ================= RIGHT OUTER JOIN ================= */
		if (joinClauseType.equals(JoinClauseInfo.rightOuterJoin)
				|| joinClauseType.equals(JoinClauseInfo.fullOuterJoin)) {

			if (!existsUnroll) {
				// quantified version
				Expr cntLeftExpr = ConstraintGenerator.genSelectTest2(
						cvc, leftTable,
						tables.get(joinTables.indexOf(leftTable)).getNoOfColumn() - 1, "i");
				Expr cntLeft = ConstraintGenerator.ctx.mkGt((ArithExpr) cntLeftExpr,
						ConstraintGenerator.ctx.mkInt(0));

				Expr cntRightExpr = ConstraintGenerator.genSelectTest2(
						cvc, rightTable,
						tables.get(joinTables.indexOf(rightTable)).getNoOfColumn() - 1, "j");
				Expr cntRight = ConstraintGenerator.ctx.mkGt((ArithExpr) cntRightExpr,
						ConstraintGenerator.ctx.mkInt(0));

				Expr cntResExpr = ConstraintGenerator.genSelectTest2(
						cvc, resultJoinTable, jtColumns.size() - 1, "k");
				Expr cntRes = ConstraintGenerator.ctx.mkGt((ArithExpr) cntResExpr,
						ConstraintGenerator.ctx.mkInt(0));

				String joinCondString = getJoinConditionConstraints(cvc, queryBlock, joinCondNodes, "i", "j");

				String fun = "(" + resultJoinTable + "_map_" + rightTable + " j k)\n";
				String nullFun = "(" + resultJoinTable + "_map_" + leftTable + "_NULL k)\n";

				String existsI = "(exists ((i Int)) (and (>= i 1) (<= i " + leftTuples + ") "
						+ cntLeft.toString() + " " + joinCondString + "))";

				String existsK = "(exists ((k Int)) (and (>= k 1) (<= k " + resultTuples + ") "
						+ cntRes.toString() + " " + fun + " " + nullFun + "))";

				constr += "(assert\n" +
						"  (forall ((j Int))\n" +
						"    (=> (and (>= j 1) (<= j " + rightTuples + ") " + cntRight.toString() + ")\n" +
						"        (=> (not " + existsI + ") " + existsK + ")))\n" +
						")\n";

			} else {
				// unrolled version
				for (int jVal = 1; jVal <= rightTuples; jVal++) {
					Expr cntRightExpr = ConstraintGenerator.genSelectTest(
							cvc, rightTable,
							tables.get(joinTables.indexOf(rightTable)).getNoOfColumn() - 1, jVal);
					String cntRight = ConstraintGenerator.ctx.mkGt((ArithExpr) cntRightExpr,
							ConstraintGenerator.ctx.mkInt(0)).toString();

					// build existsI
					String existsI = "(or\n";
					for (int iVal = 1; iVal <= leftTuples; iVal++) {
						Expr cntLeftExpr = ConstraintGenerator.genSelectTest(
								cvc, leftTable,
								tables.get(joinTables.indexOf(leftTable)).getNoOfColumn() - 1, iVal);
						String cntLeft = ConstraintGenerator.ctx.mkGt((ArithExpr) cntLeftExpr,
								ConstraintGenerator.ctx.mkInt(0)).toString();

						String joinCondString = getJoinConditionConstraints(cvc, queryBlock, joinCondNodes,
								String.valueOf(iVal), String.valueOf(jVal));
						existsI += "  (and " + cntLeft + " " + joinCondString + ")\n";
					}
					existsI += ")";

					// build existsK fresh each loop
					String existsK = "(or\n";
					for (int kVal = 1; kVal <= resultTuples; kVal++) {
						Expr cntResExpr = ConstraintGenerator.genSelectTest(
								cvc, resultJoinTable,
								jtColumns.size() - 1, kVal);
						String cntRes = ConstraintGenerator.ctx.mkGt((ArithExpr) cntResExpr,
								ConstraintGenerator.ctx.mkInt(0)).toString();

						String fun = "(" + resultJoinTable + "_map_" + rightTable + " " + jVal + " " + kVal + ")\n";
						String nullFun = "(" + resultJoinTable + "_map_" + leftTable + "_NULL " + kVal + ")\n";

						existsK += "  (and " + cntRes + " " + fun + " " + nullFun + ")\n";
					}
					existsK += ")";

					constr += "(assert (=> " + cntRight +
							" (=> (not " + existsI + ") " + existsK + ")))\n";
				}
			}
		}
		constr += ConstraintGenerator.addCommentLine("CONSTRAINTS FOR OUTERJOIN FORWARD MAPPING ENDS");
		// constr += getSelectionConditionWhenOuterJoinPresent(cvc, queryBlock,
		// joinResultTable, jtColumns);
		return constr;
	}

	private static String getOtherRelationNotMactchingCond(GenerateCVC1 cvc, QueryBlockDetails queryBlock,
			String leftTable, String rightTable, String resultJoinTable, ArrayList<String> jtColumns, String JoinType,
			String index, Vector<Node> joinCondNodes) {

		ConstraintGenerator constrGen = new ConstraintGenerator();

		StringBuilder conditions = new StringBuilder();
		if (joinCondNodes.size() > 1) {
			conditions.append("(or ");
		}

		for (Node n : joinCondNodes) {
			String resultTableColumnValue = ""; // The value currently in the Joined/Result table
			String originalTableColumnValue = ""; // The value in the table we are checking against

			// 1. Identify which table is the "Preserved" table and which is the
			// "Null-producing" table
			String preservedTable = JoinType.equals(JoinClauseInfo.leftOuterJoin) ? leftTable : rightTable;
			String nullProducingTable = JoinType.equals(JoinClauseInfo.leftOuterJoin) ? rightTable : leftTable;

			// 2. Identify the columns from the Join Node (n)
			Node leftNode = n.getLeft();
			Node rightNode = n.getRight();

			String preservedTableColumn = "";
			Node nullProducingNode = null;

			// Determine which side of the join predicate (n) belongs to the preserved table
			if (leftNode.getTable().toString().equals(preservedTable)) {
				preservedTableColumn = leftNode.getColumn().toString();
				nullProducingNode = rightNode;
			} else if (rightNode.getTable().toString().equals(preservedTable)) {
				preservedTableColumn = rightNode.getColumn().toString();
				nullProducingNode = leftNode;
			}
			preservedTableColumn = preservedTableColumn.replaceAll("\\d+$", "");

			// 3. Get the value from the Result Join Table (O_JSQ...)
			String resultTableSelection = "(select O_" + resultJoinTable + " i1)";
			for (String col : jtColumns) {
				if (col.contains(preservedTable) && col.contains(preservedTableColumn)) {
					resultTableColumnValue = "(" + col + " " + resultTableSelection + ")";
					break;
				}
			}

			// 4. Get the value from the Null-Producing side
			if (nullProducingNode != null) {
				originalTableColumnValue = constrGen.genPositiveCondsForPredF(cvc, queryBlock, nullProducingNode,
						index);
			}

			// 5. Safety Check
			if (resultTableColumnValue.isEmpty() || originalTableColumnValue.isEmpty()) {
				conditions.append(" true ");
			} else {
				conditions.append(" (not (= ").append(resultTableColumnValue).append(" ")
						.append(originalTableColumnValue).append(")) ");
			}
		}

		if (joinCondNodes.size() > 1) {
			conditions.append(")");
		}

		return conditions.toString();
	}

	private static Node findColumnInResultTable(Node n, Table resultJoinTable, ArrayList<String> jtColumns) {
		Node r = new Node(n);
		String baseCol = n.getColumn().toString(), baseTable = n.getTable().toString();
		for (int i = 0; i < jtColumns.size(); i++) {
			String col = jtColumns.get(i);
			if (col.contains(baseCol) && col.contains(baseTable)) {
				r.setColumn(resultJoinTable.getColumn(col));
				r.setTable(resultJoinTable);
				r.setTableAlias(resultJoinTable.toString());
				r.setTableNameNo(resultJoinTable.toString());
				break;

			}
		}
		return r;
	}

	private static String getBackwardPassForOuterJoin(
			GenerateCVC1 cvc, QueryBlockDetails queryBlock, String joinClauseType, Vector<Node> joinCondNodes,
			String resultJoinTable, Vector<String> joinTables,
			Vector<Table> tables, ArrayList<String> jtColumns) {

		String constr = "";
		if (joinClauseType.equals(JoinClauseInfo.innerJoin))
			return constr;
		ConstraintGenerator constrGen = new ConstraintGenerator();
		boolean existsUnroll = "true".equalsIgnoreCase(Configuration.getProperty("existsUnrollFlag"));
		// existsUnroll = false;
		String leftTable = joinTables.get(0);
		String rightTable = joinTables.get(1);

		int leftTuples = cvc.getNoOfOutputTuples(leftTable);
		int rightTuples = cvc.getNoOfOutputTuples(rightTable);

		// ---------- LEFT OUTER JOIN / FULL OUTER JOIN ----------
		if (joinClauseType.equals(JoinClauseInfo.leftOuterJoin)
				|| joinClauseType.equals(JoinClauseInfo.fullOuterJoin)) {

			String nonConstr = "";
			for (Node joinCondNode : joinCondNodes) {
				Node temp = findColumnInResultTable(joinCondNode.getLeft(),
						cvc.getTableMap().getSQTableByName(resultJoinTable), jtColumns);
				String nc = constrGen.getAssertNotNullCondition(cvc, temp, "i1");
				nonConstr += nc + " ";
			}
			// Mapping
			String mapping = "";

			for (int j = 1; j <= leftTuples; j++) {
				mapping += "\t\t(" + resultJoinTable + "_map_" + leftTable + " " + j + " i1)\n";
			}
			mapping = "\t(or" + mapping + "\t)\n";

			// Null mapping
			String nullMapping = "\t(" + resultJoinTable + "_map_" + rightTable + "_NULL i1)\n";

			String condBlock = "";

			if (existsUnroll) {
				// Unrolled version
				for (int j = 1; j <= rightTuples; j++) {
					Expr cntColumnInRightTable = ConstraintGenerator.genSelectTest(
							cvc, rightTable,
							tables.get(joinTables.indexOf(rightTable)).getNoOfColumn() - 1,
							j);
					cntColumnInRightTable = ConstraintGenerator.ctx.mkGt(
							(ArithExpr) cntColumnInRightTable,
							ConstraintGenerator.ctx.mkInt(0));

					String innerNotMatch = getOtherRelationNotMactchingCond(
							cvc, queryBlock, leftTable, rightTable,
							resultJoinTable, jtColumns,
							JoinClauseInfo.leftOuterJoin, Integer.toString(j), joinCondNodes);

					condBlock += "\t(=> " + cntColumnInRightTable + "\n" +
							"\t    " + innerNotMatch + ")\n";
				}
			} else {
				// Quantified version
				Expr cntColumnInRightTable = ConstraintGenerator.genSelectTest2(
						cvc, rightTable,
						tables.get(joinTables.indexOf(rightTable)).getNoOfColumn() - 1, "i");
				cntColumnInRightTable = ConstraintGenerator.ctx.mkGt(
						(ArithExpr) cntColumnInRightTable,
						ConstraintGenerator.ctx.mkInt(0));

				String innerNotMatch = getOtherRelationNotMactchingCond(
						cvc, queryBlock, leftTable, rightTable,
						resultJoinTable, jtColumns,
						JoinClauseInfo.leftOuterJoin, "i", joinCondNodes);

				condBlock = "\t(forall ((i Int))\n" +
						"\t  (=> (and (>= i 1) (<= i " + rightTuples + ")\n" +
						"\t           " + cntColumnInRightTable + ")\n" +
						"\t      " + innerNotMatch + "))\n";
			}

			constr += "(and\n" + mapping + nullMapping + condBlock + nonConstr + ")\n";
		}

		// ---------- RIGHT OUTER JOIN / FULL OUTER JOIN ----------
		if (joinClauseType.equals(JoinClauseInfo.rightOuterJoin)
				|| joinClauseType.equals(JoinClauseInfo.fullOuterJoin)) {
			String nonConstr = "";
			for (Node joinCondNode : joinCondNodes) {
				Node temp = findColumnInResultTable(joinCondNode.getRight(),
						cvc.getTableMap().getSQTableByName(resultJoinTable), jtColumns);
				String nc = constrGen.getAssertNotNullCondition(cvc, temp, "i1");
				nonConstr += nc + " ";
			}
			// Mapping
			String mapping = "";
			for (int j = 1; j <= rightTuples; j++) {
				mapping += "\t\t(" + resultJoinTable + "_map_" + rightTable + " " + j + " i1)\n";
			}
			mapping = "\t(or" + mapping + "\t)\n";

			// Null mapping
			String nullMapping = "\t(" + resultJoinTable + "_map_" + leftTable + "_NULL i1)\n";

			String condBlock = "";

			if (existsUnroll) {
				// Unrolled version
				for (int j = 1; j <= leftTuples; j++) {
					Expr cntColumnInLeftTable = ConstraintGenerator.genSelectTest(
							cvc, leftTable,
							tables.get(joinTables.indexOf(leftTable)).getNoOfColumn() - 1,
							j);
					cntColumnInLeftTable = ConstraintGenerator.ctx.mkGt(
							(ArithExpr) cntColumnInLeftTable,
							ConstraintGenerator.ctx.mkInt(0));

					String innerNotMatch = getOtherRelationNotMactchingCond(
							cvc, queryBlock, leftTable, rightTable,
							resultJoinTable, jtColumns,
							JoinClauseInfo.rightOuterJoin, Integer.toString(j), joinCondNodes);

					condBlock += "\t(=> " + cntColumnInLeftTable.toString() + "\n" +
							"\t    " + innerNotMatch + ")\n";
				}
			} else {
				// Quantified version
				Expr cntColumnInLeftTable = ConstraintGenerator.genSelectTest2(
						cvc, leftTable,
						tables.get(joinTables.indexOf(leftTable)).getNoOfColumn() - 1, "i");
				cntColumnInLeftTable = ConstraintGenerator.ctx.mkGt(
						(ArithExpr) cntColumnInLeftTable,
						ConstraintGenerator.ctx.mkInt(0));

				String innerNotMatch = getOtherRelationNotMactchingCond(
						cvc, queryBlock, leftTable, rightTable,
						resultJoinTable, jtColumns,
						JoinClauseInfo.rightOuterJoin, "i", joinCondNodes);

				condBlock = "\t(forall ((i Int))\n" +
						"\t  (=> (and (>= i 1) (<= i " + leftTuples + ")\n" +
						"\t           " + cntColumnInLeftTable.toString() + ")\n" +
						"\t      " + innerNotMatch + "))\n";
			}

			constr += "(and\n" + mapping + nullMapping + condBlock + nonConstr + ")\n";
		}
		return constr;
	}

	private static Map<String, Object> getForwardPassJoinandSelectionConstraints(GenerateCVC1 cvc,
			QueryBlockDetails queryBlock, Object cqs, Table sqTable, Vector<String> joinTables,
			Vector<Node> selConds,
			Vector<Node> joinConds,
			Vector<Node> otherConds,
			Vector<Node> stringSelectionConds,
			Vector<Node> inConds,
			Vector<Node> isNullConds,
			Boolean andOr, // false for or true for and
			List<Integer> indList, int cnt, boolean isExist) throws Exception {
		// TODO Auto-generated method stub
		String strConstr = "", constr = "";
		Map<String, Object> returnValues = new HashMap<String, Object>();
		boolean isCorrCondPresent = false;
		Vector<Node> correlationConds = new Vector<Node>();

		Vector<Node> selectionAndJoinConds = new Vector<Node>();
		Vector<Node> stringConds = new Vector<Node>();

		int level = queryBlock.getLevel();
		ConstraintGenerator constrGen = new ConstraintGenerator();
		// for (ConjunctQueryStructure cqs : queryBlock.getConjunctsQs()) {
		// SELECTION and JOIN conditions
		// Vector<Node> selConds = cqs.getSelectionConds();
		// Vector<Node> joinConds = cqs.getJoinCondsForEquivalenceClasses();
		Vector<Node> Conds = new Vector<Node>();
		Conds.addAll(selConds);
		Conds.addAll(joinConds);
		Conds.addAll(otherConds);
		Conds.addAll(isNullConds);
		Conds.addAll(cvc.correlationHashMap.keySet());

		if (cqs instanceof ConjunctQueryStructure) {
			ConjunctQueryStructure cq = (ConjunctQueryStructure) cqs;
			if (cq.getDisjuncts() != null && cq.getDisjuncts().size() != 0) {
				String tempconstr = "";
				Vector<Node> inconds = new Vector<Node>();
				for (DisjunctQueryStructure dsj : cq.getDisjuncts()) {
					if (dsj.getSelectionConds().size() + dsj.getJoinCondsForEquivalenceClasses().size() +
							dsj.getJoinCondsAllOther().size() + dsj.getStringSelectionConds().size()
							+ isNullConds.size() + inconds.size() == 0)
						continue;
					Map<String, Object> ret = getForwardPassJoinandSelectionConstraints(cvc, queryBlock, dsj, sqTable,
							joinTables,
							dsj.getSelectionConds(), dsj.getJoinCondsForEquivalenceClasses(),
							dsj.getJoinCondsAllOther(), dsj.getStringSelectionConds(), inconds, isNullConds,
							false, indList, cnt, isExist);
					tempconstr += (String) ret.get("constr");
					isCorrCondPresent = isCorrCondPresent || (Boolean) ret.get("isCorrCondPresent");
					correlationConds.addAll((Vector<Node>) ret.get("correlationConds"));
				}
				constr += tempconstr;
				// constr += "\n\t(and " + tempconstr + ")\n" ;
			}
		}
		if (cqs == null || (Conds.size() == 0 && stringSelectionConds.size() == 0)) {
			returnValues.put("constr", constr);
			returnValues.put("isCorrCondPresent", isCorrCondPresent);
			returnValues.put("correlationConds", correlationConds);
			return returnValues;
		}

		Conds.removeAll(cvc.correlationHashMap.keySet());
		Conds.removeAll(isNullConds);

		// Vector<Node> selConds = cqs.getSelectionConds();
		// Vector<Node> joinConds = cqs.getJoinCondsForEquivalenceClasses();
		// Vector<Node> otherConds = cqs.getJoinCondsAllOther();
		// Vector<Node> stringSelectionConds = cqs.getStringSelectionConds();

		// HashMap<Node, String> condToSolvedStrinHashMap = new HashMap<Node, String>();

		if (!cvc.getTypeOfMutation().equalsIgnoreCase("DATASET TO KILL SET OPERATOR MUTATIONS ")
				&& cvc.getCurrentMutant() != null && cvc.getCurrentMutant().getIsExpired() == false) {
			if (cvc.getCurrentMutant() != null && cvc.getCurrentMutant().getQueryBlock().getLevel() == level) {
				Conds = GenConstraints.HandleSelectionMutations(Conds, cvc.getCurrentMutant());
				Conds = GenConstraints.HandleNonEquiJoinMutations(Conds, cvc.getCurrentMutant());
			}

		}

		// Adding global correlation conditions to this set
		HashMap<Node, correlationStructure> temp = new HashMap<Node, correlationStructure>();

		for (Node n : cvc.correlationHashMap.keySet()) {
			if (n.getType() == null)
				continue;
			if (Conds.contains(n)) {
				Conds.remove(n);
			}

			if (n.isCorrelated == true && n.getExpired() == false) {
				correlationStructure cs = cvc.correlationHashMap.get(n);
				if (cs != null && cs.getProcessLevel() == level
						&& cs.isAggr == true
						&& cs.isPushedDown == true) {
					Node newn = n.clone();
					newn.isCorrelated = false;
					Conds.add(newn);
					// cvc.correlationHashMap.remove(n);
					// updateNodeandCorrelatedConditionifAggregate(cvc, n, sqTable, level);
				} else {
					temp.put(n, cs);
					Conds.add(n);
				}
			} else
				Conds.add(n);
		}
		cvc.correlationHashMap.putAll(temp);

		// Conds.addAll(cvc.correlationHashMap.keySet());

		for (Node n : Conds) {
			// For non-correlated valid conditions
			if (n != null && n.isCorrelated == false && n.getExpired() == false) {
				// if (bit == 0) {
				transformNodeWithNewTable(cvc, n.getLeft());
				transformNodeWithNewTable(cvc, n.getRight());
				selectionAndJoinConds.add(n);
				String leftIndex = "i1";
				String rightIndex = "j1";
				// if (n.getLeft() != null && n.getLeft().getType() == Node.getColRefType())
				// leftIndex = n.getLeft().getTable() == null ? n.getLeft().getTableAlias() +
				// "_i"
				// : n.getLeft().getTable().getTableName() + "_i";
				// if (n.getRight() != null && n.getRight().getType() == Node.getColRefType())
				// // rightIndex = n.getRight().getTableAlias() + "_i";
				// rightIndex = n.getRight().getTable() == null ? n.getRight().getTableAlias() +
				// "_i"
				// : n.getRight().getTable().getTableName() + "_i";
				String leftTablename = "", leftColumnname = "", rightColumnname = "", rightTableName = "";
				if (n.getLeft() != null && n.getLeft().getType().equals(Node.getColRefType())) {
					leftTablename = n.getLeft().getTable() == null ? n.getLeft().getTableAlias()
							: n.getLeft().getTable().getTableName();
					leftColumnname = n.getLeft().getColumn().getColumnName();
				}
				// chaitra left node is expression then treat as colref for predicate
				Node tempExprNode = null;
				if (n.getLeft() != null && n.getLeft().getType().equalsIgnoreCase(Node.getBaoNodeType())) {
					Node leftNode = n.getLeft();
					for (int e = 0; e < leftNode.expDetails.size(); e++) {
						if (leftNode.expDetails.get(e).getExpNode() == leftNode) {
							tempExprNode = leftNode.expDetails.get(e).getExpNode();
							leftTablename = leftNode.expDetails.get(e).getExpTable().getTableName();
							leftColumnname = leftNode.expDetails.get(e).getExpNode().getColumn().getColumnName();
							break;
						}
					}
				}
				if (tempExprNode != null)
					tempExprNode.setType(Node.getColRefType());
				// chaitra left node is expression then treat as colref for predicate

				// chaitra changed here for date : if extract is used in left node, get table
				// name for that
				if (n.getLeft() != null && n.getLeft().getType().equalsIgnoreCase(Node.getExtractFuncType())) {
					Node leftNode = n.getLeft().getLeft();
					leftTablename = leftNode.getTable() == null ? leftNode.getTableAlias()
							: leftNode.getTable().getTableName();
					leftColumnname = leftNode.getColumn().getColumnName();
				}

				if (n.getRight() != null && n.getRight().getType() == Node.getColRefType()) {
					rightTableName = n.getRight().getTable() == null ? n.getRight().getTableAlias()
							: n.getRight().getTable().getTableName();
					rightColumnname = n.getRight().getColumn().getColumnName();

				}
				// rightIndex = n.getRight().getTableAlias() + "_i";

				int li = joinTables.indexOf(leftTablename);
				int ri = joinTables.indexOf(rightTableName);

				leftIndex = li != -1 ? indList.get(li) + "" : "";
				rightIndex = ri != -1 ? indList.get(ri) + "" : "";

				String s1 = constrGen.genPositiveCondsForPredF(cvc, queryBlock, n.getLeft(), leftIndex);
				String s2 = constrGen.genPositiveCondsForPredF(cvc, queryBlock, n.getRight(), rightIndex);

				if (tempExprNode != null)
					tempExprNode.setType(Node.getBaoNodeType());

				// get non null constraints
				String nonConstr = constrGen.getAssertNotNullCondition(cvc, n.getLeft(), leftIndex);
				nonConstr += constrGen.getAssertNotNullCondition(cvc, n.getRight(), rightIndex);

				String op = "";
				String tempConstr = "";
				// if (s1 != null && s2 != null && s1.contains("select") &&
				// s2.contains("select")) {
				// chaitra changed here - get user defined comparison for date also - not just
				// column
				if (s1 != null && s2 != null
						&& (s1.contains("select") || s1.contains("mk-date") || s1.contains("mk-time"))
						&& (s2.contains("select") || s2.contains("mk-date") || s2.contains("mk-time"))) {
					op = constrGen.getUserDefinedComparisionOperator(n.getOperator(), n.getLeft().getColumn(),
							s1, s2);
					tempConstr += "\t\t" + ((n.isNegated) ? "(not " : " ") + op + ((n.isNegated) ? " )" : " ")
							+ "\n";

				} else {
					tempConstr += "\t\t" + ((n.isNegated) ? "(not " : " ") + "("
							+ (n.getOperator().equals("/=") ? "not (= " : n.getOperator()) + "  " + s1
							+ "  " + s2 + (n.getOperator().equals("/=") ? " ) )" : " " + ")")
							+ ((n.isNegated) ? " )" : " ") + "\n";
				}
				// constr += "(and " + tempConstr + nonConstr + ")\n\n"; // with non-null
				// constr += andOr?"(and ":"(or " + tempConstr + ")\n\n"; // without non-null

				if (leftTablename.equalsIgnoreCase(rightTableName)
						&& leftColumnname.equalsIgnoreCase(rightColumnname)
						&& leftIndex.equalsIgnoreCase(rightIndex) && n.isNegated) {
					constr += "";
				} else {
					if ((tempConstr + nonConstr) != "")
						constr += "(and " + tempConstr + nonConstr + ")"; // with non-null
				}
				// constr += tempConstr ; // without non-null

			}
			// For correlated valid conditions
			else if (n.getExpired() == false && cnt == 0) {
				correlationStructure cs = cvc.correlationHashMap.get(n);
				if (cs != null && cs.getProcessLevel() < level) {
					isCorrCondPresent = true;
					// update the table name and column in node from below level JSQ
					updateTableAndColumnOfCorrelatedConditionWithAboveLevel(cvc, queryBlock, n, sqTable, level, false);
				}
			} else if (n.isSubSelect) {
				correlationStructure cs = cvc.correlationHashMap.get(n);
				if (cs != null && cs.getProcessLevel() < level) {
					isCorrCondPresent = true;
					// update the table name and column in node from below level JSQ
					updateTableAndColumnOfCorrelatedConditionWithAboveLevel(cvc, queryBlock, n, sqTable, level, false);
				}
			}
		}

		for (Node nCond : isNullConds) {
			String leftIndex = "i1";
			// String rightIndex = "j1";
			// if (globalCorrConds.getLeft() != null
			// && (globalCorrConds.getLeft().getType() == Node.getColRefType()
			// || globalCorrConds.getRight().getType() == Node.getAggrNodeType()))
			// leftIndex = globalCorrConds.getLeft().getTable().getTableName() + "_i";
			// if (globalCorrConds.getRight() != null
			// && (globalCorrConds.getRight().getType() == Node.getColRefType()
			// || globalCorrConds.getRight().getType() == Node.getAggrNodeType()))
			// rightIndex = globalCorrConds.getRight().getTable().getTableName() + "_i";
			if (nCond.getLeft() != null
					&& (nCond.getLeft().getType().equals(Node.getColRefType())
							|| nCond.getRight().getType().equals(Node.getAggrNodeType())))
				leftIndex = nCond.getLeft().getTable().getTableName();
			// if (nCond.getRight() != null
			// && (nCond.getRight().getType() == Node.getColRefType()
			// || nCond.getRight().getType() == Node.getAggrNodeType()))
			// rightIndex = nCond.getRight().getTable().getTableName() ;

			int li = joinTables.indexOf(leftIndex);
			// int ri = joinTables.indexOf(rightIndex);

			leftIndex = li != -1 ? indList.get(li) + "" : "";
			// rightIndex = ri != -1 ? indList.get(ri)+"" : "";

			String nonConstr = constrGen.getAssertNotNullCondition(cvc, nCond.getLeft(), leftIndex);

			if (nCond.getNodeType().equalsIgnoreCase(nCond.getIsNullNodeType())
					&& nCond.getOperator().equalsIgnoreCase("=")) {
				nonConstr = "(not " + nonConstr + ")";
			}

			constr += nonConstr;
			// nonConstr += constrGen.getAssertNotNullCondition(cvc, nCond.getRight(),
			// leftIndex);

		}

		// Looking at global correlation map and process correlation if is to be
		// processed at current level
		for (Node globalCorrConds : cvc.correlationHashMap.keySet()) {
			if (globalCorrConds.getLeft() == null && globalCorrConds.getRight() == null)
				continue;
			correlationStructure cs = cvc.correlationHashMap.get(globalCorrConds);
			if (cs.getProcessLevel() == level && globalCorrConds.isCorrelated == true) {
				isCorrCondPresent = true;
				String tempConstr = "";
				correlationConds.add(globalCorrConds);
				String leftIndex = "i1";
				String rightIndex = "j1";
				// if (globalCorrConds.getLeft() != null
				// && (globalCorrConds.getLeft().getType() == Node.getColRefType()
				// || globalCorrConds.getRight().getType() == Node.getAggrNodeType()))
				// leftIndex = globalCorrConds.getLeft().getTable().getTableName() + "_i";
				// if (globalCorrConds.getRight() != null
				// && (globalCorrConds.getRight().getType() == Node.getColRefType()
				// || globalCorrConds.getRight().getType() == Node.getAggrNodeType()))
				// rightIndex = globalCorrConds.getRight().getTable().getTableName() + "_i";

				if (globalCorrConds.getLeft() != null
						&& (globalCorrConds.getLeft().getType().equals(Node.getColRefType())
								|| globalCorrConds.getRight().getType().equals(Node.getAggrNodeType())))
					leftIndex = globalCorrConds.getLeft().getTable().getTableName();
				if (globalCorrConds.getRight() != null
						&& (globalCorrConds.getRight().getType().equals(Node.getColRefType())
								|| globalCorrConds.getRight().getType().equals(Node.getAggrNodeType())))
					rightIndex = globalCorrConds.getRight().getTable().getTableName();

				int li = joinTables.indexOf(leftIndex);
				int ri = joinTables.indexOf(rightIndex);

				leftIndex = li != -1 ? indList.get(li) + "" : "";
				rightIndex = ri != -1 ? indList.get(ri) + "" : "";

				String s1 = constrGen.genPositiveCondsForPredF(cvc, queryBlock, globalCorrConds.getLeft(),
						leftIndex);
				String s2 = constrGen.genPositiveCondsForPredF(cvc, queryBlock, globalCorrConds.getRight(),
						rightIndex);

				String nonConstr = constrGen.getAssertNotNullCondition(cvc, globalCorrConds.getLeft(), leftIndex);

				nonConstr += constrGen.getAssertNotNullCondition(cvc, globalCorrConds.getRight(), rightIndex);

				String op = "";

				if (s1.contains("select") && s2.contains("select")) {
					op = constrGen.getUserDefinedComparisionOperator(globalCorrConds.getOperator(),
							globalCorrConds.getLeft().getColumn(),
							s1, s2);
					if (cs.getQueryType().equalsIgnoreCase("EXISTS") || cs.getQueryType().equalsIgnoreCase("FROM")
							|| cs.getQueryType().equalsIgnoreCase("NOT EXISTS"))
						tempConstr += "\t\t"
								+ ((globalCorrConds.getOperator().equals("/=")) || (globalCorrConds.isNegated)
										? "(not "
										: " ")
								+ op
								+ ((globalCorrConds.getOperator().equals("/=")) || (globalCorrConds.isNegated)
										? " )"
										: " ")
								+ "\n";
					// else if (cs.getQueryType().equalsIgnoreCase("NOT EXISTS"))
					// tempConstr += "\t\t(not "
					// + ((globalCorrConds.getOperator().equals("/=")) ||
					// (globalCorrConds.isNegated)
					// ? "(not "
					// : " ")
					// + op
					// + ((globalCorrConds.getOperator().equals("/=")) ||
					// (globalCorrConds.isNegated)
					// ? " ))"
					// : " )")
					// + "\n";

				} else {
					if (cs.getQueryType().equalsIgnoreCase("EXISTS") || cs.getQueryType().equalsIgnoreCase("FROM")
							|| cs.getQueryType().equalsIgnoreCase("NOT EXISTS"))
						tempConstr += "\t\t ("
								+ (globalCorrConds.getOperator().equals("/=") ? "not (= "
										: globalCorrConds.getOperator())
								+ "  " + s1
								+ "  " + s2 + (globalCorrConds.getOperator().equals("/=") ? " ) )" : " " + ")")
								+ "\n";
					// else if (cs.getQueryType().equalsIgnoreCase("NOT EXISTS"))
					// tempConstr += "\t\t(not ("
					// + (globalCorrConds.getOperator().equals("/=") ? "not (= "
					// : globalCorrConds.getOperator())
					// + " " + s1
					// + " " + s2 + (globalCorrConds.getOperator().equals("/=") ? " ) )" : " " +
					// "))")
					// + "\n";
				}
				// constr += "(and " + tempConstr + nonConstr + ")"; // with non-null
				// constr += andOr?"(and ":"(or "+ tempConstr + ")"; // without non-null
				// if (!isExist)
				constr += "(and " + tempConstr + nonConstr + ")"; // with non-null
				// constr += tempConstr; // without non-null

				globalCorrConds.setExpired(true);

				// get forward and backward pass constraints for correlation constraints
			}
		}

		// STRING SELECTION conditions
		// Vector<Node> stringSelectionConds = cqs.getStringSelectionConds();
		Vector<String> stringConstraints = new Vector<String>();
		stringConds.addAll(stringSelectionConds);
		if (!cvc.getTypeOfMutation().equalsIgnoreCase("DATASET TO KILL SET OPERATOR MUTATIONS ")
				&& cvc.getCurrentMutant() != null && cvc.getCurrentMutant().getIsExpired() == false)
			if (cvc.getCurrentMutant() != null && cvc.getCurrentMutant().getQueryBlock().getLevel() == level)
				stringConds = GenConstraints.HandleStringSelectionMutations(stringConds, cvc.getCurrentMutant());

		for (int k = 0; k < stringSelectionConds.size(); k++) {

			if (stringSelectionConds.get(k).isCorrelated == false
					&& stringSelectionConds.get(k).getExpired() == false) {
				stringConstraints.clear();
				String tableName = stringSelectionConds.get(k).getLeft().getTableNameNo().replaceAll("\\d", "")
						.toLowerCase();
				// String index = joinTables.contains(tableName) ? tableName + "_i" : "i1";
				String index = joinTables.contains(tableName) ? tableName : "i1";
				int ind = joinTables.contains(tableName) ? joinTables.indexOf(tableName) : 0;
				index = ind != -1 ? indList.get(ind) + "" : "";

				strConstr = constrGen.genPositiveCondsForPredF(cvc, queryBlock, stringSelectionConds.get(k),
						index);

				// @shalini: Added non-null constraints for string selection conditions
				String nonConstr = constrGen.getAssertNotNullCondition(cvc, stringSelectionConds.get(k).getLeft(),
						index);
				nonConstr += constrGen.getAssertNotNullCondition(cvc, stringSelectionConds.get(k).getRight(), index);

				stringConstraints.add(strConstr);
				strConstr = "";
				Vector<String> solvedStringConstraint = cvc.getStringSolver().solveConstraints(
						stringConstraints, cvc.getResultsetColumns(), cvc.getTableMap(), true);
				// if (solvedStringConstraint.size() > 0)
				// condToSolvedStrinHashMap.put(stringSelectionConds.get(k),
				// solvedStringConstraint.get(0));
				for (String str : solvedStringConstraint) {
					str = str.substring(str.indexOf('(') + 1, str.lastIndexOf(')'));
					strConstr += "\t\t" + str.replace("assert", "") + "\n";
				}
				constr += "(and" + strConstr + nonConstr + ")";
			} else if (stringSelectionConds.get(k).getExpired() == false) {
				correlationStructure cs = cvc.correlationHashMap.get(stringSelectionConds.get(k));
				if (cs.getProcessLevel() == level) {
					correlationConds.add(stringSelectionConds.get(k));
					stringSelectionConds.get(k).setExpired(true);
				} else {
					// update the table name and column in node from below level JSQ
					// This case means attributes need to be passed up
					if (cnt == 0)
						updateTableAndColumnOfCorrelatedConditionWithAboveLevel(cvc, queryBlock,
								stringSelectionConds.get(k),
								sqTable, level, false);
				}
			}

			// }

		}

		for (Node n : inConds) {
			// inConds.add(n);
			// For non-correlated valid conditions
			if (n != null && n.isCorrelated == false && n.getExpired() == false) {

				String leftIndex = "i1";
				String rightIndex = "j1";
				// if (n.getLeft() != null && n.getLeft().getType() == Node.getColRefType())
				// leftIndex = n.getLeft().getTable() == null ? n.getLeft().getTableAlias() +
				// "_i"
				// : n.getLeft().getTable().getTableName() + "_i";

				if (n.getLeft() != null && n.getLeft().getType().equals(Node.getColRefType()))
					leftIndex = n.getLeft().getTable() == null ? n.getLeft().getTableAlias()
							: n.getLeft().getTable().getTableName();

				int li = joinTables.indexOf(leftIndex);
				// int ri = joinTables.indexOf(rightIndex);

				leftIndex = li != -1 ? indList.get(li) + "" : "";
				// rightIndex = indList.get(ri)+"";

				String s1 = constrGen.genPositiveCondsForPredF(cvc, queryBlock, n.getLeft(),
						leftIndex);
				String tempConstr = "";

				// Vector<String> s2 = new Vector<>();
				for (Node i : n.getRight().getComponentNodes()) {
					String s2 = constrGen.genPositiveCondsForPredF(cvc, queryBlock, i,
							rightIndex);

					String tempS = "\t\t" + ((n.isNegated) ? "(not " : " ") + "("
							+ (n.getType().equalsIgnoreCase("NOT IN") ? "not (= " : "=") + " " + s1
							+ " " + s2 + (n.getType().equalsIgnoreCase("NOT IN") ? " ) )" : " " + ")")
							+ ((n.isNegated) ? " )" : " ") + "\n";
					if (!n.getLeft().getColumn().getCvcDatatype().equalsIgnoreCase("int")
							&& !n.getLeft().getColumn().getCvcDatatype().equalsIgnoreCase("real")
							&& !n.getLeft().getColumn().getCvcDatatype().equalsIgnoreCase("time")
							&& !n.getLeft().getColumn().getCvcDatatype().equalsIgnoreCase("date")
							&& !n.getLeft().getColumn().getCvcDatatype().equalsIgnoreCase("timestamp")) {
						Vector<String> instringConstraints = new Vector<String>();
						instringConstraints.add(tempS);
						strConstr = "";
						Vector<String> solvedStringConstraint = cvc.getStringSolver().solveConstraints(
								instringConstraints, cvc.getResultsetColumns(), cvc.getTableMap(), true);

						for (String str : solvedStringConstraint) {
							str = str.substring(str.indexOf('(') + 1, str.lastIndexOf(')'));
							strConstr += "\t\t" + str.replace("assert", "") + "\n";
						}
						tempConstr += strConstr;
					} else {
						tempConstr += tempS;
					}

				}
				// constr += "(and " + tempConstr + nonConstr + ")\n\n"; // with non-null
				constr += "(or " + tempConstr + ")\n\n"; // without non-null

			}
		}

		String constrF = andOr ? "(and \n\t" : "(or "; // without non-null
		constrF += constr + ")\n\n";
		returnValues.put("isCorrCondPresent", isCorrCondPresent);
		if (!constr.equalsIgnoreCase(""))
			returnValues.put("constr", constrF);
		else
			returnValues.put("constr", "");
		returnValues.put("correlationConds", correlationConds);
		returnValues.put(constr, returnValues);

		return returnValues;
		// throw new UnsupportedOperationException("Unimplemented method
		// 'getForwardPassJoinandSelectionConstraints'");
	}

	public static void transformNodeWithNewTable(GenerateCVC1 cvc, Node n) {
		if (n.getType().equalsIgnoreCase(Node.getValType()))
			return;
		if (cvc.aliasMappingToLevelsForWith != null && n != null && cvc.aliasMappingToLevelsForWith
				.containsKey(n.getTableNameNo().toLowerCase().replaceAll("\\d$", ""))) {
			String repSQTableName = cvc.aliasMappingToLevelsForWith
					.get(n.getTableNameNo().toLowerCase().replaceAll("\\d+$", "")).repSQTable;
			int colIndex = n.getTable().getColumnIndex(n.getColumn().toString());

			Table resSQTable = cvc.getTableMap().getSQTableByName(repSQTableName);
			n.setTableNameNo(repSQTableName);
			n.setTableAlias(repSQTableName);
			n.setTable(resSQTable);
			n.setColumn(resSQTable.getColumn(colIndex));

		}

	}

	public static String generateCompleteAntiJoinBackwardMapping(GenerateCVC1 cvc, QueryBlockDetails queryBlock,
			Vector<Node> n, String joinTable, ArrayList<String> jtColumns, Vector<Table> tables,
			int tuplesInJoinTable) {

		ConstraintGenerator cg = new ConstraintGenerator();

		Table it1 = tables.get(0);
		Table it2 = tables.get(1);

		int it1Size = cvc.getNoOfOutputTuples(it1.toString());
		int it2Size = cvc.getNoOfOutputTuples(it2.toString());

		int resultCntIdx = it1.getNoOfColumn() - 1;
		String resultValid = "(> " + ConstraintGenerator.genSelectTest2(cvc, joinTable, resultCntIdx, "i1") + " 0)";

		StringBuilder existsIT1 = new StringBuilder();
		existsIT1.append("\t(or ");

		for (int j = 1; j <= it1Size; j++) {
			StringBuilder caseForT1j = new StringBuilder();
			caseForT1j.append("\n\t\t(and ");

			String t1Valid = "(> " + ConstraintGenerator.genSelectTest(cvc, it1.toString(), it1.getNoOfColumn() - 1, j)
					+ " 0)";
			caseForT1j.append(t1Valid);

			caseForT1j.append("\n\t\t\t(").append(joinTable).append("_map_").append(it1.getTableName()).append(" ")
					.append(j).append(" i1)");

			caseForT1j.append("\n\t\t\t(and ");
			for (int k = 1; k <= it2Size; k++) {
				String t2Valid = "(> "
						+ ConstraintGenerator.genSelectTest(cvc, it2.toString(), it2.getNoOfColumn() - 1, k) + " 0)";
				caseForT1j.append("\n\t\t\t\t(or (not ").append(t2Valid).append(") (or ");

				for (Node node : n) {

					int it1Col = it1.getColumnIndex(node.getLeft().getColumn().getColumnName());
					int it2Col = it2.getColumnIndex(node.getRight().getColumn().getColumnName());

					String leftVal = ConstraintGenerator.genSelectTest(cvc, it1.toString(), it1Col, j).toString();
					String rightVal = ConstraintGenerator.genSelectTest(cvc, it2.toString(), it2Col, k).toString();

					caseForT1j.append("(not (= ").append(leftVal).append(" ").append(rightVal).append(")) ");
				}
				caseForT1j.append("))");
			}
			caseForT1j.append(")");

			caseForT1j.append(")");
			existsIT1.append(caseForT1j);
		}
		existsIT1.append("\n\t)");

		return "(assert (forall ((i1 Int)) \n" +
				"  (=> (and (> i1 0) (<= i1 " + tuplesInJoinTable + ") " + resultValid + ")\n" +
				existsIT1.toString() + "\n  )\n))\n";
	}

	public static String generateConstraintsForCorrelationConditionsBackwardPass(GenerateCVC1 cvc, Vector<Node> n,
			String joinTable, String joinType) {

		Node firstNode = n.get(0);
		int leftLevel = firstNode.getLeft().getLevel() != null ? firstNode.getLeft().getLevel() : 0;
		int rightLevel = firstNode.getRight().getLevel() != null ? firstNode.getRight().getLevel() : 0;

		if (leftLevel < rightLevel) {
			Table resSQTable = cvc.getTableMap().getSQTableByName(joinTable);
			ConstraintGenerator cg = new ConstraintGenerator();

			int numNodes = n.size();
			int[] leftColIndices = new int[numNodes];
			int[] rightColIndices = new int[numNodes];
			Table[] rightTableObjs = new Table[numNodes];
			Node[] n1s = new Node[numNodes];

			for (int k = 0; k < numNodes; k++) {
				Node node = n.get(k);
				String leftTableName = node.getLeft().getTable().toString();
				String leftColName = node.getLeft().getColumn().getColumnName();
				String rightTableName = node.getRight().getTable().toString();
				String rightColName = node.getRight().getColumn().getColumnName();

				int leftColIndex = -1;
				for (int i = 0; i < resSQTable.getColumnIndexList().size(); i++) {
					String columnName = resSQTable.getColumnIndexList().get(i);
					if (columnName.contains(leftColName) && columnName.contains(leftTableName)) {
						leftColIndex = i;
						break;
					}
				}
				leftColIndices[k] = leftColIndex;

				Table rightTableObj;
				if (rightTableName.contains("JSQ") || rightTableName.contains("GSQ")
						|| rightTableName.contains("DSQ")) {
					rightTableObj = cvc.getTableMap().getSQTableByName(rightTableName);
				} else {
					rightTableObj = cvc.getTableMap().getTable(rightTableName);
				}
				rightTableObjs[k] = rightTableObj;
				rightColIndices[k] = rightTableObj.getColumnIndex(rightColName);

				Node n1 = new Node(node);
				n1.getLeft().setColumn(resSQTable.getColumn(leftColIndex));
				n1.getLeft().setTable(resSQTable);
				n1.getLeft().setTableAlias(resSQTable.toString());
				n1.getLeft().setTableNameNo(resSQTable.toString());

				n1.getRight().setColumn(rightTableObj.getColumn(rightColIndices[k]));
				n1.getRight().setTable(rightTableObj);
				n1.getRight().setTableAlias(rightTableObj.toString());
				n1.getRight().setTableNameNo(rightTableObj.toString());
				n1s[k] = n1;
			}

			int rightTableSize = cvc.getNoOfOutputTuples(rightTableObjs[0].toString());
			ArrayList<String> tupleConstraints = new ArrayList<>();

			for (int i = 1; i <= rightTableSize; i++) {
				Table rightTableObj = rightTableObjs[0];
				int rightCntColIndex = rightTableObj.getNoOfColumn() - 1;
				Expr rightCnt = ConstraintGenerator.genSelectTest(cvc, rightTableObj.toString(), rightCntColIndex, i);
				BoolExpr rightCntGtZero = ConstraintGenerator.ctx.mkGt((ArithExpr) rightCnt,
						ConstraintGenerator.ctx.mkInt(0));
				String cntValid = rightCntGtZero.toString();

				StringBuilder tupleBuilder = new StringBuilder();
				if (joinType.equals(JoinClauseInfo.antiJoin)) {
					tupleBuilder.append("\n\t\t(or (not").append(cntValid).append(")");
					tupleBuilder.append(" (or");

					for (int k = 0; k < numNodes; k++) {
						Node node = n.get(k);
						Expr leftSelect = ConstraintGenerator.genSelectTest2(cvc, joinTable, leftColIndices[k], "i1");
						Expr rightSelect = ConstraintGenerator.genSelectTest(cvc, rightTableObjs[k].toString(),
								rightColIndices[k], i);

						String op = cg.getUserDefinedComparisionOperator(node.getOperator(), node.getLeft().getColumn(),
								leftSelect.toString(), rightSelect.toString());
						if (op.equalsIgnoreCase("")) {
							op = "(" + node.getOperator() + " " + leftSelect.toString() + " " + rightSelect.toString()
									+ ")";
						}

						tupleBuilder.append(" (not ").append(op).append(")");
					}
					tupleBuilder.append("))");
				} else {
					tupleBuilder.append("\n\t\t(and ").append(cntValid);

					for (int k = 0; k < numNodes; k++) {
						Node node = n.get(k);
						Node n1 = n1s[k];
						Expr leftSelect = ConstraintGenerator.genSelectTest2(cvc, joinTable, leftColIndices[k], "i1");
						Expr rightSelect = ConstraintGenerator.genSelectTest(cvc, rightTableObjs[k].toString(),
								rightColIndices[k], i);

						String op = cg.getUserDefinedComparisionOperator(node.getOperator(), node.getLeft().getColumn(),
								leftSelect.toString(), rightSelect.toString());
						if (op.equalsIgnoreCase("")) {
							op = "(" + node.getOperator() + " " + leftSelect.toString() + " " + rightSelect.toString()
									+ ")";
						}

						String nonConstr = cg.getAssertNotNullCondition(cvc, n1.getLeft(), "i1");
						nonConstr += cg.getAssertNotNullCondition(cvc, n1.getRight(), Integer.toString(i));

						tupleBuilder.append(" ").append(op).append(nonConstr);
					}
					tupleBuilder.append(")");
				}
				tupleConstraints.add(tupleBuilder.toString());
			}

			StringBuilder result = new StringBuilder();
			result.append("\n\t(or");
			for (String tc : tupleConstraints) {
				result.append(tc);
			}
			result.append(")");
			return result.toString();

		} else {
			Table resSQTable = cvc.getTableMap().getSQTableByName(joinTable);
			ConstraintGenerator cg = new ConstraintGenerator();

			int numNodes = n.size();
			int[] leftColIndices = new int[numNodes];
			int[] rightColIndices = new int[numNodes];
			Table[] leftTableObjs = new Table[numNodes];
			Node[] n1s = new Node[numNodes];

			for (int k = 0; k < numNodes; k++) {
				Node node = n.get(k);
				String leftTableName = node.getLeft().getTable().toString();
				String leftColName = node.getLeft().getColumn().getColumnName();
				String rightTableName = node.getRight().getTable().toString();
				String rightColName = node.getRight().getColumn().getColumnName();

				Table leftTableObj;
				if (leftTableName.contains("JSQ") || leftTableName.contains("GSQ") || leftTableName.contains("DSQ")) {
					leftTableObj = cvc.getTableMap().getSQTableByName(leftTableName);
				} else {
					leftTableObj = cvc.getTableMap().getTable(leftTableName);
				}
				leftTableObjs[k] = leftTableObj;
				int leftColIndex = leftTableObj.getColumnIndex(leftColName);
				leftColIndices[k] = leftColIndex;

				int rightColIndex = -1;
				for (int i = 0; i < resSQTable.getColumnIndexList().size(); i++) {
					String columnName = resSQTable.getColumnIndexList().get(i);
					if (columnName.contains(rightColName) && columnName.contains(rightTableName)) {
						rightColIndex = i;
						break;
					}
				}
				rightColIndices[k] = rightColIndex;

				Node n1 = new Node(node);
				n1.getLeft().setColumn(leftTableObj.getColumn(leftColIndex));
				n1.getLeft().setTable(leftTableObj);
				n1.getLeft().setTableAlias(leftTableObj.toString());
				n1.getLeft().setTableNameNo(leftTableObj.toString());

				n1.getRight().setColumn(resSQTable.getColumn(rightColIndex));
				n1.getRight().setTable(resSQTable);
				n1.getRight().setTableAlias(resSQTable.toString());
				n1.getRight().setTableNameNo(resSQTable.toString());
				n1s[k] = n1;
			}

			int leftTableSize = cvc.getNoOfOutputTuples(leftTableObjs[0].toString());
			ArrayList<String> tupleConstraints = new ArrayList<>();

			for (int i = 1; i <= leftTableSize; i++) {
				Table leftTableObj = leftTableObjs[0];
				int leftCntColIndex = leftTableObj.getNoOfColumn() - 1;
				Expr leftCnt = ConstraintGenerator.genSelectTest(cvc, leftTableObj.toString(), leftCntColIndex, i);
				BoolExpr leftCntGtZero = ConstraintGenerator.ctx.mkGt((ArithExpr) leftCnt,
						ConstraintGenerator.ctx.mkInt(0));
				String cntValid = leftCntGtZero.toString();

				StringBuilder tupleBuilder = new StringBuilder();
				if (joinType.equals(JoinClauseInfo.antiJoin)) {
					tupleBuilder.append("\n\t\t(and ").append(cntValid);
					tupleBuilder.append(" (or");

					for (int k = 0; k < numNodes; k++) {
						Node node = n.get(k);
						Expr leftSelect = ConstraintGenerator.genSelectTest(cvc, leftTableObjs[k].toString(),
								leftColIndices[k], i);
						Expr rightSelect = ConstraintGenerator.genSelectTest2(cvc, joinTable, rightColIndices[k], "i1");

						String op = cg.getUserDefinedComparisionOperator(node.getOperator(), node.getLeft().getColumn(),
								leftSelect.toString(), rightSelect.toString());
						if (op.equalsIgnoreCase("")) {
							op = "(" + node.getOperator() + " " + leftSelect.toString() + " " + rightSelect.toString()
									+ ")";
						}

						tupleBuilder.append(" (not ").append(op).append(")");
					}
					tupleBuilder.append("))");
				} else {
					tupleBuilder.append("\n\t\t(and ").append(cntValid);

					for (int k = 0; k < numNodes; k++) {
						Node node = n.get(k);
						Node n1 = n1s[k];
						Expr leftSelect = ConstraintGenerator.genSelectTest(cvc, leftTableObjs[k].toString(),
								leftColIndices[k], i);
						Expr rightSelect = ConstraintGenerator.genSelectTest2(cvc, joinTable, rightColIndices[k], "i1");

						String op = cg.getUserDefinedComparisionOperator(node.getOperator(), node.getLeft().getColumn(),
								leftSelect.toString(), rightSelect.toString());
						if (op.equalsIgnoreCase("")) {
							op = "(" + node.getOperator() + " " + leftSelect.toString() + " " + rightSelect.toString()
									+ ")";
						}

						String nonConstr = cg.getAssertNotNullCondition(cvc, n1.getLeft(), Integer.toString(i));
						nonConstr += cg.getAssertNotNullCondition(cvc, n1.getRight(), "i1");

						tupleBuilder.append(" ").append(op).append(nonConstr);
					}
					tupleBuilder.append(")");
				}
				tupleConstraints.add(tupleBuilder.toString());
			}

			StringBuilder result = new StringBuilder();
			result.append("\n\t(or");
			for (String tc : tupleConstraints) {
				result.append(tc);
			}
			result.append(")");
			return result.toString();
		}
	}

	private static String generateConstraintsForCorrelationConditionsBackwardPass(GenerateCVC1 cvc, Node n,
			ArrayList<String> jtColumns,
			String joinTable, Vector<Table> tables, String tupleIdLeft, Boolean isLInt, String tupleIdRight,
			Boolean isRInt) {
		String constr = "";
		String left = "";
		String right = "";

		Boolean l_isSQ = false, r_isSQ = false;
		if (n.getLeft().getTableNameNo() != null && !n.getLeft().getTableNameNo().contains("JSQ")
				&& !n.getLeft().getTableNameNo().contains("GSQ") && !n.getLeft().getTableNameNo().contains("DSQ")) {
			left = n.getLeft().getTableNameNo() != null
					? (n.getLeft().getTableNameNo().replaceAll("\\d", "")).toLowerCase()
					: null;
		} else {
			left = n.getLeft().getTableNameNo() != null
					? (n.getLeft().getTableNameNo())
					: null;
			l_isSQ = true;
		}
		if (n.getRight().getTableNameNo() != null && !n.getRight().getTableNameNo().contains("JSQ")
				&& !n.getRight().getTableNameNo().contains("GSQ") && !n.getRight().getTableNameNo().contains("DSQ")) {
			right = n.getRight().getTableNameNo() != null
					? (n.getRight().getTableNameNo().replaceAll("\\d", "")).toLowerCase()
					: null;
		} else {
			right = n.getRight().getTableNameNo() != null
					? (n.getRight().getTableNameNo())
					: null;
			r_isSQ = true;
		}
		int l_index = 0, r_index = 0, l_flag = -1, r_flag = -1;
		// left
		for (Table table : tables) {
			if (table == null)
				continue;
			if (table.getTableName().equals(left)) { // gives col index of t1
				l_index += table.getColumnIndex(n.getLeft().getColumn().getColumnName());
				l_flag = 1;
				break;
			} else
				l_index += table.getNoOfColumn();
		}

		// right
		for (Table table : tables) {
			if (table == null)
				continue;
			if (table.getTableName().equals(right)) // gives col index of t1
			{
				r_index += table.getColumnIndex(n.getRight().getColumn().getColumnName());
				r_flag = 1;
				break;
			} else
				r_index += table.getNoOfColumn();
		}

		for (int i = 0; i < cvc.getTableMap().getSQTableByName(joinTable).getColumnIndexList().size(); i++) {
			String columnName = cvc.getTableMap().getSQTableByName(joinTable).getColumnIndexList().get(i);
			// System.out.println(left.contains("JSQ")?columnName.contains("_" +
			// n.getLeft().getColumn().getColumnName()):columnName.contains(left+"__" +
			// n.getLeft().getColumn().getColumnName()));
			// System.out.println("_" + n.getLeft().getColumn().getColumnName());
			if (n.getLeft() != null && n.getLeft().getColumn() != null
					&& ((left.contains("JSQ") || left.contains("GSQ") || left.contains("DSQ"))
							? columnName.contains("_" + n.getLeft().getColumn().getColumnName())
							: columnName.contains(left + "__" + n.getLeft().getColumn().getColumnName()))) {
				l_index = i;
				l_flag = 1;
			}
			if (n.getRight() != null && n.getRight().getColumn() != null
					&& ((right.contains("JSQ") || right.contains("GSQ") || left.contains("DSQ"))
							? columnName.contains("_" + n.getRight().getColumn().getColumnName())
							: columnName.contains(right + "__" + n.getRight().getColumn().getColumnName()))) {
				r_index = i;
				r_flag = 1;
			}

		}

		String cntValid = "";
		if (l_flag != -1 && !l_isSQ) {
			constr = "( " + jtColumns.get(l_index) + " (select O_" + joinTable + " " + tupleIdLeft + " )) ";
			if (isLInt)
				cntValid += ConstraintGenerator.getConstraintsForValidCountUsingTable(n.getLeft().getTable(),
						n.getLeft().getTable().getTableName(), Integer.parseInt(tupleIdLeft), 0);

		}
		if (r_flag != -1 && !r_isSQ) {
			constr += "( " + jtColumns.get(r_index) + " (select O_" + joinTable + " " + tupleIdRight + " )) ";
			if (isRInt)
				cntValid += ConstraintGenerator.getConstraintsForValidCountUsingTable(n.getRight().getTable(),
						n.getRight().getTable().getTableName(), Integer.parseInt(tupleIdRight), 0);
		}
		if (l_flag != -1 && l_isSQ) {
			constr += "( " + n.getLeft().getColumn().getColumnName() + " (select O_" + n.getLeft().getTableNameNo()
					+ " " + cvc.enumIndexVar + tupleIdLeft + " )) ";
			if (isLInt)
				cntValid += ConstraintGenerator.getConstraintsForValidCountUsingTable(n.getLeft().getTable(),
						n.getLeft().getTable().getTableName(), Integer.parseInt(tupleIdLeft), 0);
		}
		if (r_flag != -1 && r_isSQ) {
			constr += "( " + n.getRight().getColumn().getColumnName() + " (select O_" + n.getRight().getTableNameNo()
					+ " " + cvc.enumIndexVar + tupleIdRight + " )) ";
			if (isRInt)
				cntValid += ConstraintGenerator.getConstraintsForValidCountUsingTable(n.getRight().getTable(),
						n.getRight().getTable().getTableName(), Integer.parseInt(tupleIdRight), 0);
		}
		if (l_flag != -1 && r_flag == -1) {
			constr = "( " + jtColumns.get(l_index) + " (select O_" + joinTable + " " + tupleIdLeft + " )) ";
			constr += getConstantAsSMT(n.getRight());
		}
		if (r_flag != -1 && l_flag == -1) {
			constr = "( " + jtColumns.get(r_index) + " (select O_" + joinTable + " " + tupleIdLeft + " )) ";
			constr += getConstantAsSMT(n.getLeft());
		}

		if (n.getOperator().equals("/="))
			return "\n\t\t(and (not (= " + constr + "))\n\t\t" + cntValid + ")";
		constr = addConstOpColumnConstraints(n, constr);
		String op = "";
		ConstraintGenerator cg = new ConstraintGenerator();
		op = cg.getUserDefinedComparisionOperator(n.getOperator(), n.getLeft().getColumn(), constr, op);
		if (!op.equalsIgnoreCase("")) {
			return "\n\t\t(and " + op + " \n\t\t" + cntValid + ")";

		}

		return "\n\t\t(and (" + n.getOperator() + " " + constr + " )\n\t\t" + cntValid + ")";

	}

	private static String[] splitBalanced(String input) {
		int balance = 0;
		int splitIndex = -1;
		for (int i = 0; i < input.length(); i++) {
			char ch = input.charAt(i);
			if (ch == '(')
				balance++;
			else if (ch == ')')
				balance--;

			if (balance == 0 && i > 0) {
				splitIndex = i + 1;
				break;
			}
		}
		if (splitIndex == -1)
			throw new IllegalArgumentException("Unbalanced expression!");

		String left = input.substring(0, splitIndex).trim();
		String right = input.substring(splitIndex).trim();
		return new String[] { left, right };
	}

	public static double evaluate(String expr) {
		expr = expr.trim();

		// Handle basic binary operators
		if (expr.contains("+")) {
			String[] parts = expr.split("\\+");
			return Double.parseDouble(parts[0].trim()) + Double.parseDouble(parts[1].trim());
		} else if (expr.contains("-")) {
			String[] parts = expr.split("-");
			return Double.parseDouble(parts[0].trim()) - Double.parseDouble(parts[1].trim());
		} else if (expr.contains("*")) {
			String[] parts = expr.split("\\*");
			return Double.parseDouble(parts[0].trim()) * Double.parseDouble(parts[1].trim());
		} else if (expr.contains("/")) {
			String[] parts = expr.split("/");
			return Double.parseDouble(parts[0].trim()) / Double.parseDouble(parts[1].trim());
		} else {
			return Double.parseDouble(expr);
		}
	}

	private static String addConstOpColumnConstraints(Node n, String str) {
		String constraints = "";
		if (n.addVal.equals("-1"))
			return str;
		String[] parts = splitBalanced(str);
		String left = parts[0], right = parts[1];
		char op = n.op.charAt(0);
		char side = n.op.charAt(1);
		if (side == 'R') {
			constraints = left + " ( " + op + " " + evaluate(n.addVal) + " " + right + ")";
		} else {
			constraints = " ( " + op + " " + evaluate(n.addVal) + left + " ) " + right;
		}

		return constraints;
	}

	/**
	 * @author Sunanda
	 * @param cvc
	 * @param n
	 * @param sqTable
	 * @throws CloneNotSupportedException
	 * 
	 */
	public static void updateTableAndColumnOfCorrelatedConditionWithAboveLevel(GenerateCVC1 cvc, QueryBlockDetails qb,
			Node n, Table sqTable,
			int level, Boolean isAggr) throws CloneNotSupportedException {
		correlationStructure cs = cvc.correlationHashMap.get(n);
		int leftLevel = 0, rightLevel = 0;
		String sqTableAliasLeft = null, sqTableAliasRight = null;
		if (cs.isPushedDown) {
			leftLevel = cs.getOriginalLevelLeft();
			rightLevel = cs.getOriginalLevelRight();
		} else if (n.getLeft() != null && n.getLeft().getLevel() != null) {
			leftLevel = n.getLeft().getLevel();
		}
		if (n.getRight() != null && n.getRight().getLevel() != null) {
			rightLevel = n.getRight().getLevel();
		}
		if (n.getLeft() != null && n.getLeft().getTable() != null && n.getLeft().getColumn() != null) {
			String leftTableName = n.getLeft().getTable().getTableName();
			String leftColumnName = n.getLeft().getColumn().getColumnName();

			if (isAggr) {// this aggr is not the same as correlation structure aggr - this means its from
							// aggr part of the code
				if (leftTableName.endsWith(String.valueOf(level)) && leftTableName.startsWith("JSQ")) {
					leftTableName = sqTable.getTableName();
					// String sqTableLeftColumnName = leftTableName
					// + n.getRight().getTable().getColumnIndex(leftColumnName);
					if (n.getRight().getType().equalsIgnoreCase(Node.getAggrNodeType()))
						leftColumnName = ConstraintGenerator.getColumnNameForGSQ(leftTableName,
								n.getLeft().getOrgiColumn().getTableName(), n.getLeft().getAgg().getFunc(),
								n.getLeft().getOrgiColumn().getColumnName());

					else {
						leftColumnName = ConstraintGenerator.getColumnNameForGSQ(leftTableName,
								n.getLeft().getOrgiColumn().getTableName(), "",
								n.getLeft().getOrgiColumn().getColumnName());
					}

					Node newNode = n.clone();
					newNode.getLeft().setColumn(sqTable.getColumn(leftColumnName));
					newNode.getLeft().setTable(sqTable);
					newNode.getLeft().setTableNameNo(sqTable.getTableName());
					newNode.getLeft().setTableAlias(sqTable.getAliasName());

					if (n.getLeft().getType().equalsIgnoreCase(Node.getAggrNodeType())) {
						Node tempNode = n.getLeft().getAgg().getAggExp().clone();
						tempNode.setColumn(sqTable.getColumn(leftColumnName));
						tempNode.setTable(sqTable);
						tempNode.setTableNameNo(sqTable.getTableName());
						tempNode.setTableAlias(sqTable.getAliasName());
						newNode.getLeft().getAgg().setAggExp(tempNode);
					}

					if (newNode != null) {
						cvc.correlationHashMap.remove(n);
						cvc.correlationHashMap.put(newNode, cs);
					}

				}
			} else if (leftLevel == level) {
				String sqTableLeftColumnName = sqTable.getTableName() + "_" + leftTableName + "__" + leftColumnName
						+ n.getLeft().getTable().getColumnIndex(leftColumnName);
				if (leftTableName.contains("JSQ") || leftTableName.contains("GSQ") || leftTableName.contains("DSQ")) {
					sqTableLeftColumnName = sqTable.getTableName() + "_" + leftColumnName
							+ n.getLeft().getTable().getColumnIndex(leftColumnName);
				}

				// cvc.correlationHashMap.remove(n);
				Node newNode = n.clone();
				newNode.getLeft().setColumn(sqTable.getColumn(sqTableLeftColumnName));
				newNode.getLeft().setTable(sqTable);
				newNode.getLeft().setTableNameNo(sqTable.getTableName());
				newNode.getLeft().setTableAlias(sqTable.getAliasName());
				if (!QueryBlockDetails.isAggregationPresentInQuery(qb))
					newNode.getLeft().level = level - 1;

				if (n.getLeft().getType().equalsIgnoreCase(Node.getAggrNodeType())) {
					Node tempNode = n.getLeft().getAgg().getAggExp().clone();
					tempNode.setColumn(sqTable.getColumn(sqTableLeftColumnName));
					tempNode.setTable(sqTable);
					tempNode.setTableNameNo(sqTable.getTableName());
					tempNode.setTableAlias(sqTable.getAliasName());
					newNode.getLeft().getAgg().setAggExp(tempNode);
				}
				if (newNode != null) {
					cvc.correlationHashMap.remove(n);
					cvc.correlationHashMap.put(newNode, cs);
				}
			}
		}

		if (n.getRight() != null && n.getRight().getTable() != null && n.getRight().getColumn() != null) {
			String rightTableName = n.getRight().getTable().getTableName();
			String rightColumnName = n.getRight().getColumn().getColumnName();

			if (isAggr) {
				if (rightTableName.endsWith(String.valueOf(level)) && rightTableName.startsWith("JSQ")) {
					rightTableName = sqTable.getTableName();
					// rightColumnName = rightTableName + "_" +
					// rightColumnName.split("__")[1].replaceAll("\\d", "");

					if (n.getRight().getType().equalsIgnoreCase(Node.getAggrNodeType()))
						rightColumnName = ConstraintGenerator.getColumnNameForGSQ(rightTableName,
								n.getRight().getColumn().getTableName(), n.getRight().getAgg().getFunc(),
								n.getRight().getColumn().getColumnName());

					else {
						rightColumnName = ConstraintGenerator.getColumnNameForGSQ(rightTableName,
								n.getRight().getColumn().getTableName(), "",
								n.getRight().getColumn().getColumnName());
					}
					for (String c : sqTable.getColumns().keySet()) {
						if (c.contains(rightColumnName)) {
							rightColumnName = c;
							break;
						}
					}
					// cvc.correlationHashMap.remove(n);
					Node newNode = n.clone();
					newNode.getRight().setColumn(sqTable.getColumn(rightColumnName));
					newNode.getRight().setTable(sqTable);
					newNode.getRight().setTableNameNo(sqTable.getTableName());
					newNode.getRight().setTableAlias(sqTable.getAliasName());
					newNode.getRight().level = rightLevel;

					if (n.getRight().getType().equalsIgnoreCase(Node.getAggrNodeType())) {
						Node tempNode = n.getRight().getAgg().getAggExp().clone();
						tempNode.setColumn(sqTable.getColumn(rightColumnName));
						tempNode.setTable(sqTable);
						tempNode.setTableNameNo(sqTable.getTableName());
						tempNode.setTableAlias(sqTable.getAliasName());
						newNode.getRight().getAgg().setAggExp(tempNode);
					}

					if (newNode != null) {
						cvc.correlationHashMap.remove(n);
						cvc.correlationHashMap.put(newNode, cs);
					}
				}
			} else if (rightLevel == level) {
				String sqTableRightColumnName = sqTable.getTableName() + "_" + rightTableName + "__" + rightColumnName
						+ n.getRight().getTable().getColumnIndex(rightColumnName);

				if (rightTableName.contains("JSQ") || rightTableName.contains("GSQ")
						|| rightTableName.contains("DSQ")) {
					sqTableRightColumnName = sqTable.getTableName() + "_" + rightColumnName +
							+n.getRight().getTable().getColumnIndex(rightColumnName);
				}
				// Node nn = cvc.correlationHashMap.get(n).getCondition();
				// correlationStructure cs = cvc.correlationHashMap.get(n);

				// cvc.correlationHashMap.remove(n);
				Node newNode = n.clone();
				newNode.getRight().setColumn(sqTable.getColumn(sqTableRightColumnName));
				newNode.getRight().setTable(sqTable);
				newNode.getRight().setTableNameNo(sqTable.getTableName());
				newNode.getRight().setTableAlias(sqTable.getAliasName());
				if (newNode.getRight().getTableAlias() == null)
					newNode.getRight().setTableAlias(sqTable.toString());
				if (!QueryBlockDetails.isAggregationPresentInQuery(qb))
					newNode.getRight().level = level - 1;

				if (n.getRight().getType().equalsIgnoreCase(Node.getAggrNodeType())) {
					Node tempNode = newNode.getRight().getAgg().getAggExp().clone();
					tempNode.setColumn(sqTable.getColumn(sqTableRightColumnName));
					tempNode.setTable(sqTable);
					tempNode.setTableNameNo(sqTable.getTableName());
					tempNode.setTableAlias(sqTable.getAliasName());
					newNode.getRight().getAgg().setAggExp(tempNode);
				}

				if (newNode != null) {
					cvc.correlationHashMap.remove(n);
					cvc.correlationHashMap.put(newNode, cs);
				}
			}
		}

	}

	/**
	 * @author Sunanda
	 *         FIXME
	 */
	private static String getStringConstraintsForSQTableUsingBaseTables(String tempC,
			String solvedCondForThisConInBaseTable) {
		String Var = "";
		// plan to extract solution of string solver from one string and put it in
		// another

		return "";
	}

	/**
	 * Calculates level for now - need to include SQ table iterator info in CVC
	 * 
	 * @author parismita
	 * @param queryBlock
	 * @param fromorwhere
	 * @return
	 * @throws Exception
	 */
	public static int getSQLevel(QueryBlockDetails queryBlock, String fromorwhere) throws Exception {
		ArrayList<QueryBlockDetails> SubQBlocks = queryBlock.getWhereClauseSubQueries();
		if (SubQBlocks == null)
			return 1;
		int level = 1;
		// get max height of the SQ
		for (QueryBlockDetails SubQBlock : SubQBlocks) {
			int levelSQ = getSQLevel(SubQBlock, fromorwhere);
			level = Math.max(level, levelSQ + 1);
		}
		return level;
	}

	public static String getConstraintsForJoinsWithoutCount(GenerateCVC1 cvc, QueryBlockDetails queryBlock, Node n1,
			Node n2, String operator, boolean isExist, String fromorwhere) throws Exception {

		String constraintString = "";

		if (Configuration.getProperty("tempJoins").equalsIgnoreCase("true")) {
			isTempJoin = true;
		} else {
			isTempJoin = false;
		}
		if (!isTempJoin) {
			/** get the details of each node */
			String t1 = getTableName(n1);
			String t2 = getTableName(n2);

			// int pos1 =
			// cvc.getTableMap().getTable(t1).getColumnIndex(getColumn(n1).getColumnName());
			// int pos2 =
			// cvc.getTableMap().getTable(t2).getColumnIndex(getColumn(n2).getColumnName());

			// below two lines added by rambabu
			int pos1 = cvc.getTableMap().getTable(t1.toUpperCase()).getColumnIndex(getColumn(n1).getColumnName());
			int pos2 = cvc.getTableMap().getTable(t2.toUpperCase()).getColumnIndex(getColumn(n2).getColumnName());

			String r1 = getTableNameNo(n1);
			String r2 = getTableNameNo(n2);
			logger.log(Level.INFO, "relation2 name num  ---" + r2);

			int offset1 = cvc.getRepeatedRelNextTuplePos().get(r1)[1];
			int offset2 = cvc.getRepeatedRelNextTuplePos().get(r2)[1];

			/** Get number of tuples of each relation occurrence */
			int tuples1 = 0, tuples2 = 0;
			if (cvc.getNoOfTuples().containsKey(r1)) {

				tuples1 = cvc.getNoOfTuples().get(r1);
			}

			if (cvc.getNoOfTuples().containsKey(r2)) {

				tuples2 = cvc.getNoOfTuples().get(r2);
			}

			int noOfgroups = UtilsRelatedToNode.getNoOfGroupsForThisNode(cvc, queryBlock, n1);

			ConstraintGenerator constrGen = new ConstraintGenerator();
			ArrayList<ConstraintObject> constrObjList = new ArrayList<ConstraintObject>();

			for (int i = 0; i < noOfgroups; i++) {
				/** Do a round robin for the smaller value */
				for (int k = 1, l = 1;; k++, l++) {

					// constraintString += "ASSERT ("+
					// GenerateCVCConstraintForNode.genPositiveCondsForPred(queryBlock, n1,
					// ((i*tuples1)+k+offset1-1))+ operator +
					// GenerateCVCConstraintForNode.genPositiveCondsForPred(queryBlock, n2,
					// ((i*tuples2)+l+offset2-1))+");\n";
					/*
					 * ConstraintObject constrObj = new ConstraintObject();
					 * constrObj.setLeftConstraint(constrGen.genPositiveCondsForPred(queryBlock, n1,
					 * ((i*tuples1)+k+offset1-1)));
					 * constrObj.setRightConstraint(constrGen.genPositiveCondsForPred(queryBlock,
					 * n2, ((i*tuples2)+l+offset2-1)));
					 * constrObj.setOperator(operator);
					 * constrObjList.add(constrObj);
					 */

					constraintString += constrGen.getAssertConstraint(
							constrGen.genPositiveCondsForPred(queryBlock, n1, ((i * tuples1) + k + offset1 - 1)),
							operator,
							constrGen.genPositiveCondsForPred(queryBlock, n2, ((i * tuples2) + l + offset2 - 1)));

					if (tuples1 > tuples2) {
						if (l == tuples2 && k < tuples1)
							l = 0;
						if (k >= tuples1)
							break;
					} else if (tuples1 < tuples2) {
						if (l < tuples2 && k == tuples1)
							k = 0;
						if (l >= tuples2)
							break;
					} else {// if tuples1==tuples2
						if (l == tuples1)
							break;
					}
				}

			}
		} else if (isTempJoin) {
			Vector<Table> tables = new Vector<Table>();
			Vector<String> joinTables = new Vector<String>();
			int level = getSQLevel(queryBlock, fromorwhere);
			// need to check which SQ condition it is in its level

			for (String baseRelations : queryBlock.getBaseRelations()) {
				Table cvcTable = cvc.getTableMap().getTable(baseRelations.replaceAll("\\d", "").toUpperCase());
				if (!tables.contains(cvcTable)) {
					tables.add(cvcTable);
					joinTables.add(cvcTable.getTableName());
				}
			}

			if (Configuration.getProperty("tempJoins").equalsIgnoreCase("true") &&
					checkIfTablesArePartOfSubQuery(cvc, joinTables, queryBlock.getLevel(), fromorwhere)) {
				// Join Temp table implementation

				String joinTable;
				ConstraintGenerator constrGen = new ConstraintGenerator();
				joinTable = "SQ" + String.valueOf(level);
				// joinTable = "SQ"+ String.valueOf(cvc.tempJoinDefine.size()+1);
				// test code added by deekshat
				// to pass join tables

				if (fromorwhere.equalsIgnoreCase("from")) {
					ArrayList<String> s = new ArrayList<String>();
					s.addAll(0, joinTables);

					cvc.subqueryConstraintsMap.get("from").SQTableName.put(joinTable, s);
					cvc.subqueryConstraintsMap.get("from").SQjoinWithEXISTS.put(joinTable, true);
				} else {
					ArrayList<String> s = new ArrayList<String>();
					s.addAll(0, joinTables);
					String temp = "where_" + queryBlock.getLevel();
					cvc.subqueryConstraintsMap.get(temp).SQTableName.put(joinTable, s);
					cvc.subqueryConstraintsMap.get(temp).SQjoinWithEXISTS.put(joinTable, isExist);
				}
				// added by deeksha
				// if SQi table is not added, break
				if (tablesAdded.contains(joinTable)) {
					return "";
				}
				// testcode by deeksha--------------------------------------------------
				HashMap<String, Object> jtColumnNamesAndDataTypes = createTempTableColumnsForJoins(cvc, queryBlock,
						joinTable,
						tables,
						isExist, fromorwhere, level);
				ArrayList<String> jtColumns = (ArrayList<String>) jtColumnNamesAndDataTypes.get("Names");
				ArrayList<Sort> jtColumnDataTypes = (ArrayList<Sort>) jtColumnNamesAndDataTypes.get("DataTypes");
				cvc.getTableMap().setSQTables((Map<String, Table>) jtColumnNamesAndDataTypes.get("TableMap"));
				Table sqTable = cvc.getTableMap().getSQTableByName(joinTable);

				String tempConstraints = "";

				// context setting
				if (fromorwhere.equalsIgnoreCase("from")) {
					cvc.subqueryConstraintsMap.get("from").SQColumns.put(joinTable, jtColumns);
				} else {
					String temp = "where_" + queryBlock.getLevel();
					cvc.subqueryConstraintsMap.get(temp).SQColumns.put(joinTable, jtColumns);
				}
				// int noOfAttr = cvc.tempJoinColumns.get(tempjoinTable).size();

				Expr aex = ConstraintGenerator.putTableInCtx(cvc,
						jtColumns.toArray(new String[jtColumns.size()]),
						jtColumnDataTypes.toArray(new Sort[jtColumnDataTypes.size()]),
						joinTable);

				for (String statement : ConstraintGenerator.declareRelation(aex)) {
					if (statement.contains(joinTable))
						tempConstraints += statement;
				}

				// System.out.printldn(declareRelation(aex));
				// step 2 : sq1 and sq2 functions for matching join relation with original

				int joincol = 0;
				for (int i = 0; i < tables.size(); i++) {
					String fun = ("define-fun " + joinTable + "_map_" + joinTables.get(i)
							+ "((x!0 Int) (x!1 Int)) Bool\n");

					tempConstraints += "\n(" + fun + "(and \n";
					int col1 = 0;
					while (col1 < tables.get(i).getColumns().size()) {
						Expr left = ConstraintGenerator.genSelectTest2(cvc, joinTables.get(i), col1, "x!0");
						Expr right = ConstraintGenerator.genSelectTest2(cvc, joinTable, joincol, "x!1");

						Expr eq = ConstraintGenerator.ctx.mkEq(left, right);
						tempConstraints += eq.toString() + "\n";
						col1++;
						joincol++;

					}
					tempConstraints += ")\n)\n";
				}

				constraintString += tempConstraints;

				// selection and join conditions from subquery :POOJA
				String constr = "";
				String strConstr = "";
				HashMap<Node, String> CondToSolvedStringCondition = new HashMap<Node, String>();
				Vector<Node> selectionAndJoinConds = new Vector<Node>();
				Vector<Node> stringConds = new Vector<Node>();
				Vector<Node> correlationConds = new Vector<Node>();

				for (ConjunctQueryStructure cqs : queryBlock.getConjunctsQs()) {

					// SELECTION and JOIN conditions
					Vector<Node> selConds = cqs.getSelectionConds();
					Vector<Node> joinConds = cqs.getJoinCondsForEquivalenceClasses();
					Vector<Node> Conds = new Vector<Node>();
					Conds.addAll(selConds);
					Conds.addAll(joinConds);

					// Changes by sunanda for alias hashmap
					// for (Node n: Conds){
					// if(n.getLeft() != null && n.getLeft().getTable() != null)
					// cvc.aliasMappingToLevels.put(n.getLeft().getTable().getTableName(), );
					// if(n.getRight() != null && n.getRight().getTable() != null)
					// cvc.aliasMappingToLevels.get(n.getRight().getTable().getTableName()).add(n.getRight().getTableAlias());
					// }

					for (Node n : Conds) {
						// int bit = isCorrelated(n, cvc, sqTable, tables, fromorwhere, level);
						if (n.isCorrelated == false) {
							// if (bit == 0) {
							selectionAndJoinConds.add(n);

							String leftIndex = "i1";
							String rightIndex = "j1";
							if (n.getLeft() != null && n.getLeft().getType() == Node.getColRefType())
								leftIndex = n.getLeft().getTable().getTableName() + "_i";
							if (n.getRight() != null && n.getRight().getType() == Node.getColRefType())
								rightIndex = n.getRight().getTable().getTableName() + "_i";
							String s1 = constrGen.genPositiveCondsForPredF(cvc, queryBlock, n.getLeft(), leftIndex);
							String s2 = constrGen.genPositiveCondsForPredF(cvc, queryBlock, n.getRight(), rightIndex);
							constr += "\t\t (" + (operator.equals("/=") ? "not (= " : operator) + "  " + s1 + "  " + s2
									+ (operator.equals("/=") ? " ) )" : " " + ")") + "\n";
						} else {
							// if (bit == 2) {
							// n.getLeft().setAliasName(sqTable.getAliasName());
							// n.getLeft().setTable(sqTable);
							// n.getLeft().setTableAlias(sqTable.getAliasName());
							// n.getLeft().setTableNameNo(sqTable.getTableName());
							// } else if (bit == 3) {
							// n.getRight().setAliasName(sqTable.getAliasName());
							// n.getRight().setTable(sqTable);
							// n.getRight().setTableAlias(sqTable.getAliasName());
							// n.getRight().setTableNameNo(sqTable.getTableName());// as sq tables already
							// numbered
							// }
							correlationConds.add(n);
						}
					}

					// STRING SELECTION conditions

					Vector<Node> stringSelectionConds = cqs.getStringSelectionConds();
					Vector<String> stringConstraints = new Vector<String>();
					stringConds.addAll(stringSelectionConds);
					for (int k = 0; k < stringSelectionConds.size(); k++) {
						// int bit = isCorrelated(stringSelectionConds.get(k), cvc, sqTable, tables,
						// fromorwhere, level);

						// if (bit == 0) {
						if (stringSelectionConds.get(k).isCorrelated == false) {
							stringConstraints.clear();
							String tableName = stringSelectionConds.get(k).getLeft().getTableNameNo()
									.replaceAll("\\d", "").toLowerCase();
							String index = joinTables.contains(tableName) ? tableName + "_i" : "i1";
							strConstr = constrGen.genPositiveCondsForPredF(cvc, queryBlock, stringSelectionConds.get(k),
									index); // FIXME: passing a temporary offset i.e. the last argument in this function
											// call

							stringConstraints.add(strConstr);
							strConstr = "";
							Vector<String> solvedStringConstraint = cvc.getStringSolver().solveConstraints(
									stringConstraints, cvc.getResultsetColumns(), cvc.getTableMap(), true);
							CondToSolvedStringCondition.put(stringSelectionConds.get(k), solvedStringConstraint.get(1));
							for (String str : solvedStringConstraint) {
								str = str.substring(str.indexOf('(') + 1, str.lastIndexOf(')'));
								strConstr += "\t\t" + str.replace("assert", "") + "\n";
							}
							constr += strConstr;
						} else {
							Node n = stringSelectionConds.get(k);
							n.setIsString(true); // to differenciate string and others
							// if (bit == 2) {
							// n.getLeft().setAliasName(sqTable.getAliasName());
							// n.getLeft().setTable(sqTable);
							// n.getLeft().setTableAlias(sqTable.getAliasName());
							// n.getLeft().setTableNameNo(sqTable.getTableName());
							// } else if (bit == 3) {
							// n.getRight().setAliasName(sqTable.getAliasName());
							// n.getRight().setTable(sqTable);
							// n.getRight().setTableAlias(sqTable.getAliasName());
							// n.getRight().setTableNameNo(sqTable.getTableName());// as sq tables already
							// numbered
							// }
							correlationConds.add(n);
						}

					}
				}
				if (constr != "")
					constr = "(and \n" + constr + "\t\t)";
				String tableIter = "", tableCond = "";
				for (int i = 0; i < tables.size(); i++) {
					tableIter += "(" + joinTables.get(i) + "_i  Int)";
					tableCond += "(" + joinTable + "_map_" + joinTables.get(i) + " " + joinTables.get(i) + "_i "
							+ joinTable + "_i)\n";// (SQ1_pred2 j1 k1)\n
				}
				constraintString += "(assert (forall (" + tableIter + ") \n\t" + (constr != "" ? ("(=> " + constr) : "")
						+ "  ";
				constraintString += "\n \t(exists ((" + joinTable + "_i Int)) ";
				constraintString += "\n\t (and \n" + tableCond + "))\n)\n)" + (constr != "" ? "\n)" : "");
				/*
				 * Note: Parismita: Todo: Convert to API: make function in constraint generator
				 */

				// ********************changes made by
				// sunanda*************************************
				// //parismita - backward pass
				Vector<Integer> tuplesInTable = new Vector<Integer>();
				int tuplesInJoinTable = 1;

				for (String t : joinTables) {
					int noOfTuples = cvc.getNoOfOutputTuples(t);
					tuplesInTable.add(noOfTuples);
					tuplesInJoinTable *= noOfTuples;
				}
				;

				String finalConstraints = "";
				constr = "";
				for (int k = 1; k <= tuplesInJoinTable; k++) {
					tempConstraints = "";
					constr = "\t";
					for (Node n : selectionAndJoinConds) {
						constr += generateConstraintsForSelectionConditions(cvc, n, jtColumns, joinTable, tables, "i1",
								"i1")
								+ "\n\t";
					}
					for (Node n : stringConds) {
						constr += generateConstraintsForStringConditions(cvc, n, jtColumns, joinTable, tables, "i1",
								"i1") + "\n\t";
					}

					for (int index = 0; index < tables.size(); index++) {
						String tempconstrTable1 = "";
						for (int i = 1; i <= tuplesInTable.get(index); i++) {
							tempconstrTable1 += "\t\t(" + joinTable + "_map_" + joinTables.get(index) + " \t"
									+ Integer.toString(i) + "\t" + Integer.toString(k) + ")\n";
						}
						tempConstraints += "\t(or " + tempconstrTable1 + "\n\t)\n ";
					}
					finalConstraints += "(and \n" + constr + "\n" + tempConstraints + "  )\n  ";
				}
				// added by deeksha
				constraintString += "(assert \n (and \n  " + finalConstraints + "\n )\n)";

				// end------------

				ArrayList<String> typeCastedJt = new ArrayList<String>();
				for (Sort s : jtColumnDataTypes) {
					typeCastedJt.add(s.toString());
				}
				SubqueryStructure sqS = new SubqueryStructure();
				sqS.SQDefine.put(joinTable, constraintString);
				sqS.SQColumnsDataTypes.put(joinTable, typeCastedJt);
				sqS.SQColumns.put(joinTable, jtColumns);
				sqS.SQJoinSelectionAndJoinConds.put(joinTable, selectionAndJoinConds);
				sqS.SQJoinCorrelationConds.put(joinTable, correlationConds);

				if (fromorwhere.equalsIgnoreCase("from")) {
					cvc.subqueryConstraintsMap.put("from", sqS);
				} else if (fromorwhere.equalsIgnoreCase("outer")) {
					cvc.subqueryConstraintsMap.put("outer", sqS);
				} else {
					String temp = "where_" + queryBlock.getLevel();
					cvc.subqueryConstraintsMap.put(temp, sqS);
				}
				constraintString = "";
			}
		}
		// constraintString =constrGen.generateANDConstraintsWithAssert(constrObjList);
		return constraintString;
	}

	public static String getConstraintsForJoinsWithoutTemp(GenerateCVC1 cvc, QueryBlockDetails queryBlock, Node n1,
			Node n2, String operator) throws Exception {

		String constraintString = "";

		if (Configuration.getProperty("tempJoins").equalsIgnoreCase("false")) {
			/** get the details of each node */
			String t1 = getTableName(n1);
			String t2 = getTableName(n2);

			// int pos1 =
			// cvc.getTableMap().getTable(t1).getColumnIndex(getColumn(n1).getColumnName());
			// int pos2 =
			// cvc.getTableMap().getTable(t2).getColumnIndex(getColumn(n2).getColumnName());

			// below two lines added by rambabu
			int pos1 = cvc.getTableMap().getTable(t1.toUpperCase()).getColumnIndex(getColumn(n1).getColumnName());
			int pos2 = cvc.getTableMap().getTable(t2.toUpperCase()).getColumnIndex(getColumn(n2).getColumnName());

			String r1 = getTableNameNo(n1);
			String r2 = getTableNameNo(n2);
			logger.log(Level.INFO, "relation2 name num  ---" + r2);

			int offset1 = cvc.getRepeatedRelNextTuplePos().get(r1)[1];
			int offset2 = cvc.getRepeatedRelNextTuplePos().get(r2)[1];

			/** Get number of tuples of each relation occurrence */
			int tuples1 = 0, tuples2 = 0;
			if (cvc.getNoOfTuples().containsKey(r1)) {

				tuples1 = cvc.getNoOfTuples().get(r1);
			}

			if (cvc.getNoOfTuples().containsKey(r2)) {

				tuples2 = cvc.getNoOfTuples().get(r2);
			}

			int noOfgroups = UtilsRelatedToNode.getNoOfGroupsForThisNode(cvc, queryBlock, n1);

			ConstraintGenerator constrGen = new ConstraintGenerator();
			ArrayList<ConstraintObject> constrObjList = new ArrayList<ConstraintObject>();

			for (int i = 0; i < noOfgroups; i++) {
				/** Do a round robin for the smaller value */
				for (int k = 1, l = 1;; k++, l++) {

					// constraintString += "ASSERT ("+
					// GenerateCVCConstraintForNode.genPositiveCondsForPred(queryBlock, n1,
					// ((i*tuples1)+k+offset1-1))+ operator +
					// GenerateCVCConstraintForNode.genPositiveCondsForPred(queryBlock, n2,
					// ((i*tuples2)+l+offset2-1))+");\n";
					/*
					 * ConstraintObject constrObj = new ConstraintObject();
					 * constrObj.setLeftConstraint(constrGen.genPositiveCondsForPred(queryBlock, n1,
					 * ((i*tuples1)+k+offset1-1)));
					 * constrObj.setRightConstraint(constrGen.genPositiveCondsForPred(queryBlock,
					 * n2, ((i*tuples2)+l+offset2-1)));
					 * constrObj.setOperator(operator);
					 * constrObjList.add(constrObj);
					 */

					constraintString += constrGen.getAssertConstraint(
							constrGen.genPositiveCondsForPred(queryBlock, n1, ((i * tuples1) + k + offset1 - 1)),
							operator,
							constrGen.genPositiveCondsForPred(queryBlock, n2, ((i * tuples2) + l + offset2 - 1)));

					if (tuples1 > tuples2) {
						if (l == tuples2 && k < tuples1)
							l = 0;
						if (k >= tuples1)
							break;
					} else if (tuples1 < tuples2) {
						if (l < tuples2 && k == tuples1)
							k = 0;
						if (l >= tuples2)
							break;
					} else {// if tuples1==tuples2
						if (l == tuples1)
							break;
					}
				}

			}
		}
		// constraintString =constrGen.generateANDConstraintsWithAssert(constrObjList);
		return constraintString;
	}

	/**
	 * Updated: parismita
	 * TEMPCODE Rahul Sharma
	 * 
	 * @param cvc
	 * @param f1        : Table 1
	 * @param f2        : Table 2
	 * @param joinTable : Sub Query Table
	 * @return correlation constraints
	 */
	public static String generateConstraintsForCorrelationAttributes(GenerateCVC1 cvc, String joinTable,
			Vector<Node> correlationConds, int level) throws Exception {
		// TODO Auto-generated method stub
		String correlationConstraints = "";
		correlationConstraints += ConstraintGenerator.addCommentLine("CORRELATION CONSTRAINTS FOR SUB QUERY TABLE");
		String temp = "where_" + level;
		if (cvc.subqueryConstraintsMap.get(temp).SQjoinWithEXISTS.isEmpty()
				|| cvc.subqueryConstraintsMap.get(temp).SQjoinWithEXISTS.get(joinTable) == null)// from - not needed
																								// but
			// sanity check
			return "";

		if (cvc.correlationHashMap == null || cvc.correlationHashMap.isEmpty())
			return "";

		ArrayList<String> outerTables = getOuterTables(cvc.getBaseRelation());

		if (cvc.subqueryConstraintsMap.get(temp).SQjoinWithEXISTS.get(joinTable) == false) {
			// Constraints for not exists
			String constrCorrelationConds = "";
			if (!cvc.correlationHashMap.isEmpty() && level == 1) {
				// in case of NOT EXISTS negate correlation conditions so that there is no tuple
				// in subquery Table
				String str = "";
				for (Node n : cvc.correlationHashMap.keySet()) {
					if (cvc.correlationHashMap.get(n).getProcessLevel() == 0 && !n.getExpired()) {
						String t1 = n.getLeft().getTableNameNo();
						String t2 = n.getRight().getTableNameNo();
						String op = n.getOperator();
						// String innerTable,outerTable;
						if (outerTables.contains(t1)) {
							str += genNegativeConstraintsForCorrelationConds(cvc, n, t2, t1, joinTable, op) + "\n";
						} else if (outerTables.contains(t2)) {
							str += genNegativeConstraintsForCorrelationConds(cvc, n, t1, t2, joinTable, op) + "\n";
						}
					}
				}
				// Vector<String> cntColumnNames = new Vector<String>();
				// for (String col : cvc.tempJoinColumns.get(joinTable)) {
				// if (col.split("__")[1].contains("XDATA_CNT")) {
				// cntColumnNames.add(col);
				// }
				// }
				// Expr cntOfSQColumnSQi1 = ConstraintGenerator.genSelectTest2(cvc, joinTable,
				// cvc.tempJoinColumns.get(joinTable).indexOf(cntColumnNames.get(cntColumnNames.size()
				// - 1)),
				// "k1");
				// String cnt = ConstraintGenerator.ctx.mkEq(cntOfSQColumnSQi1,
				// ConstraintGenerator.ctx.mkInt(0))
				// .toString();
				constrCorrelationConds += "\n\t\t" + str + "\n\t\n"; // Sunanda for
																		// correlation:
																		// Changed
																		// forall to
																		// exists for
																		// now, later
																		// will unroll
																		// it
				correlationConstraints += "\n(assert " + constrCorrelationConds + " )\n";
			}

			/**********************************************/

		} else {
			if (!cvc.correlationHashMap.isEmpty() && level == 1) {
				for (Node n : cvc.correlationHashMap.keySet()) {
					String table1 = n.getLeft().getTableNameNo();
					String table2 = n.getRight().getTableNameNo();
					String operator = n.getOperator();
					// String innerTable,outerTable;
					if (outerTables.contains(table1)) {
						correlationConstraints += generateCorrelationConstraints(cvc, n, table2, table1, joinTable,
								operator);
					} else if (outerTables.contains(table2)) {
						correlationConstraints += generateCorrelationConstraints(cvc, n, table1, table2, joinTable,
								operator);
					}
				}
			}
		}
		correlationConstraints += ConstraintGenerator.addCommentLine("CORRELATION CONSTRAINTS FOR SUB QUERY TABLE END");
		return correlationConstraints;
	}

	/**
	 * @author parismita
	 * @param cvc
	 * @param selectionCondition
	 * @param innerTable
	 * @param outerTable
	 * @param joinTable
	 * @param operator
	 * @return
	 */
	public static String genNegativeConstraintsForCorrelationConds(GenerateCVC1 cvc, Node selectionCondition,
			String innerTable, String outerTable, String joinTable, String operator) {
		String constraints = "";
		String sC = selectionCondition.toString();
		innerTable = innerTable.replaceAll("\\d", "").toLowerCase();
		outerTable = outerTable.replaceAll("\\d", "").toLowerCase();
		String correlationAttributeInJoinTable = "";
		String correlationAttributeInOuterTable = "";
		if (selectionCondition.getLeft().getTableNameNo().contains("JSQ")
				|| selectionCondition.getLeft().getTableNameNo().contains("GSQ")
				|| selectionCondition.getLeft().getTableNameNo().contains("DSQ"))
			correlationAttributeInJoinTable = selectionCondition.getLeft().getColumn().getColumnName();
		else
			correlationAttributeInOuterTable = selectionCondition.getLeft().getColumn().getColumnName();
		if (selectionCondition.getRight().getTableNameNo().contains("JSQ")
				|| selectionCondition.getRight().getTableNameNo().contains("GSQ")
				|| selectionCondition.getRight().getTableNameNo().contains("DSQ"))
			correlationAttributeInJoinTable = selectionCondition.getRight().getColumn().getColumnName();
		else
			correlationAttributeInOuterTable = selectionCondition.getRight().getColumn().getColumnName();

		String joinTableIndex = getTableAttributeIndexForJoinTable(cvc, joinTable, innerTable,
				correlationAttributeInJoinTable);
		String outerTableIndex = getTableAttributeIndex(cvc, outerTable, correlationAttributeInOuterTable);
		int numberOfTuplesInOuterTable = cvc.getNoOfOutputTuples(outerTable);
		// sunanda for correlation in not
		int numberOfTuplesInJoinTable = cvc.getNoOfOutputTuples(joinTable);
		String validTupleConstrainst = "(> "
				+ ConstraintGenerator.getConstraintsForValidCount(cvc, outerTable, 1, 0) + " 0)";
		// for (int i = 1; i <= numberOfTuplesInOuterTable; i++) {
		String tempC = "";

		for (int j = 1; j <= numberOfTuplesInJoinTable; j++) {

			Expr cntOfSQColumnSQi1 = ConstraintGenerator.genSelectTest(
					cvc, joinTable, cvc.subqueryConstraintsMap.get("where").SQColumns
							.get(joinTable)
							.indexOf(cvc.subqueryConstraintsMap.get("where").SQColumns.get(joinTable)
									.get(cvc.subqueryConstraintsMap.get("where").SQColumns.get(joinTable).size() - 1)),
					j);
			String cnt = "\n\t\t" + ConstraintGenerator.ctx
					.mkEq((ArithExpr) cntOfSQColumnSQi1, ConstraintGenerator.ctx.mkInt(0)).toString();

			tempC += "\n\t(and \n\t\t(not(" + operator + " ("
					+ correlationAttributeInJoinTable + " (select O_" + joinTable + " " + cvc.enumIndexVar + j + " )) ("
					+ outerTable + "_"
					+ correlationAttributeInOuterTable + outerTableIndex + " (select O_" + outerTable + " "
					+ cvc.enumIndexVar + "1 "
					+ ")) ))\n\t"
					+ validTupleConstrainst + "\n\t" + cnt + "\n\t)\n\t";

		}
		constraints = "(or \n\t" + tempC + " )";
		// replace 1 with i

		// }

		return constraints;
	}

	// public static boolean isCorrelated(Node selectionCondition, GenerateCVC1 cvc)
	// {
	// if(selectionCondition.getRight().getColumn()!=null) {
	// String operator = selectionCondition.getOperator();
	// ArrayList<String> tablesInSelectionConditions =
	// getListOfTablesInSelectionConditions(selectionCondition.toString(),operator);
	// ArrayList<String> innerTables =
	// cvc.getqStructure().getWhereClauseSubqueries().get(0).getLstRelationInstances();
	// ArrayList<String> outerTables = getOuterTables(cvc.getBaseRelation());
	// if(innerTables.contains(tablesInSelectionConditions.get(0)) &&
	// outerTables.contains(tablesInSelectionConditions.get(1))) {
	// return true;
	// }
	// else if(innerTables.contains(tablesInSelectionConditions.get(1)) &&
	// outerTables.contains(tablesInSelectionConditions.get(0))){
	// return true;
	// }
	// }
	// return false;
	// }

	// changed/added by sunanda
	// /**
	// * @author parismita
	// * @param selectionCondition
	// * @param cvc
	// * @param sqTable
	// * @param subqueryType
	// * @return
	// */
	// public static Integer isCorrelated(Node selectionCondition, GenerateCVC1 cvc,
	// Table sqTable, Vector<Table> tables,
	// String subqueryType, int level) {
	// if (selectionCondition.getRight() != null &&
	// selectionCondition.getRight().getColumn() != null
	// && selectionCondition.getLeft() != null &&
	// selectionCondition.getLeft().getColumn() != null) {
	// Node left = selectionCondition.getLeft();
	// Node right = selectionCondition.getRight();

	// if (subqueryType.equalsIgnoreCase("from")) // cant have correlation
	// return 0;

	// else if (subqueryType.equalsIgnoreCase("outer")) // cant have crrelation
	// return 0;

	// else if (!(left.getType().equalsIgnoreCase(Node.getColRefType()))
	// || !(right.getType().equalsIgnoreCase(Node.getColRefType())))
	// return 0;

	// // if right or left has current table but not equal
	// // else
	// //
	// if(left.getTable()!=null&&right.getTable()!=null&&((left.getTable().getTableName().equalsIgnoreCase(sqTable.getTableName()))
	// //
	// ||(right.getTable().getTableName().equalsIgnoreCase(sqTable.getTableName())))
	// //
	// &&!left.getTable().getTableName().equalsIgnoreCase(right.getTable().getTableName())
	// // ) return 1;

	// // either of left right equal, both not same but not both then correlation
	// else {
	// Boolean l = true, r = true;
	// String rightTableName = right.getTableNameNo();
	// String leftTableName = left.getTableNameNo();
	// if (left.getTable() != null)
	// leftTableName = left.getTable().getTableName();
	// if (right.getTable() != null)
	// rightTableName = right.getTable().getTableName();

	// for (Table t : tables) {
	// if(t.getTableName().equalsIgnoreCase(leftTableName) && (left.getTableAlias()
	// == null || (cvc.aliasMappingToLevels.get(left.getTableAlias().toLowerCase())
	// == level)))
	// l = false;
	// if(t.getTableName().equalsIgnoreCase(rightTableName) &&
	// (right.getTableAlias() == null ||
	// (cvc.aliasMappingToLevels.get(right.getTableAlias().toLowerCase()) ==
	// level)))
	// r = false;
	// // if (((t.getTableName().equalsIgnoreCase(leftTableName)
	// // && (t.getAliasName() == null || left.getTableAlias() == null
	// // || (t.getAliasName().equalsIgnoreCase(left.getTableAlias()) &&
	// cvc.aliasMappingToLevels.get(t.getAliasName()) != level )))
	// // || (t.getTableName().equalsIgnoreCase(rightTableName)
	// // && (t.getAliasName() == null || right.getTableAlias() == null
	// // || (t.getAliasName().equalsIgnoreCase(right.getTableAlias()) &&
	// cvc.aliasMappingToLevels.get(t.getAliasName()) != level ))))
	// // && (!leftTableName.equalsIgnoreCase(rightTableName)
	// // || !(left.getTableAlias() != null && right.getTableAlias() != null
	// // && left.getTableAlias().equalsIgnoreCase(right.getTableAlias()) &&
	// cvc.aliasMappingToLevels.get(left.getAliasName()) != level &&
	// cvc.aliasMappingToLevels.get(right.getAliasName()) != level))) {
	// // l = l || t.getTableName().equalsIgnoreCase(leftTableName) // left equal
	// // || (t.getAliasName() != null && left.getTableAlias() != null
	// // && t.getAliasName().equalsIgnoreCase(left.getTableAlias()) &&
	// cvc.aliasMappingToLevels.get(t.getAliasName()) != level);
	// // r = r || t.getTableName().equalsIgnoreCase(rightTableName)
	// // || (t.getAliasName() != null && right.getTableAlias() != null
	// // && t.getAliasName().equalsIgnoreCase(right.getTableAlias()) &&
	// cvc.aliasMappingToLevels.get(t.getAliasName()) != level);
	// // }

	// }
	// if (!l && !r)
	// return 0;

	// if (l && r){
	// selectionCondition.isCorrelated = true;
	// return 1;
	// }

	// if (l){
	// selectionCondition.isCorrelated = true;
	// return 2;
	// }

	// if (r){
	// selectionCondition.isCorrelated = true;
	// return 3;
	// }
	// return 0;

	// }

	// }
	// return 0;
	// }

	private static String getTableAttributeIndex(GenerateCVC1 cvc, String table, String attribute) {
		// TODO Auto-generated method stub
		Vector<String> columnIndices = cvc.getTableMap().getTable(table.toUpperCase()).getColumnIndexList();
		return columnIndices.indexOf(attribute) + "";
	}

	private static String getTableAttributeIndexForJoinTable(GenerateCVC1 cvc, String joinTable, String innerTable,
			String attribute) {
		// TODO Auto-generated method stub

		// added comment by we cannot rename directly to sqtable1 because of following
		// code
		// String[] tblList = joinTable.split("join");

		int index = 0;
		// try {
		// for(int i=0; i<tblList.length; i++) {
		// String tbl = tblList[i];
		// Vector<String> columnIndices =
		// cvc.getTableMap().getTable(tbl.toUpperCase()).getColumnIndexList();
		// if(tbl.equals(innerTable)) {
		// index += columnIndices.indexOf(attribute);
		// break;
		// }
		// else
		// index += cvc.getTableMap().getTable(tbl.toUpperCase()).getNoOfColumn();
		// }
		// }
		// try {
		// // for (int i = 0; i < cvc.tempJoinTableName.get(joinTable).size(); i++) {
		// // String tbl = cvc.tempJoinTableName.get(joinTable).get(i);
		// // if (tbl.equals(innerTable)) {
		// // index =
		// cvc.getTableMap().getTable(tbl.toUpperCase()).getColumnIndex(attribute);
		// // break;
		// // } else
		// // index += cvc.getTableMap().getTable(tbl.toUpperCase()).getNoOfColumn();
		// // }
		// } catch (Exception e) {
		// System.out.println(e);
		// }
		return "" + cvc.getTableMap().getSQTableByName(joinTable).getColumnIndex(attribute);

	}

	// parismita
	// FIXME: Sunanda Nov 11
	private static String generateCorrelationConstraints(GenerateCVC1 cvc, Node selectionCondition, String innerTable,
			String outerTable, String joinTable, String operator) {
		// TODO Auto-generated method stub
		String constraints = "";
		if (selectionCondition == null)
			return "";
		String sC = selectionCondition.toString();
		innerTable = innerTable.replaceAll("\\d", "").toLowerCase();
		outerTable = outerTable.replaceAll("\\d", "").toLowerCase();

		String correlationAttributeInJoinTable = "";
		String correlationAttributeInOuterTable = "";
		if (selectionCondition.getLeft().getTableNameNo().contains("JSQ")
				|| selectionCondition.getLeft().getTableNameNo().contains("GSQ")
				|| selectionCondition.getLeft().getTableNameNo().contains("DSQ"))
			correlationAttributeInJoinTable = selectionCondition.getLeft().getColumn().getColumnName();
		else
			correlationAttributeInOuterTable = selectionCondition.getLeft().getColumn().getColumnName();
		if (selectionCondition.getRight().getTableNameNo().contains("JSQ")
				|| selectionCondition.getRight().getTableNameNo().contains("GSQ")
				|| selectionCondition.getRight().getTableNameNo().contains("DSQ"))
			correlationAttributeInJoinTable = selectionCondition.getRight().getColumn().getColumnName();
		else
			correlationAttributeInOuterTable = selectionCondition.getRight().getColumn().getColumnName();

		String correlationAttribute = sC.substring(sC.indexOf(".") + 1, sC.indexOf(operator));
		// String joinTableIndex = getTableAttributeIndexForJoinTable(cvc, joinTable,
		// innerTable, correlationAttribute);
		// String outerTableIndex = getTableAttributeIndex(cvc, outerTable,
		// correlationAttribute);
		String joinTableIndex = getTableAttributeIndexForJoinTable(cvc, joinTable, innerTable,
				correlationAttributeInJoinTable);
		String outerTableIndex = getTableAttributeIndex(cvc, outerTable, correlationAttributeInOuterTable);
		// int numberOfTuplesInOuterTable = cvc.getNoOfOutputTuples(outerTable);
		// // sunanda for correlation in not
		// int numberOfTuplesInJoinTable = cvc.getNoOfOutputTuples(joinTable);
		int tuplesInJoinTable = 1, tuplesInOuterTable = cvc.getNoOfOutputTuples(outerTable);
		// parismita
		Vector<String> joinTables = new Vector<String>();
		Vector<Table> tables = new Vector<Table>();
		Vector<Integer> tuplesInTable = new Vector<Integer>();

		if (cvc.subqueryConstraintsMap.get("where").SQTableName.get(joinTable) != null)
			for (String t : cvc.subqueryConstraintsMap.get("where").SQTableName.get(joinTable)) {
				joinTables.add(t.toLowerCase());
				tables.add(cvc.getTableMap().getTable(t.toUpperCase()));
				int noOfTuples = cvc.getNoOfOutputTuples(t);
				tuplesInTable.add(noOfTuples);
				tuplesInJoinTable *= noOfTuples;
			}
		;
		// testcode by deeksha
		// kasture---------------------------------------------------------
		String tempConstraints = "";

		Expr cntOfOuter = ConstraintGenerator.genSelectTest(cvc, outerTable,
				cvc.getTableMap().getTable(outerTable.toUpperCase()).getNoOfColumn() - 1, 1);
		// String validTupleConstrainst = "(> "
		// + ConstraintGenerator.getConstraintsForValidCount(cvc, outerTable, 1, 0) + "
		// 0)";
		// cnt += "\n\t\t"
		// + ConstraintGenerator.ctx.mkGt((ArithExpr) cntOfOuter,
		// ConstraintGenerator.ctx.mkInt(0)).toString();

		int numberOfTuplesInOuterTable = cvc.getNoOfOutputTuples(outerTable);
		int numberOfTuplesInJoinTable = cvc.getNoOfOutputTuples(joinTable);
		// sunanda for correlation in not
		String tempC = "";

		// for (int i = 1; i <= numberOfTuplesInOuterTable; i++) {

		String validTupleConstrainst = "(> "
				+ ConstraintGenerator.getConstraintsForValidCount(cvc, outerTable, 1, 0) + " 0)"; // replace 1 with i
		// for (int j = 1; j <= numberOfTuplesInJoinTable; j++) {

		// Expr cntOfSQColumnSQi1 = ConstraintGenerator.genSelectTest(cvc, joinTable,
		// cvc.tempJoinColumns
		// .get(joinTable)
		// .indexOf(cvc.tempJoinColumns.get(joinTable).get(cvc.tempJoinColumns.get(joinTable).size()
		// - 1)), j);
		// String cnt = "\n\t\t" + ConstraintGenerator.ctx
		// .mkEq((ArithExpr) cntOfSQColumnSQi1,
		// ConstraintGenerator.ctx.mkInt(0)).toString();

		// tempC += "\n\t(and \n\t\t(not(" + operator + " ("
		// + correlationAttributeInJoinTable + " (select O_" + joinTable + " " + j + "
		// )) (" + outerTable + "_"
		// + correlationAttributeInOuterTable + outerTableIndex + " (select O_" +
		// outerTable + " 1 "
		// + ")) ))\n\t"
		// + validTupleConstrainst + "\n\t" + cnt + "\n\t)\n\t";

		// }

		for (int j = 1; j <= numberOfTuplesInJoinTable; j++) {
			Expr cntOfSQColumnSQi1 = ConstraintGenerator.genSelectTest(
					cvc, joinTable, cvc.subqueryConstraintsMap.get("where").SQColumns
							.get(joinTable)
							.indexOf(cvc.subqueryConstraintsMap.get("where").SQColumns.get(joinTable)
									.get(cvc.subqueryConstraintsMap.get("where").SQColumns.get(joinTable).size() - 1)),
					j);
			String cnt = "\n\t\t" + ConstraintGenerator.ctx
					.mkGt((ArithExpr) cntOfSQColumnSQi1, ConstraintGenerator.ctx.mkInt(0)).toString();

			String temp = "";
			if (operator.equals("/="))
				temp += "\n\t\t" + "(not " + ConstraintGenerator.genEquiCondTest(cvc, joinTable,
						Integer.parseInt(joinTableIndex), j, outerTable, Integer.parseInt(outerTableIndex), 1) // replace
																												// 1
																												// with
																												// i
						+ "\n)";
			else
				temp += "\n\t\t" + ConstraintGenerator.genEquiCondTest(cvc, joinTable,
						Integer.parseInt(joinTableIndex), j, outerTable, Integer.parseInt(outerTableIndex), 1) // replace
																												// 1
																												// with
																												// i
						+ "\n";
			tempC += "(and " + temp + "\n\t" + validTupleConstrainst + "\n\t" + cnt + ")";
			// }

			// constraints += "\n\t(and \n\t\t(not("+operator+" ("+
			// joinTable+"_"+innerTable+"__"+correlationAttribute+joinTableIndex+" (select
			// O_"+joinTable+" k1)) ("+outerTable+"_"+correlationAttribute+outerTableIndex+"
			// (select O_"+outerTable+" " + i +")) ))\n\t" + validTupleConstrainst +
			// "\n\t)\n\t";
		}
		tempConstraints = "(assert \n\t(or \n\t\t" + tempC + "\n\t) \n)";
		return tempConstraints;
		//
		// end--------------

	}

	private static ArrayList<String> getOuterTables(HashMap<String, String> baseRelation) {
		// TODO Auto-generated method stub
		Iterator<Entry<String, String>> it = baseRelation.entrySet().iterator();
		ArrayList<String> tables = new ArrayList<String>();
		while (it.hasNext()) {
			Map.Entry<String, String> temp = (Map.Entry<String, String>) it.next();
			tables.add(temp.getValue());
		}
		return tables;
	}

	private static ArrayList<String> getListOfTablesInSelectionConditions(String selectionCondition, String operator) {
		// TODO Auto-generated method stub
		StringTokenizer st = new StringTokenizer(selectionCondition, operator);
		String table1 = st.nextToken();
		String table2 = st.nextToken();
		table1 = table1.substring(1, table1.indexOf('.'));
		table2 = table2.substring(0, table2.indexOf('.'));
		ArrayList<String> tables = new ArrayList<String>();
		tables.add(table1);
		tables.add(table2);
		return tables;
	}

	public static String getTableName(Node n1) {
		if (n1.getColumn() != null)
			return n1.getColumn().getTableName();
		else if (n1.getLeft().getColumn() != null)
			return n1.getLeft().getColumn().getTableName();
		else
			return n1.getLeft().getColumn().getTableName();
	}

	public static String getTableNameNo(Node n1) {
		if (n1.getTableNameNo() != null)
			return n1.getTableNameNo();
		else if (n1.getLeft().getTableNameNo() != null)
			return n1.getLeft().getTableNameNo();
		else
			return n1.getLeft().getTableNameNo();
	}

	public static Column getColumn(Node n1) {
		if (n1.getColumn() != null)
			return n1.getColumn();
		else if (n1.getLeft().getColumn() != null)
			return n1.getLeft().getColumn();
		else
			return n1.getLeft().getColumn();
	}

	/**
	 * @author - parismita
	 * @param cvc
	 * @param queryBlock
	 * @param n1
	 * @param n2
	 * @param operator
	 * @return
	 */
	public static String getConstraintsForJoinsInSameQueryBlock2(GenerateCVC1 cvc, QueryBlockDetails queryBlock,
			Node n1, Node n2, String operator) {
		// block2 for old code - no need now
		String r1 = n1.getTableNameNo();
		String r2 = n2.getTableNameNo();
		int offset1 = cvc.getRepeatedRelNextTuplePos().get(r1)[1];
		int offset2 = cvc.getRepeatedRelNextTuplePos().get(r2)[1];

		/** Get number of tuples of each relation occurrence */
		int tuples1 = 0, tuples2 = 0;
		if (cvc.getNoOfTuples().containsKey(r1)) {

			tuples1 = cvc.getNoOfTuples().get(r1) * UtilsRelatedToNode.getNoOfGroupsForThisNode(cvc, queryBlock, n1);
		}

		if (cvc.getNoOfTuples().containsKey(r2)) {

			tuples2 = cvc.getNoOfTuples().get(r2) * UtilsRelatedToNode.getNoOfGroupsForThisNode(cvc, queryBlock, n2);
		}

		int noOfgroups = UtilsRelatedToNode.getNoOfGroupsForThisNode(cvc, queryBlock, n1);
		ConstraintGenerator constrGen = new ConstraintGenerator();
		ArrayList<ConstraintObject> constrObjList = new ArrayList<ConstraintObject>();

		for (int i = 0; i < noOfgroups; i++) {
			/** Do a round robin for the smaller value */
			for (int k = 1, l = 1;; k++, l++) {

				// constraintString += "("+
				// GenerateCVCConstraintForNode.genPositiveCondsForPred(queryBlock, n1,
				// ((i*tuples1)+k+offset1-1))+ operator +
				// GenerateCVCConstraintForNode.genPositiveCondsForPred(queryBlock, n2,
				// ((i*tuples2)+l+offset2-1))+") AND ";
				ConstraintObject constrObj = new ConstraintObject();
				constrObj.setLeftConstraint(
						constrGen.genPositiveCondsForPred(queryBlock, n1, ((i * tuples1) + k + offset1 - 1)));
				constrObj.setRightConstraint(
						constrGen.genPositiveCondsForPred(queryBlock, n2, ((i * tuples2) + l + offset2 - 1)));
				constrObj.setOperator(operator);
				constrObjList.add(constrObj);

				if (tuples1 > tuples2) {
					if (l == tuples2 && k < tuples1)
						l = 0;
					if (k >= tuples1)
						break;
				} else if (tuples1 < tuples2) {
					if (l < tuples2 && k == tuples1)
						k = 0;
					if (l >= tuples2)
						break;
				} else {/** if tuples1==tuples2 */
					if (l == tuples1)
						break;
				}
			}
		}
		return constrGen.generateANDConstraintsWithAssert(constrObjList);
	}

	/**
	 * Gets constraints for nodes which are involved in join conditions which are in
	 * same query block
	 * 
	 * @param cvc
	 * @param queryBlock
	 * @param n1
	 * @param n2
	 * @param string
	 * @return
	 */
	public static String getConstraintsForJoinsInSameQueryBlock1(GenerateCVC1 cvc, QueryBlockDetails queryBlock,
			Node n1, Node n2, String operator) {

		String constraintString = "";

		/** get the details of each node */
		String t1 = n1.getColumn().getTableName();
		String t2 = n2.getColumn().getTableName();
		// int pos1 =
		// cvc.getTableMap().getTable(t1).getColumnIndex(n1.getColumn().getColumnName());
		// int pos2 =
		// cvc.getTableMap().getTable(t2).getColumnIndex(n2.getColumn().getColumnName());

		int pos1 = cvc.getTableMap().getTable(t1.toUpperCase()).getColumnIndex(n1.getColumn().getColumnName()); // added
																												// by
																												// rambabu
		int pos2 = cvc.getTableMap().getTable(t2.toUpperCase()).getColumnIndex(n2.getColumn().getColumnName()); // added
																												// by
																												// rambabu

		if (Configuration.getProperty("tempJoins").equalsIgnoreCase("true")) {
			isTempJoin = true;
		} else {
			isTempJoin = false;
		}

		if (!isTempJoin) {
			String r1 = n1.getTableNameNo();
			String r2 = n2.getTableNameNo();
			int offset1 = cvc.getRepeatedRelNextTuplePos().get(r1)[1];
			int offset2 = cvc.getRepeatedRelNextTuplePos().get(r2)[1];

			/** Get number of tuples of each relation occurrence */
			int tuples1 = 0, tuples2 = 0;
			if (cvc.getNoOfTuples().containsKey(r1)) {

				tuples1 = cvc.getNoOfTuples().get(r1)
						* UtilsRelatedToNode.getNoOfGroupsForThisNode(cvc, queryBlock, n1);
			}

			if (cvc.getNoOfTuples().containsKey(r2)) {

				tuples2 = cvc.getNoOfTuples().get(r2)
						* UtilsRelatedToNode.getNoOfGroupsForThisNode(cvc, queryBlock, n2);
			}

			int noOfgroups = UtilsRelatedToNode.getNoOfGroupsForThisNode(cvc, queryBlock, n1);
			ConstraintGenerator constrGen = new ConstraintGenerator();
			ArrayList<ConstraintObject> constrObjList = new ArrayList<ConstraintObject>();

			for (int i = 0; i < noOfgroups; i++) {
				/** Do a round robin for the smaller value */
				for (int k = 1, l = 1;; k++, l++) {

					// constraintString += "("+
					// GenerateCVCConstraintForNode.genPositiveCondsForPred(queryBlock, n1,
					// ((i*tuples1)+k+offset1-1))+ operator +
					// GenerateCVCConstraintForNode.genPositiveCondsForPred(queryBlock, n2,
					// ((i*tuples2)+l+offset2-1))+") AND ";
					ConstraintObject constrObj = new ConstraintObject();
					constrObj.setLeftConstraint(
							constrGen.genPositiveCondsForPred(queryBlock, n1, ((i * tuples1) + k + offset1 - 1)));
					constrObj.setRightConstraint(
							constrGen.genPositiveCondsForPred(queryBlock, n2, ((i * tuples2) + l + offset2 - 1)));
					constrObj.setOperator(operator);
					constrObjList.add(constrObj);

					if (tuples1 > tuples2) {
						if (l == tuples2 && k < tuples1)
							l = 0;
						if (k >= tuples1)
							break;
					} else if (tuples1 < tuples2) {
						if (l < tuples2 && k == tuples1)
							k = 0;
						if (l >= tuples2)
							break;
					} else {/** if tuples1==tuples2 */
						if (l == tuples1)
							break;
					}
				}
			}
			constraintString = constrGen.generateANDConstraintsWithAssert(constrObjList);
		} else if (isTempJoin) {
			// Join Temp table implementation
			Vector<String> tablesAdded = new Vector<String>();
			Table f1, f2;
			String temp1, temp2, joinTable, ColName;
			int t1Columnindex, t2Columnindex;
			int findex = 0;
			f1 = n1.getTable();
			f2 = n2.getTable();
			temp1 = f1.getTableName();
			temp2 = f2.getTableName();
			// TEMPCODE Rahul Sharma : Check if the tables are part of nested query, if so
			// proceed further to generate sub query table constraints, otherwise break
			boolean isPartOfSubQuery = checkIfTablesArePartOfSubQuery(cvc, temp1, temp2, queryBlock.getLevel(), "");

			if (isPartOfSubQuery) {

				joinTable = temp1 + "join" + temp2;
				// added by deeksha
				// joinTable = "SQtable1";
				if (!tablesAdded.contains(joinTable)) {
					// constraintString += "\n (declare-datatypes () (("+joinTable +"_TupleType" +
					// "("+joinTable +"_TupleType ";
					// TEMPCODE START : Rahul Sharma
					// handled incorrect parenthesis
					constraintString = "(declare-datatypes ((" + joinTable + "_TupleType 0))" + "(((" + joinTable
							+ "_TupleType ";
					// TEMPCODE END : Rahul Sharma

					for (String key : f1.getColumns().keySet()) {
						ColName = f1.getColumns().get(key).getColumnName();
						String s = f1.getColumns().get(key).getCvcDatatype();
						if (s != null && (s.equalsIgnoreCase("Int") || s.equalsIgnoreCase("Real") || s.equals("TIME")
								|| s.equals("DATE") || s.equals("TIMESTAMP")))
							constraintString += "(" + joinTable + "_" + f1.getColumns().get(key) + findex + " " + s
									+ ") ";
						else
							constraintString += "(" + joinTable + "_" + f1.getColumns().get(key) + findex + " "
									+ ColName + ") ";
						findex++;
					}
					int delimit = findex;
					for (String key : f2.getColumns().keySet()) {
						ColName = f2.getColumns().get(key).getColumnName();
						String s = f2.getColumns().get(key).getCvcDatatype();
						if (s != null && (s.equalsIgnoreCase("Int") || s.equalsIgnoreCase("Real") || s.equals("TIME")
								|| s.equals("DATE") || s.equals("TIMESTAMP")))
							constraintString += "(" + joinTable + "_" + f2.getColumns().get(key) + findex + " " + s
									+ ") ";
						else
							constraintString += "(" + joinTable + "_" + f2.getColumns().get(key) + findex + " "
									+ ColName + ") ";
						findex++;
					}
					constraintString += ") )) )\n";
					// Now create the Array for this TupleType
					constraintString += "(declare-fun O_" + joinTable + " () (Array Int " + joinTable
							+ "_TupleType))\n\n";

					t1Columnindex = n1.getColumn().getTable().getColumnIndex(n1.getColumn().getColumnName());
					t2Columnindex = n2.getColumn().getTable().getColumnIndex(n2.getColumn().getColumnName());

					ConstraintGenerator constrGen = new ConstraintGenerator();

					String constraint1 = constrGen.genPositiveCondsForPredF(cvc, queryBlock, n1, "i1");
					String constraint2 = constrGen.genPositiveCondsForPredF(cvc, queryBlock, n2, "j1");

					constraintString += "(assert (forall ((i1 Int)(j1 Int))(=> ("
							+ (operator.equals("/=") ? "not (= " : operator) + "  " + constraint1 + "  " + constraint2
							+ (operator.equals("/=") ? " )" : " " + ") \n");
					// constraintString += "(forall ((i1 Int)(j1 Int))(=> ("+
					// (operator.equals("/=")? "not (= ": operator) +" "+constraint1+ "
					// "+constraint2+ (operator.equals("/=")? " )":" "+ ") \n");

					// String constraint3 =
					// "("+joinTable+"_"+n1.getColumn().getColumnName()+t1Columnindex;
					// constraint3 += "("+" select O_"+joinTable+" "+" k1 ) )";

					// constraintString += "(exists ((k1 Int)) (and (" + (operator.equals("/=")?
					// "not (= ": operator) +" "+constraint1+ " "+constraint3+
					// (operator.equals("/=")? " )":" "+ ") \n"); // TEMPCODE Rahul Sharma :
					// Commented
					constraintString += "(exists ((k1 Int)) ";

					t2Columnindex += delimit;
					// String constraint4 =
					// "("+joinTable+"_"+n2.getColumn().getColumnName()+t2Columnindex;
					// constraint4 += "("+" select O_"+joinTable+" "+" k1 ) )";
					//
					// constraintString += " (" + (operator.equals("/=")? "not (= ": operator) +"
					// "+constraint2+ " "+constraint4+ (operator.equals("/=")? " )":" "+ ")))))
					// )\n");

					// TEMPCODE START : Rahul Sharma
					ArrayList<String> jt = new ArrayList<String>();
					jt = createTempTableColumns(joinTable, f1, f2).get("Names");
					constraintString += generateConstraintsForAllAttributes(f1, f2, jt, joinTable) + ") ) ) )";
					// System.out.println(constraintString);
					// TEMPCODE END : Rahul Sharma

					// TEMPCODE START : Rahul Sharma
					// commented these lines, [FIXME: this constraints leads to infinite loops]
					// constraintString += "(assert (forall ((k1 Int)) (exists ((i1 Int)(j1 Int))
					// (and (" + (operator.equals("/=")? "not (= ": operator) +" "+constraint1+ "
					// "+constraint3+ (operator.equals("/=")? " )":" " + " )\n");

					// constraintString += "(assert (forall ((k1 Int)) (=> (and (<= 0 k1) (<= k1
					// 10))"
					// + "(exists ((i1 Int)(j1 Int)) (and (and (<= 0 i1) (<= i1 10)) (and (<= 0 j1)
					// (<= j1 10)) "
					// + " (" + (operator.equals("/=")? "not (= ": operator) +" "+constraint1+ "
					// "+constraint3+ (operator.equals("/=")? " )":" " + " ))\n");

					// constraintString += "("+ (operator.equals("/=")? "not (= ": operator) +"
					// "+constraint2+ " "+constraint4+ (operator.equals("/=")? " )":" " +
					// ")))))\n");
					constraintString += generateConstraintsForAllAndExistsAttributes(cvc, n1, n2, f1, f2, jt, joinTable,
							1,
							new Vector<Node>());
					// TEMPCODE END : Rahul Sharma
				}
			} else {
				// TEST CODE: Pooja

				String r1 = n1.getTableNameNo();
				String r2 = n2.getTableNameNo();
				int offset1 = cvc.getRepeatedRelNextTuplePos().get(r1)[1];
				int offset2 = cvc.getRepeatedRelNextTuplePos().get(r2)[1];

				/** Get number of tuples of each relation occurrence */
				int tuples1 = 0, tuples2 = 0;
				if (cvc.getNoOfTuples().containsKey(r1)) {

					tuples1 = cvc.getNoOfTuples().get(r1)
							* UtilsRelatedToNode.getNoOfGroupsForThisNode(cvc, queryBlock, n1);
				}

				if (cvc.getNoOfTuples().containsKey(r2)) {

					tuples2 = cvc.getNoOfTuples().get(r2)
							* UtilsRelatedToNode.getNoOfGroupsForThisNode(cvc, queryBlock, n2);
				}

				int noOfgroups = UtilsRelatedToNode.getNoOfGroupsForThisNode(cvc, queryBlock, n1);
				ConstraintGenerator constrGen = new ConstraintGenerator();
				ArrayList<ConstraintObject> constrObjList = new ArrayList<ConstraintObject>();

				for (int i = 0; i < noOfgroups; i++) {
					/** Do a round robin for the smaller value */
					for (int k = 1, l = 1;; k++, l++) {

						// constraintString += "("+
						// GenerateCVCConstraintForNode.genPositiveCondsForPred(queryBlock, n1,
						// ((i*tuples1)+k+offset1-1))+ operator +
						// GenerateCVCConstraintForNode.genPositiveCondsForPred(queryBlock, n2,
						// ((i*tuples2)+l+offset2-1))+") AND ";
						ConstraintObject constrObj = new ConstraintObject();

						constrObj.setLeftConstraint(
								constrGen.genPositiveCondsForPred(queryBlock, n1, ((i * tuples1) + k + offset1 - 1)));
						constrObj.setRightConstraint(
								constrGen.genPositiveCondsForPred(queryBlock, n2, ((i * tuples2) + l + offset2 - 1)));
						constrObj.setOperator(operator);
						constrObjList.add(constrObj);
						int i1 = (i * tuples1) + k + offset1 - 1;
						Column cntCol1 = n1.getTable().getColumn(n1.getTable().getNoOfColumn() - 1); // added by sunanda
																										// for count
						// BoolExpr WithCount1 =
						// ConstraintGenerator.ctx.mkGt((ArithExpr)ConstraintGenerator.smtMap(cntCol1,
						// ConstraintGenerator.ctx.mkInt(i1)), ConstraintGenerator.ctx.mkInt(0)); //
						// added by sunanda for count

						constrObj = new ConstraintObject();
						EnumSort currentSort = (EnumSort) ConstraintGenerator.ctxSorts.get(cvc.enumArrayIndex);

						if (Configuration.isEnumInt.equalsIgnoreCase("true")) {
							constrObj.setLeftConstraint(
									ConstraintGenerator
											.smtMap(cntCol1,
													ConstraintGenerator.ctx.mkConst(cvc.enumIndexVar + i1, currentSort))
											.toString());
						} else {
							constrObj.setLeftConstraint(
									ConstraintGenerator.smtMap(cntCol1, ConstraintGenerator.ctx.mkInt(i1)).toString());
						}

						constrObj.setOperator(">");
						constrObj.setRightConstraint(ConstraintGenerator.ctx.mkInt(0).toString());

						ConstraintObject constrObj1 = new ConstraintObject();
						int i2 = (i * tuples2) + l + offset2 - 1;
						Column cntCol2 = n2.getTable().getColumn(n2.getTable().getNoOfColumn() - 1); // added by sunanda
																										// for count
						if (Configuration.isEnumInt.equalsIgnoreCase("true")) {
							constrObj1.setLeftConstraint(
									ConstraintGenerator
											.smtMap(cntCol2,
													ConstraintGenerator.ctx.mkConst(cvc.enumIndexVar + i2, currentSort))
											.toString());
						} else {
							constrObj1.setLeftConstraint(
									ConstraintGenerator.smtMap(cntCol2, ConstraintGenerator.ctx.mkInt(i2)).toString());
						}

						constrObj1.setOperator(">");
						constrObj1.setRightConstraint(ConstraintGenerator.ctx.mkInt(0).toString());

						if (Configuration.getProperty("cntFlag").equalsIgnoreCase("true")) {
							constrObjList.add(constrObj);
							constrObjList.add(constrObj1);
						}
						// BoolExpr WithCount2 =
						// ConstraintGenerator.ctx.mkGt((ArithExpr)ConstraintGenerator.smtMap(cntCol2,
						// ConstraintGenerator.ctx.mkInt(i1)), ConstraintGenerator.ctx.mkInt(0)); //
						// added by sunanda for count

						if (tuples1 > tuples2) {
							if (l == tuples2 && k < tuples1)
								l = 0;
							if (k >= tuples1)
								break;
						} else if (tuples1 < tuples2) {
							if (l < tuples2 && k == tuples1)
								k = 0;
							if (l >= tuples2)
								break;
						} else {/** if tuples1==tuples2 */
							if (l == tuples1)
								break;
						}
					}
				}
				constraintString = constrGen.generateANDConstraintsWithAssert(constrObjList);

			}

		}
		// Join Temp table implementation end

		return constraintString;
	}

	/**
	 * TEMPCODE Rahul Sharma : To check if the tables are part of sub query - to
	 * generate sub query table constraints
	 * 
	 * @param queryBlock : query structure
	 * @param table1     : table1 name
	 * @param table2     : table2 name
	 * @return true if tables are a part of subquery, false otherwise
	 */
	// changes made by sunanda
	private static boolean checkIfTablesArePartOfSubQuery(GenerateCVC1 cvc, String table1, String table2, int level,
			String subqueryType) {
		// TODO Auto-generated method stub
		Vector<QueryStructure> subqueries = new Vector<QueryStructure>();
		if (subqueryType.equalsIgnoreCase("from"))
			subqueries = cvc.getqStructure().getFromClauseSubqueries();
		else if (subqueryType.equalsIgnoreCase("outer"))
			return true;
		else
			subqueries = cvc.getqStructure().getWhereClauseSubqueries();
		// if(level != 0)
		// subqueries.add(getqStructureByLevel(cvc.getqStructure(), level));

		for (int i = 0; i < subqueries.size(); i++) {
			ArrayList<String> baseRelations = subqueries.get(i).getLstRelations();
			ArrayList<String> relations = new ArrayList<String>();
			for (int j = 0; j < baseRelations.size(); j++) {
				relations.add(baseRelations.get(j).replaceAll("\\d", "").toLowerCase());
				// relations.add(baseRelations.get(j).replaceAll("\\d", "").toUpperCase());
			}
			if (relations.contains(table1) && relations.contains(table2) && !table1.equals(table2))
				return true;
		}
		return false;
	}

	private static QueryStructure getqStructureByLevel(QueryStructure qs, int level) {
		QueryStructure qstruct = qs;
		if (qs.getWhereClauseSubqueries() == null && qs.getFromClauseSubqueries() == null)
			return qs;
		int flag = 0;
		for (int i = 0; i < qs.getWhereClauseSubqueries().size(); i++) {
			qstruct = getqStructureByLevel(qs.getWhereClauseSubqueries().get(i), level);
			if (qstruct != null && qstruct.getLevel() == level) {
				flag = 1;
				break;
			}
		}
		if (flag == 0)
			for (int i = 0; i < qs.getFromClauseSubqueries().size(); i++) {
				qstruct = getqStructureByLevel(qs.getFromClauseSubqueries().get(i), level);
				if (qstruct != null && qstruct.getLevel() == level)
					break;
			}
		return qstruct;
	}

	/**
	 * function overloaded
	 * TEMPCODE Rahul Sharma : To check if the tables are part of sub query - to
	 * generate sub query table constraints
	 * 
	 * @param queryBlock : query structure
	 * @param tables     : table1 name
	 * @author parismita
	 * @return true if any subquery has all the tables, false otherwise
	 */
	// changes made by sunanda
	private static boolean checkIfTablesArePartOfSubQuery(GenerateCVC1 cvc, Vector<String> tables, int level,
			String subqueryType) {

		// if(level == 0)
		// return false;
		QueryStructure subqueries = getqStructureByLevel(cvc.getqStructure(), level);

		ArrayList<String> baseRelations = subqueries.getLstRelations();
		ArrayList<String> relations = new ArrayList<String>();
		for (int j = 0; j < baseRelations.size(); j++) {
			relations.add(baseRelations.get(j).replaceAll("\\d", "").toLowerCase());
		}
		int flag = 0;
		for (String table : tables) {
			if (!relations.contains(table) && !table.startsWith("JSQ") && !table.startsWith("GSQ")
					&& !table.startsWith("DSQ"))
				flag = 1;
		}
		if (flag == 0)
			return true;
		// return true if any subquery has all the tables

		return false;
	}

	/**
	 * TEMPCODE Rahul Sharma : subquery table column names, datatypes and primary
	 * keys
	 * 
	 * @param joinTable
	 * @param t1
	 * @param t2
	 * @author parismita
	 * @return
	 * @throws Exception
	 */
	private static HashMap<String, Object> createTempTableColumnsForJoins(GenerateCVC1 cvc, QueryBlockDetails qb,
			String joinTable,
			Vector<Table> tables,
			boolean isExist, String sqType, int level) throws Exception {
		HashMap<String, Object> columnNameAndDataTypes = new HashMap<String, Object>();
		ArrayList<String> columns = new ArrayList<String>();
		ArrayList<Sort> columnDataTypes = new ArrayList<Sort>();
		ArrayList<String> primaryKey = new ArrayList<String>();
		int count = 0;
		String columnName = "";
		Table sqi = new Table(joinTable);
		Map<String, Table> tableMap = new HashMap<String, Table>();
		int f = 0;
		Vector<Table> removeT = new Vector<Table>();
		Vector<String> countColumnsOfBaseTables = new Vector<String>();

		for (Table t : tables) {
			HashMap<String, Column> t1_columns = t.getColumns();
			Boolean skipPrimaryKey = false;
			if ((t.getTableName().startsWith("JSQ") || t.getTableName().startsWith("GSQ") || t.getTableName().startsWith("HSQ")
					|| t.getTableName().startsWith("DSQ")) && !t.getSQType().equalsIgnoreCase("from")) {
				f = 1;
				// Sunanda for subquery with corr
				HashMap<String, Column> columnsNeedMapping = getRequiredMappingFromSubquery(cvc, t, level);
				if (columnsNeedMapping.size() == 0)
					continue;
				else {
					t1_columns = columnsNeedMapping;
					skipPrimaryKey = true; // FIXME
				}
			}

			for (Column c : t1_columns.values()) {
				if ((t.getTableName().startsWith("JSQ") || t.getTableName().startsWith("GSQ") || t.getTableName().startsWith("HSQ")
						|| t.getTableName().startsWith("DSQ"))) {
					columnName = joinTable + "_" + c.getColumnName()
							+ t.getColumnIndex(c.getColumnName());
				} else {
					columnName = joinTable + (f == 0 ? ("_" + t.getTableName() + "_") : "") + "_" + c.getColumnName()
							+ t.getColumnIndex(c.getColumnName()); // chaitra check this for how columns are created in
																	// jsq
				}
				columnName = columnName.replaceAll("\\d+$", "");
				// + count; // commented by sunanda testtt
				columnName += count;
				columns.add(columnName);

				columnDataTypes.add(ConstraintGenerator.getColumnSort(c.getCvcDatatype()));
				int flag = 0;
				if (t.getPrimaryKey().contains(c) && !skipPrimaryKey) {
					primaryKey.add(columnName);
					flag = 1;
				}
				count++;
				Column col = new Column(c);
				col.setColumnName(columnName);
				col.setTableName(joinTable);
				col.setTable(sqi);
				col.setBaseRelation(t.getTableName());
				sqi.addColumn(col);
				if (flag == 1)
					sqi.addColumnInPrimaryKey(col);

				if (columnName.contains("XDATA_CNT"))
					countColumnsOfBaseTables.add(columnName);
			}
			f = 0;

		}

		// chaitra add expression column
		int expressions = 0;
		ArrayList<Node> projectedNodes = new ArrayList<>();
		projectedNodes = qb.getProjectedCols();

		int pr = 0;
		while (pr < projectedNodes.size()) {
			Node projectedNode = projectedNodes.get(pr);
			boolean isExpRepeated = false;
			for (int e = 1; e <= projectedNode.expDetails.size(); e++) {
				if (projectedNode.expDetails.get(e - 1).getExpNode() == projectedNode) {
					pr++;
					isExpRepeated = true;
				}
			}
			if (isExpRepeated)
				continue;
			if (projectedNode.getType().equalsIgnoreCase("CASE NODE")) {

				projectedNode.expDetails.add(new Node.ExpNodeWithTable(sqi, projectedNode, projectedNode));
				int colId = projectedNode.expDetails.size();

				columns.add(joinTable + "__EXP" + Integer.toString(colId));
				Column col = new Column(joinTable + "__EXP" + Integer.toString(colId), sqi);
				// check data type of column
				String caseNodeValue = projectedNode.getCaseExpression().getWhenConditionals().get(0).getThenNode()
						.getStrConst();
				Column caseNodeCol = projectedNode.getCaseExpression().getWhenConditionals().get(0).getThenNode()
						.getColumn();
				if (caseNodeCol == null) {
					try {
						Integer.parseInt(caseNodeValue);
						columnDataTypes.add(ConstraintGenerator.ctx.getIntSort());
						col.setDataType(java.sql.Types.INTEGER);
						col.setCvcDatatype("INT");
					} catch (NumberFormatException e1) {
						try {
							Double.parseDouble(caseNodeValue);
							columnDataTypes.add(ConstraintGenerator.ctx.getRealSort());
							col.setDataType(java.sql.Types.REAL);
							col.setCvcDatatype("REAL");
						} catch (NumberFormatException e2) {
							columnDataTypes.add(ConstraintGenerator.ctx.getStringSort());
							col.setDataType(java.sql.Types.VARCHAR);
							col.setCvcDatatype("STRING");
						}
					}

				} else { // CHAITRA FIX ME FOR CASE WITH COLUMN VALUES AS OUTPUTS

				}
				// added data type of column
				col.setBaseRelation(joinTable);
				col.isProjected = 1;
				// projectedNode.setColumn(col); // chaitra changed here for projected colllll
				sqi.addColumn(col);
				expressions++;
			} else if (projectedNode.getType().equalsIgnoreCase("BAO NODE")) {
				// getHiddenExpressionsInBaoNode(sqi, cvc,projectedNode, projectedNode);
				if (isPureBaoNode(projectedNode)) {
					projectedNode.expDetails.add(new Node.ExpNodeWithTable(sqi, projectedNode, projectedNode));
					int colId = projectedNode.expDetails.size();

					columns.add(joinTable + "__EXP" + Integer.toString(colId));
					Column col = new Column(joinTable + "__EXP" + Integer.toString(colId), sqi);
					// check data type of column
					columnDataTypes.add(ConstraintGenerator.ctx.getRealSort());
					col.setCvcDatatype("Real");
					col.setDataType(2);
					// added data type of column
					col.setBaseRelation(joinTable);
					col.isProjected = 1;
					// projectedNode.setColumn(col); // chaitra changed here for projected colllll
					sqi.addColumn(col);
					expressions++;
				} else {
					System.out.print("Here");
				}
			}
			// CHECK IF AGGREGATE HAS EXPRESSIONS
			else if (projectedNode.getType().equalsIgnoreCase("AGGREGATE NODE")
					&& !projectedNode.getAgg().getAggExp().getType().equalsIgnoreCase("COLREF")) {

				if (projectedNode.expDetails.size() > 0) {
					pr++;
					continue;
				}

				projectedNode.expDetails
						.add(new Node.ExpNodeWithTable(sqi, projectedNode.getAgg().getAggExp(), projectedNode));
				int colId = projectedNode.expDetails.size();

				columns.add(joinTable + "__EXP" + Integer.toString(colId));
				Column col = new Column(joinTable + "__EXP" + Integer.toString(colId), sqi);
				// check data type of column
				columnDataTypes.add(ConstraintGenerator.ctx.getRealSort());
				col.setCvcDatatype("Real");
				col.setDataType(2);
				// added data type of column
				col.setBaseRelation(joinTable);
				col.isProjected = 1;
				// projectedNode.setColumn(col); // chaitra changed here for projected colllll
				sqi.addColumn(col);
				expressions++;
			}
			pr += 1;
		}
		// chaitra add expression column end

		if (Configuration.getProperty("cntFlag").equalsIgnoreCase("true")) {
			columns.add(joinTable + "__XDATA_CNT");
			columnDataTypes.add(ConstraintGenerator.ctx.getIntSort());
			Column col = new Column(joinTable + "__XDATA_CNT", sqi);
			col.setDataType(4);// INT
			col.setCvcDatatype("INT");
			col.setColumnSize(0);
			sqi.addColumn(col);
			countColumnsOfBaseTables.add(joinTable + "__XDATA_CNT");
		}

		sqi.setSQType(sqType);
		sqi.setIsExist(isExist);
		tableMap.put(joinTable, sqi);
		columnNameAndDataTypes.put("Names", columns);
		columnNameAndDataTypes.put("DataTypes", columnDataTypes);
		columnNameAndDataTypes.put("PrimaryKey", primaryKey);
		columnNameAndDataTypes.put("TableMap", tableMap);
		columnNameAndDataTypes.put("CountColumns", countColumnsOfBaseTables);
		return columnNameAndDataTypes;
	}

	// chaitra get hidden expressions inside BAO NODE only for JSQ
	// for something of the form sum(r.A + 100) * sum(r.B)

	private static void getHiddenExpressionsInBaoNode(Table sqi, GenerateCVC1 cvc, Node projectedNode, Node myBaoNode)
			throws Exception {
		if (myBaoNode == null || myBaoNode.getType().equalsIgnoreCase("COLREF")
				|| myBaoNode.getType().equalsIgnoreCase("VALUE")) {
			return;
		}
		if (myBaoNode.getType().equalsIgnoreCase("AGGREGATE NODE")) {
			Node newAggNode = myBaoNode.clone();
			if (!myBaoNode.getAgg().getAggExp().getType().equalsIgnoreCase("COLREF"))
				projectedNode.expDetails
						.add(new Node.ExpNodeWithTable(sqi, myBaoNode.getAgg().getAggExp(), newAggNode));
			cvc.getqStructure().getProjectedCols().add(newAggNode);
			return;
		}
		getHiddenExpressionsInBaoNode(sqi, cvc, projectedNode, myBaoNode.getLeft());
		getHiddenExpressionsInBaoNode(sqi, cvc, projectedNode, myBaoNode.getRight());
	}

	// chaitra get hidden expressions inside BAO NODE only for JSQ end

	// chaitra check if bao node has only columns and values

	public static boolean isPureBaoNode(Node myBaoNode) throws Exception {
		if (myBaoNode == null)
			return true;
		if (myBaoNode.getType().equalsIgnoreCase("AGGREGATE NODE"))
			return false;
		boolean leftBool = isPureBaoNode(myBaoNode.getLeft());
		boolean rightBool = isPureBaoNode(myBaoNode.getRight());
		return (leftBool & rightBool);
	}

	// chaitra check if bao node has only columns and values END

	/**
	 * This method is used to push tables from above levels in case of correlation
	 * with not exists connective
	 * 
	 * @author Sunanda
	 * @param GenerateCVC1    cvc
	 * @param Vector
	 *                        <Table>
	 *                        table
	 * @param int             level
	 * @param Vector<String>  joinTables
	 * @param Vector<Integer> tuplesInJoin
	 * @return constraints
	 */
	private static void pushTablesFromAboveLevelsForCorrelation(GenerateCVC1 cvc, Vector<Table> table, int level,
			Vector<String> joinTables, Vector<Integer> tuplesInJoin) throws Exception {
		HashMap<Node, correlationStructure> temp = new HashMap<Node, correlationStructure>();
		for (Node n : cvc.correlationHashMap.keySet()) {
			correlationStructure cs = cvc.correlationHashMap.get(n);
			if ((cs.queryType.equalsIgnoreCase("NOT EXISTS") || cs.getIsEquiJoin() == false) && !n.getExpired()) {
				if (cs.isPushedDown && (cs.getPushTableDownLevel() != 0 && cs.getPushTableDownLevel() >= level)) {
					if (n.getLeft() != null && n.getLeft().getLevel() < level) {
						// Left table to be pushed down
						// Will work for single condition
						// Pushed down the entire table
						Table pushedDownTable = (Table) n.getLeft().getTable().clone();
						// pushedDownTable.getColumns().clear();
						Vector<String> columnnames = new Vector<String>(pushedDownTable.getColumns().keySet());

						Vector<Sort> columntypes = new Vector<Sort>();
						for (String col : columnnames) {
							columntypes.add(
									ConstraintGenerator.getColumnSort(pushedDownTable.getColumn(col).getCvcDatatype()));
							// pushedDownTable.getColumns().put(col, ((Table)
							// n.getLeft().getTable()).getColumn(col));
						}

						// pushedDownTable.getColumns().putAll();
						pushedDownTable.setAliasName("pushed_" + pushedDownTable.getTableName() + level);
						for (String colName : pushedDownTable.getColumns().keySet()) {
							pushedDownTable.getColumn(colName).setTable(pushedDownTable);
						}
						Map<String, Table> tablesOfMap = new HashMap<String, Table>();
						tablesOfMap.put("pushed_" + pushedDownTable.getTableName() + level, pushedDownTable);

						cvc.getTableMap().putTables(tablesOfMap);

						// put table in context

						ConstraintGenerator.putTableInCtx(cvc, columnnames, columntypes,
								"pushed_" + pushedDownTable.getTableName() + level);
						// will be stored table1's cols with count then table2's then 3's -
						// parismita

						// pushedDownTable.addColumn(n.getLeft().getColumn()); // put relavent column

						if (!table.contains(pushedDownTable)) {
							table.add(pushedDownTable); // Need aliasing of this table, need to make it unique
							joinTables.add(pushedDownTable.getAliasName());
							tuplesInJoin.add(cvc.getNoOfOutputTuples(pushedDownTable.getAliasName()));
						}
						// if(cs.isAggr==true) continue; //parismita
						// Add correlation condition of passing down
						// Create left node of condition
						Node rightNode;// = Node.createNode(n.getRight().getColumn(), n.getRight().getTable());
						// rightNode.setTableAlias(n.getRight().getTable().getAliasName());
						// rightNode.setTableNameNo(n.getRight().getTable().getTableName());
						// rightNode.level = cs.getOriginalLevelRight();
						rightNode = n.getRight().clone();
						// Create right node of condition
						// Outer table or right of condtion?

						// new table
						Node leftNode = Node.createNode(
								pushedDownTable.getColumn(n.getLeft().getColumn().getColumnName()), pushedDownTable);
						leftNode.setTableAlias(pushedDownTable.getAliasName());
						leftNode.setTableNameNo(pushedDownTable.getTableName());
						leftNode.level = level;

						// Create condition
						Node condition = new Node();
						condition.setLeft(leftNode);
						condition.setRight(rightNode);
						condition.level = level;
						condition.setOperator(n.getOperator());
						condition.setExpired(false);
						condition.isCorrelated = true;
						condition.setType(n.getType());
						// more params need to be added from node n - parismita (but currently
						// sufficient)

						// Put condition into correlation map
						correlationStructure csTemp = new correlationStructure(condition);
						csTemp.setQueryType(cvc.levelToQueryTypeHashMap.get(level));
						csTemp.setProcessLevel(cs.getPushTableDownLevel());
						csTemp.setIsPushedDown(true);
						csTemp.setIsEquiJoin(cs.getIsEquiJoin());
						csTemp.setIsAggr(cs.isAggr);
						// note: if isAggr on level - then make it true but how to find that? -
						// parismita
						temp.put(condition, csTemp);

					} else if (n.getRight() != null && n.getRight().getLevel() < level) {
						// Right table to be pushed down
						// Add correlation condition of passing down
						Table pushedDownTable = (Table) n.getRight().getTable().clone();
						pushedDownTable.getColumns().putAll(((Table) n.getLeft().getTable()).getColumns());

						pushedDownTable.setAliasName("pushed_" + pushedDownTable.getTableName() + level); // temporary
																											// table
																											// alias
						for (String colName : pushedDownTable.getColumns().keySet()) {
							pushedDownTable.getColumn(colName).setTable(pushedDownTable);
						}
						// pushedDownTable.addColumn(n.getLeft().getColumn()); // put relavent column

						Map<String, Table> tablesOfMap = new HashMap<String, Table>();
						tablesOfMap.put("pushed_" + pushedDownTable.getTableName() + level, pushedDownTable);
						cvc.getTableMap().putTables(tablesOfMap);

						// put table in context
						Vector<String> columnnames = new Vector<String>(pushedDownTable.getColumns().keySet());

						Vector<Sort> columntypes = new Vector<Sort>();
						for (String col : columnnames) {
							columntypes.add(ConstraintGenerator.getColumnSort(col));
						}

						ConstraintGenerator.putTableInCtx(cvc, columnnames, columntypes,
								"pushed_" + pushedDownTable.getTableName() + level);

						if (!table.contains(pushedDownTable)) {
							table.add(pushedDownTable); // Need aliasing of this table, need to make it unique
							joinTables.add(pushedDownTable.getTableName());
							tuplesInJoin.add(cvc.getNoOfOutputTuples(pushedDownTable.getTableName()));
						}
						// if(cs.isAggr==true) continue;
						// Add correlation condition of passing down

						// Create left node of condition
						Node leftNode;// = Node.createNode(n.getLeft().getColumn(), n.getLeft().getTable());
						// leftNode.setTableAlias(n.getLeft().getTable().getAliasName());
						// leftNode.setTableNameNo(n.getLeft().getTable().getTableName());
						// leftNode.level = cs.getOriginalLevelLeft();
						leftNode = n.getLeft().clone();

						// Create right node of condition
						Node rightNode = Node.createNode(
								pushedDownTable.getColumn(n.getRight().getColumn().getColumnName()), pushedDownTable);
						rightNode.level = level;
						rightNode.setTableAlias(pushedDownTable.getAliasName());
						rightNode.setTableNameNo(pushedDownTable.getTableName());

						// Create condition
						Node condition = new Node();
						condition.setLeft(leftNode);
						condition.setRight(rightNode);
						condition.level = level;
						condition.setOperator(n.getOperator());
						condition.setExpired(false);
						condition.isCorrelated = true;

						// Put condition into correlation map
						correlationStructure csTemp = new correlationStructure(condition);
						csTemp.setQueryType(cvc.levelToQueryTypeHashMap.get(level));
						csTemp.setProcessLevel(cs.getPushTableDownLevel());
						csTemp.setIsPushedDown(true);
						csTemp.setIsAggr(cs.isAggr);
						temp.put(condition, csTemp);
					}
				}
			}
		}
		cvc.correlationHashMap.putAll(temp);
	}

	private static HashMap<String, Column> getRequiredMappingFromSubquery(GenerateCVC1 cvc, Table t, int level) {
		HashMap<String, Column> columns = new LinkedHashMap<String, Column>();
		for (Node n : cvc.correlationHashMap.keySet()) {
			if (n.isCorrelated && n.getExpired() == false) {
				correlationStructure cs = cvc.correlationHashMap.get(n);
				if (cs != null && cs.getProcessLevel() < level) {
					// do something
					// update the table name and column in node from below level JSQ
					if (n.getLeft() != null && n.getLeft().getTableNameNo() != null
							&& n.getLeft().getTableNameNo().equalsIgnoreCase(t.getTableName())) {
						columns.put(n.getLeft().getColumn().getColumnName(), n.getLeft().getColumn());
						columns.put(t.getColumn(t.getColumns().size() - 1).getColumnName(),
								t.getColumn(t.getColumns().size() - 1));

					}
					if (n.getRight() != null && n.getRight().getTableNameNo() != null
							&& n.getRight().getTableNameNo().equalsIgnoreCase(t.getTableName())) {
						columns.put(n.getRight().getColumn().getColumnName(), n.getRight().getColumn());
						columns.put(t.getColumn(t.getColumns().size() - 1).getColumnName(),
								t.getColumn(t.getColumns().size() - 1));
					}
				}
			}
		}
		return columns;
	}

	/**
	 * TEMPCODE Rahul Sharma
	 * 
	 * @param joinTable
	 * @param t1
	 * @param t2
	 * @return
	 */
	private static HashMap<String, ArrayList<String>> createTempTableColumns(String joinTable, Table t1, Table t2) {
		// TODO Auto-generated method stub
		HashMap<String, ArrayList<String>> columnNameAndDataTypes = new HashMap<String, ArrayList<String>>();
		ArrayList<String> columns = new ArrayList<String>();
		ArrayList<String> columnDataTypes = new ArrayList<String>();
		ArrayList<String> primaryKey = new ArrayList<String>();
		int count = 0;
		String columnName;
		HashMap<String, Column> t1_columns = t1.getColumns();

		// for (Column c : t1.getPrimaryKey()) {
		// primaryKey.add(c);
		// }
		// for (Column c : t2.getPrimaryKey()) {
		// primaryKey.add(c);
		// }
		for (Column c : t1_columns.values()) {

			columnName = joinTable + "_" + t1.getTableName() + "__" + c.getColumnName() + count;
			columns.add(columnName);
			columnDataTypes.add(c.getCvcDatatype());
			if (t1.getPrimaryKey().contains(c)) {
				primaryKey.add(columnName);
			}
			count++;
		}

		HashMap<String, Column> t2_columns = t2.getColumns();
		for (Column c : t2_columns.values()) {
			columnName = joinTable + "_" + t2.getTableName() + "__" + c.getColumnName() + count;
			columns.add(columnName);
			columnDataTypes.add(c.getCvcDatatype());
			if (t2.getPrimaryKey().contains(c)) {
				primaryKey.add(columnName);
			}
			count++;
		}

		// Column cntCol = new Column(joinTable + "__XDATA_CNT_k" , joinTable);
		// cntCol.setCvcDatatype("Int");
		columns.add(joinTable + "__XDATA_CNT_k");
		columnDataTypes.add("Int");
		columnNameAndDataTypes.put("Names", columns);
		columnNameAndDataTypes.put("DataTypes", columnDataTypes);
		columnNameAndDataTypes.put("PrimaryKey", primaryKey);

		return columnNameAndDataTypes;
	}

	/**
	 * TEMPCODE Rahul Sharma
	 * 
	 * @param f1 : Table 1
	 * @param f2 : Table 2
	 * @return : constraints with all attributes present for quantifiers [forall /
	 *         exists]
	 */
	private static String generateConstraintsForAllAttributes(Table t1, Table t2, ArrayList<String> jtColumns,
			String jtName) {
		// TODO Auto-generated method stub
		String constraintString = "";
		int numberOfConstraints = jtColumns.size();
		String constraints[] = new String[numberOfConstraints];

		String t1_name = t1.getTableName().toLowerCase();
		String t2_name = t2.getTableName().toLowerCase();
		String jt_name = jtName.toLowerCase();

		// String t1_name = t1.getTableName().toUpperCase();
		// String t2_name = t2.getTableName().toUpperCase();
		// String jt_name = jtName.toUpperCase();

		int count = 0, count1 = 0;
		for (String key : t1.getColumns().keySet()) {
			constraints[count] = "(= (" + t1_name + "_" + key + count1 + " (select O_" + t1_name + " i1)) ("
					+ jtColumns.get(count) + " (select O_" + jt_name + " k1)))";
			constraintString += constraints[count];
			count++;
			count1++;
		}

		int count2 = 0;
		for (String key : t2.getColumns().keySet()) {
			constraints[count] = "(= (" + t2_name + "_" + key + count2 + " (select O_" + t2_name + " j1)) ("
					+ jtColumns.get(count) + " (select O_" + jt_name + " k1)))";
			constraintString += constraints[count];
			count++;
			count2++;
		}

		int index = 0;
		String finalConstraints = constraints[index++];
		while (index < numberOfConstraints) {
			finalConstraints = finalConstraints + "\n\t" + constraints[index++];
		}
		finalConstraints = "(and \n\t" + finalConstraints + "\n)";
		return finalConstraints;
	}

	/**
	 * TEMPCODE Rahul Sharma
	 * 
	 * @param f1 : Table 1
	 * @param f2 : Table 2
	 * @return : constraints with all attributes present for quantifiers [forall /
	 *         exists]
	 */
	private static String generateConstraintsForAllAndExistsAttributes(GenerateCVC1 cvc, Node n1, Node n2, Table t1,
			Table t2,
			ArrayList<String> jtColumns, String jtName, int tuplesInJoinTable, Vector<Node> selectionAndJoinConds) {
		// TODO Auto-generated method stub

		int tuplesInTable1 = 2;
		int tuplesInTable2 = 3;
		tuplesInJoinTable = 1;

		String t1_name = t1.getTableName().toLowerCase();
		String t2_name = t2.getTableName().toLowerCase();
		jtName = jtName.toLowerCase();
		String constraintString = "";
		String finalConstraints = "";
		Vector<Table> t = new Vector<>();
		t.add(t1);
		t.add(t2);
		for (int k = 1; k <= tuplesInJoinTable; k++) {
			String constr = "\t";
			// selection conditions, Skipping string selection conditions for now FIXME
			for (Node n : selectionAndJoinConds) {

				constr += generateConstraintsForSelectionConditions(cvc, n, jtColumns, jtName, t, Integer.toString(k),
						Integer.toString(k)) + "\n\t";
			}

			String constrTable1 = "";
			int count = 0;
			for (int i = 1; i <= tuplesInTable1; i++) {
				String temp = "\t\t";
				int count1 = 0;
				int countJT = count;
				for (String key : t1.getColumns().keySet()) {
					temp += "(= (" + t1_name + "_" + key + count1 + " (select O_" + t1_name + " " + i + ")) ("
							+ jtColumns.get(countJT) + " (select O_" + jtName + " " + k + ")))\n\t\t";
					countJT++;
					count1++;
				}
				temp = "\n\t  (and \n" + temp + "\n\t  )";
				constrTable1 += temp;
			}
			constrTable1 = "\t(or " + constrTable1 + "\n\t)";

			count = t1.getNoOfColumn();
			String constrTable2 = "";
			for (int j = 1; j <= tuplesInTable2; j++) {
				String temp = "\t\t";
				int count2 = 0;
				int countJT = count;
				for (String key : t2.getColumns().keySet()) {
					temp += "(= (" + t2_name + "_" + key + count2 + " (select O_" + t2_name + " " + j + ")) ("
							+ jtColumns.get(countJT) + " (select O_" + jtName + " " + k + ")))\n\t\t";
					countJT++;
					count2++;
				}
				temp = "\n\t  (and \n" + temp + "\n\t  )";
				constrTable2 += temp;
			}
			constrTable2 = "\t(or " + constrTable2 + "\n\t)";

			finalConstraints += "(and \n" + constr + "\n" + constrTable1 + "\n" + constrTable2 + "\n  )\n  ";
		}
		finalConstraints = "(assert \n (and \n  " + finalConstraints + "\n )\n)";

		return finalConstraints;
	}

	/********************** TESE CODE END ********************/
	// @shalini : Making the generateConstraintsForSelectionConditions recursive to
	// handle complex conditions
	// Recursive helper function to process any node(colref,val,op)
	private static String processNodeExpr(Node n, ArrayList<String> jtColumns, String jtName, Vector<Table> tables,
			String tupleId) {
		if (n == null) {
			return "";
		}

		// chaitra changed here for extract type - e.g. extract(year from date)
		String part = n.getStrConst();
		if (n.getType().equalsIgnoreCase(Node.getExtractFuncType()))
			n = n.getLeft();

		// shalini: Handle CAST nodes - convert string to date/time SMT representation
		if (n.getType() != null && n.getType().equalsIgnoreCase(Node.getCastNodeType())) {
			if (n.getLeft() != null) {
				String strValue = n.getLeft().getStrConst();
				ColDataType castType = n.getCastType();

				if (castType != null && strValue != null) {
					String dataType = castType.getDataType();

					if (dataType != null && dataType.equalsIgnoreCase("DATE")) {
						// Convert string to date SMT representation
						String dateStr = strValue;
						if (dateStr.startsWith("'") && dateStr.endsWith("'")) {
							dateStr = dateStr.substring(1, dateStr.length() - 1);
						}
						String[] values = dateStr.split("-");
						if (values.length == 3) {
							try {
								int y = Integer.parseInt(values[0].trim());
								int m = Integer.parseInt(values[1].trim());
								int d = Integer.parseInt(values[2].trim());
								DatatypeSort dateSort = (DatatypeSort) ConstraintGenerator.ctxSorts.get("DATE");
								FuncDecl constructor = dateSort.getConstructors()[0];
								Expr dateValue = ConstraintGenerator.ctx.mkApp(constructor,
										ConstraintGenerator.ctx.mkInt(y), ConstraintGenerator.ctx.mkInt(m),
										ConstraintGenerator.ctx.mkInt(d));
								return dateValue.toString();
							} catch (NumberFormatException e) {
								// Number format error - fall through
							}
						}
					} else if (dataType != null && dataType.equalsIgnoreCase("TIME")) {
						// Convert string to time SMT representation
						String timeStr = strValue;
						if (timeStr.startsWith("'") && timeStr.endsWith("'")) {
							timeStr = timeStr.substring(1, timeStr.length() - 1);
						}
						String[] values = timeStr.split(":");
						if (values.length == 3) {
							try {
								int h = Integer.parseInt(values[0].trim());
								int m = Integer.parseInt(values[1].trim());
								int s = Integer.parseInt(values[2].trim());
								DatatypeSort timeSort = (DatatypeSort) ConstraintGenerator.ctxSorts.get("TIME");
								FuncDecl constructor = timeSort.getConstructors()[0];
								Expr timeValue = ConstraintGenerator.ctx.mkApp(constructor,
										ConstraintGenerator.ctx.mkInt(h), ConstraintGenerator.ctx.mkInt(m),
										ConstraintGenerator.ctx.mkInt(s));
								return timeValue.toString();
							} catch (NumberFormatException e) {
								// Number format error - fall through
							}
						}
					}
				}
			}
			// Fallback: process the inner expression
			return processNodeExpr(n.getLeft(), jtColumns, jtName, tables, tupleId);
		}

		// If it's a column reference node
		if (n.getType() != null && n.getType().equalsIgnoreCase(Node.getColRefType())) {
			String tableName = n.getTableNameNo() != null ? n.getTableNameNo().replaceAll("\\d", "").toLowerCase()
					: null;
			int colIndex = 0, flag = -1;
			for (Table table : tables) {
				if (table == null)
					continue;
				if (table.getTableName().equals(tableName)) {
					for (int i = colIndex; i < colIndex + table.getNoOfColumn(); i++) {
						if (jtColumns.get(i).split("__")[1].replaceAll("\\d", "")
								.equalsIgnoreCase(n.getColumn().getColumnName().replaceAll("\\d", ""))) {
							colIndex = i;
							flag = 1;
							break;
						}
					}
					if (flag == 1)
						break;
				} else {
					colIndex += table.getNoOfColumn();
				}
			}
			if (flag != -1) {
				String tmpstr = "";
				tmpstr = "( " + jtColumns.get(colIndex) + " (select O_" + jtName + " " + tupleId + " )) ";
				if (part != null && (part.equalsIgnoreCase("year") || part.equalsIgnoreCase("month")
						|| part.equalsIgnoreCase("day")))
					tmpstr = "(" + part.toLowerCase() + " " + tmpstr + ")";
				return tmpstr;
			}
		}

		// If it is a val node
		if (n.getType() != null && n.getType().equalsIgnoreCase(Node.getValType())) {
			if (n.getStrConst().contains("/")) {
				String[] values = n.getStrConst().split("/");
				return "(/ " + values[0] + " " + values[1] + " )";
			}
			return getConstantAsSMT(n);
		}

		// chaitra added date node processing
		if (n.getType() != null && n.getType().equalsIgnoreCase(Node.getDateType())) {
			if (n.getStrConst().contains("INTERVAL")) {
				String intervalStr = n.getStrConst().replace("INTERVAL", "").replace("'", "").trim();
				String[] parts = intervalStr.split("\\s+");
				int value = Integer.parseInt(parts[0]);
				String unit = parts[1].toLowerCase();
				switch (unit) {
					case "days":
					case "day":
						return Integer.toString(value);
					case "months":
					case "month":
						return Integer.toString(value * 30);
					case "years":
					case "year":
						return Integer.toString(value * 365);
					default:
						return "";
				}
			} else {
				String[] values = n.getStrConst().split("-");
				int y = Integer.parseInt(values[0]);
				int m = Integer.parseInt(values[1]);
				int d = Integer.parseInt(values[2]);
				DatatypeSort dateSort = (DatatypeSort) ConstraintGenerator.ctxSorts.get("DATE");

				FuncDecl getDay = ConstraintGenerator.ctxFuncDecls.get("getDay");
				FuncDecl getMonth = ConstraintGenerator.ctxFuncDecls.get("getMonth");
				FuncDecl getYear = ConstraintGenerator.ctxFuncDecls.get("getYear");

				FuncDecl constructor = dateSort.getConstructors()[0];
				Expr dateValue = ConstraintGenerator.ctx.mkApp(constructor, ConstraintGenerator.ctx.mkInt(y),
						ConstraintGenerator.ctx.mkInt(m), ConstraintGenerator.ctx.mkInt(d));
				return dateValue.toString();
			}
		}

		// chaitra added time node processing
		if (n.getType() != null && n.getType().equalsIgnoreCase(Node.getTimeType())) {
			String[] values = n.getStrConst().split(":");
			int h = Integer.parseInt(values[0]);
			int m = Integer.parseInt(values[1]);
			int s = Integer.parseInt(values[2]);
			DatatypeSort timeSort = (DatatypeSort) ConstraintGenerator.ctxSorts.get("TIME");

			FuncDecl getHours = ConstraintGenerator.ctxFuncDecls.get("getDay");
			FuncDecl getMinutes = ConstraintGenerator.ctxFuncDecls.get("getMonth");
			FuncDecl getSeconds = ConstraintGenerator.ctxFuncDecls.get("getYear");

			FuncDecl constructor = timeSort.getConstructors()[0];
			Expr timeValue = ConstraintGenerator.ctx.mkApp(constructor, ConstraintGenerator.ctx.mkInt(h),
					ConstraintGenerator.ctx.mkInt(m), ConstraintGenerator.ctx.mkInt(s));
			return timeValue.toString();
		}

		// chaitra added date node processing
		if (n.getType() != null && n.getType().equalsIgnoreCase(Node.getDateType())) {
			if (n.getStrConst().contains("INTERVAL")) {
				String intervalStr = n.getStrConst().replace("INTERVAL", "").replace("'", "").trim();
				String[] parts = intervalStr.split("\\s+");
				int value = Integer.parseInt(parts[0]);
				String unit = parts[1].toLowerCase();
				switch (unit) {
					case "days":
					case "day":
						return Integer.toString(value);
					case "months":
					case "month":
						return Integer.toString(value * 30);
					case "years":
					case "year":
						return Integer.toString(value * 365);
					default:
						return "";
				}
			} else {
				String[] values = n.getStrConst().split("-");
				int y = Integer.parseInt(values[0]);
				int m = Integer.parseInt(values[1]);
				int d = Integer.parseInt(values[2]);
				DatatypeSort dateSort = (DatatypeSort) ConstraintGenerator.ctxSorts.get("DATE");

				FuncDecl getDay = ConstraintGenerator.ctxFuncDecls.get("getDay");
				FuncDecl getMonth = ConstraintGenerator.ctxFuncDecls.get("getMonth");
				FuncDecl getYear = ConstraintGenerator.ctxFuncDecls.get("getYear");

				FuncDecl constructor = dateSort.getConstructors()[0];
				Expr dateValue = ConstraintGenerator.ctx.mkApp(constructor, ConstraintGenerator.ctx.mkInt(y),
						ConstraintGenerator.ctx.mkInt(m), ConstraintGenerator.ctx.mkInt(d));
				return dateValue.toString();
			}
		}

		// chaitra added time node processing
		if (n.getType() != null && n.getType().equalsIgnoreCase(Node.getTimeType())) {
			String[] values = n.getStrConst().split(":");
			int h = Integer.parseInt(values[0]);
			int m = Integer.parseInt(values[1]);
			int s = Integer.parseInt(values[2]);
			DatatypeSort timeSort = (DatatypeSort) ConstraintGenerator.ctxSorts.get("TIME");

			FuncDecl getHours = ConstraintGenerator.ctxFuncDecls.get("getDay");
			FuncDecl getMinutes = ConstraintGenerator.ctxFuncDecls.get("getMonth");
			FuncDecl getSeconds = ConstraintGenerator.ctxFuncDecls.get("getYear");

			FuncDecl constructor = timeSort.getConstructors()[0];
			Expr timeValue = ConstraintGenerator.ctx.mkApp(constructor, ConstraintGenerator.ctx.mkInt(h),
					ConstraintGenerator.ctx.mkInt(m), ConstraintGenerator.ctx.mkInt(s));
			return timeValue.toString();
		}

		// If it is an operator node, recursively process left and right children
		if (n.getOperator() != null && n.getLeft() != null && n.getRight() != null) {
			String constrL = processNodeExpr(n.getLeft(), jtColumns, jtName, tables, tupleId);
			String constrR = processNodeExpr(n.getRight(), jtColumns, jtName, tables, tupleId);
			// chaitra changed here for interval - change arithmetic op to interval function
			if ((n.getLeft() != null && n.getLeft().getStrConst() != null
					&& n.getLeft().getStrConst().contains("INTERVAL"))
					|| n.getRight() != null && n.getRight().getStrConst() != null
							&& n.getRight().getStrConst().contains("INTERVAL")) {
				return "( " + "addIntervalDays" + " " + constrL + " " + constrR + " )";
			} else {
				return "( " + n.getOperator() + " " + constrL + " " + constrR + " )";
			}
		}

		// Fallback return empty string
		return "";

	}

	private static String getConstantAsSMT(Node n) {
		if (n == null || n.getStrConst() == null) {
			return "";
		}
		if (n.getStrConst().equalsIgnoreCase("TRUE")) {
			return "1";
		}
		if (n.getStrConst().equalsIgnoreCase("FALSE")) {
			return "0";
		}
		return n.getStrConst();
	}

	/**
	 * Helper function to unwrap CAST nodes and get the actual inner node type
	 * This is used to correctly identify column references even when wrapped in
	 * CAST
	 */
	private static Node unwrapCastNode(Node n) {
		if (n != null && n.getType() != null && n.getType().equalsIgnoreCase(Node.getCastNodeType())) {
			return unwrapCastNode(n.getLeft()); // Recursively unwrap nested CASTs
		}
		return n;
	}

	// parismita
	// this assumes left is always colref do we need to extend this?
	public static String generateConstraintsForSelectionConditions(GenerateCVC1 cvc, Node n,
			ArrayList<String> jtColumns, String jtName,
			Vector<Table> tables, String tupleIdRight, String tupleIdLeft) {
		// Handle AND/OR Recursion
		if (n.getType() != null && (n.getType().equalsIgnoreCase(Node.getAndNodeType())
				|| n.getType().equalsIgnoreCase(Node.getOrNodeType()))) {
			String leftConstr = generateConstraintsForSelectionConditions(cvc, n.getLeft(), jtColumns, jtName, tables,
					tupleIdRight, tupleIdLeft);
			String rightConstr = generateConstraintsForSelectionConditions(cvc, n.getRight(), jtColumns, jtName, tables,
					tupleIdRight, tupleIdLeft);

			if (leftConstr.trim().isEmpty())
				return rightConstr;
			if (rightConstr.trim().isEmpty())
				return leftConstr;

			String logicOp = n.getType().equalsIgnoreCase(Node.getOrNodeType()) ? "or" : "and";
			return "\n(" + logicOp + " " + leftConstr + " " + rightConstr + ")\n";
		}
		String constr = "";
		String left = "";
		String right = "";

		if (n.getLeft().getTableNameNo() != null && !n.getLeft().getTableNameNo().contains("JSQ")
				&& !n.getLeft().getTableNameNo().contains("GSQ") && !n.getLeft().getTableNameNo().contains("DSQ"))
			left = n.getLeft().getTableNameNo().replaceAll("\\d", "").toLowerCase();
		else if (n.getLeft().getTableNameNo() != null && (n.getLeft().getTableNameNo().contains("JSQ")
				|| n.getLeft().getTableNameNo().contains("GSQ") || n.getLeft().getTableNameNo().contains("DSQ"))) {
			left = n.getLeft().getTableNameNo();
		} else
			left = null;

		// chaitra left node is expression then treat as colref for predicate start
		Node tempExprNode = null;
		if (n.getLeft() != null && n.getLeft().getType().equalsIgnoreCase(Node.getBaoNodeType())) {
			Node leftNode = n.getLeft();
			for (int e = 0; e < leftNode.expDetails.size(); e++) {
				if (leftNode.expDetails.get(e).getExpNode() == leftNode) {
					tempExprNode = leftNode.expDetails.get(e).getExpNode();
					left = leftNode.expDetails.get(e).getExpTable().getTableName();
					break;
				}
			}
		}
		if (tempExprNode != null)
			tempExprNode.setType(Node.getColRefType());
		// chaitra left node is expression then treat as colref for predicate end

		if (n.getNodeType() != null && !n.getNodeType().equalsIgnoreCase(n.getIsNullNodeType())) {
			if (n.getRight().getTableNameNo() != null && !n.getRight().getTableNameNo().contains("JSQ")
					&& !n.getRight().getTableNameNo().contains("GSQ") && !n.getRight().getTableNameNo().contains("DSQ"))
				right = n.getRight().getTableNameNo().replaceAll("\\d", "").toLowerCase();

			else if (n.getRight().getTableNameNo() != null && (n.getRight().getTableNameNo().contains("JSQ")
					|| n.getRight().getTableNameNo().contains("GSQ")
					|| n.getRight().getTableNameNo().contains("DSQ"))) {
				right = (n.getRight().getTableNameNo());
			} else
				right = null;
		}

		int l_index = 0, r_index = 0, l_flag = -1, r_flag = -1;
		// left
		for (Table table : tables) {
			if (table == null)
				continue;
			if (table.getTableName().equals(left)) { // gives col index of t1
				for (int i = l_index; i < l_index + table.getNoOfColumn(); i++) {
					if (jtColumns.get(i).split("__")[1].replaceAll("\\d", "")
							.equalsIgnoreCase(n.getLeft().getColumn().getColumnName().replaceAll("\\d", ""))) { // revert
																												// here
						// if (jtColumns.get(i).split("__")[1].replaceAll("\\d", "")
						// .equalsIgnoreCase(n.getLeft().getColumn().getColumnName().split("__")[1].replaceAll("\\d",
						// ""))) { // chaitra changed here for exp FIX ME
						l_index = i;
						l_flag = 1;
						break;
					} else if (n.getLeft().getColumn().getColumnName().contains("__") && jtColumns.get(i).split("__")[1]
							.replaceAll("\\d", "")
							.equalsIgnoreCase(
									n.getLeft().getColumn().getColumnName().split("__")[1].replaceAll("\\d", ""))
							&& jtColumns.get(i).contains(n.getLeft().getColumn().getColumnName())) {
						l_index = i;
						l_flag = 1;
						break;
					}
				}
				if (l_flag == 1)
					break;
			} else//
				l_index = l_index + table.getNoOfColumn();
		}

		// right
		if (n.getNodeType() != null && !n.getNodeType().equalsIgnoreCase(n.getIsNullNodeType())) {

			for (Table table : tables) {
				if (table == null)
					continue;
				if (table.getTableName().equals(right)) // gives col index of t1
				{
					for (int i = r_index; i < r_index + table.getNoOfColumn(); i++) {
						String col = n.getRight().getColumn().getColumnName().replaceAll("\\d", "");
						if (jtColumns.get(i).contains("__") && col.contains("__")
								&& jtColumns.get(i).split("__")[1].replaceAll("\\d", "")
										.equalsIgnoreCase(col.split("__")[1])) {
							r_index = i;
							r_flag = 1;
							break;
						} else if (jtColumns.get(i).split("__")[1].replaceAll("\\d", "")
								.equalsIgnoreCase(n.getRight().getColumn().getColumnName().replaceAll("\\d", ""))) {
							r_index = i;
							r_flag = 1;
							break;
						} else if (n.getRight().getColumn().getColumnName().contains("__")
								&& jtColumns.get(i).split("__")[1]
										.replaceAll("\\d", "")
										.equalsIgnoreCase(
												n.getRight().getColumn().getColumnName().split("__")[1]
														.replaceAll("\\d", ""))
								&& jtColumns.get(i).contains(n.getRight().getColumn().getColumnName())) {
							r_index = i;
							r_flag = 1;
							break;
						}
					}
					if (r_flag == 1)
						break;
				} else
					r_index = r_index + table.getNoOfColumn();
			}
		}
		ConstraintGenerator cg = new ConstraintGenerator();
		String constrL = "", constrR = "";
		String nonNullConstr = "";
		if (l_flag != -1 && r_flag != -1) {
			if (n.getNodeType() != null && !n.getNodeType().equalsIgnoreCase(n.getIsNullNodeType())) {

				constr = "( " + jtColumns.get(l_index) + " (select O_" + jtName + " " + tupleIdLeft + " )) ";
				constrL = "( " + jtColumns.get(l_index) + " (select O_" + jtName + " " + tupleIdLeft + " )) ";
			}
			nonNullConstr += cg.getAssertNotNullConditionForSQTable(cvc, n.getLeft(), tupleIdLeft,
					cvc.getTableMap().getSQTableByName(jtName), l_index);

			if (n.getNodeType() != null && n.getNodeType().equalsIgnoreCase(n.getIsNullNodeType())
					&& n.getOperator().equalsIgnoreCase("=")) {
				nonNullConstr = "(not " + nonNullConstr + ")";
			}
			if (n.getNodeType() != null && !n.getNodeType().equalsIgnoreCase(n.getIsNullNodeType())) {

				constr += "( " + jtColumns.get(r_index) + " (select O_" + jtName + " " + tupleIdRight + " )) ";
				constrR = "( " + jtColumns.get(r_index) + " (select O_" + jtName + " " + tupleIdRight + " )) ";
				nonNullConstr += cg.getAssertNotNullConditionForSQTable(cvc, n.getRight(), tupleIdRight,
						cvc.getTableMap().getSQTableByName(jtName), r_index);
			}
			if (left.equals(right) && r_index == l_index && n.isNegated)
				return "";

		} else {
			if (n.getNodeType() != null && !n.getNodeType().equalsIgnoreCase(n.getIsNullNodeType())) {

				constr = "(" + jtColumns.get(l_index) + " (select O_" + jtName + " " + tupleIdLeft + " )) ";
				if (n.getType() != null
						&& (n.getType().equalsIgnoreCase("IN") || n.getType().equalsIgnoreCase("NOT IN"))) {
					return constr;
				}
				if (n.getRight().getStrConst().contains("/")) {
					String[] values = n.getRight().getStrConst().split("/");
					constr += "(/ " + values[0] + " " + values[1] + ")";
				} else
					constr += n.getRight().getStrConst();

				// chaitra if column is expression, not null??? fix me
				if (n.getLeft().getColumn().getColumnName().contains("EXP")) {
				}
				// chaitra if column is expression, not null??? fix me
				else
					nonNullConstr += cg.getAssertNotNullConditionForSQTable(cvc, n.getLeft(), tupleIdLeft,
							cvc.getTableMap().getSQTableByName(jtName), l_index);
			} else {
				nonNullConstr += cg.getAssertNotNullConditionForSQTable(cvc, n.getLeft(), tupleIdLeft,
						cvc.getTableMap().getSQTableByName(jtName), l_index);
				if (n.getNodeType() != null && n.getNodeType().equalsIgnoreCase(n.getIsNullNodeType())
						&& n.getOperator().equalsIgnoreCase("=")) {
					nonNullConstr = "(not " + nonNullConstr + ")";
				}
			}
		}

		if (tempExprNode != null)
			tempExprNode.setType(Node.getBaoNodeType());

		String op = cg.getUserDefinedComparisionOperator(n.getOperator(), n.getLeft().getColumn(), constrL, constrR);

		String returnStr = "";
		if (op != "") {
			returnStr += ((n.isNegated) ? "(not " : " ") + op + ((n.isNegated) ? " )" : " ");
			// return ((n.isNegated) ? "(not " : " ") + op + ((n.isNegated) ? " )" : " ");
		} else if (n.getOperator().equals("/="))
			returnStr += ((n.isNegated) ? "(not " : " ") + "(not (= " + constr + ") )" + ((n.isNegated) ? " )" : " ");
		// return ((n.isNegated) ? "(not " : " ") + "(not (= " + constr + ") )" +
		// ((n.isNegated) ? " )" : " ");
		else
			returnStr += ((n.isNegated) ? "(not " : " ") + "(" + n.getOperator() + " " + constr + " )"
					+ ((n.isNegated) ? " )" : " ");

		// return ((n.isNegated) ? "(not " : " ") + "(" + n.getOperator() + " " + constr
		// + " )"
		// + ((n.isNegated) ? " )" : " ");
		if (n.getNodeType() != null && n.getNodeType().equalsIgnoreCase(n.getIsNullNodeType()))
			returnStr = "";

		if ((returnStr + nonNullConstr) != "")
			return "\n(and" + returnStr + nonNullConstr + ")\n";
		else
			return "";

	}
	// Note: Ensure unwrapCastNode and processNodeExpr are accessible and robust.

	/**
	 * @author parismita
	 * @param n
	 * @param jtColumns
	 * @param jtName
	 * @param tables
	 * @param tupleIdRight
	 * @param tupleIdLeft
	 * @return
	 */
	public static String generateConstraintsForStringConditions(GenerateCVC1 cvc, Node n, ArrayList<String> jtColumns,
			String jtName, Vector<Table> tables, String tupleIdRight, String tupleIdLeft) throws Exception {
		String constr = "";// string
		ConstraintGenerator cg = new ConstraintGenerator();
		String left = n.getLeft().getTableNameNo() != null
				? (n.getLeft().getTableNameNo().replaceAll("\\d", "")).toLowerCase()
				: null;
		String right = n.getRight().getTableNameNo() != null
				? (n.getRight().getTableNameNo().replaceAll("\\d", "")).toLowerCase()
				: null;
		int l_index = 0, r_index = 0, l_flag = -1, r_flag = -1;
		// left
		for (Table table : tables) {
			if (table == null)
				continue;
			if (table.getTableName().equals(left)) { // gives col index of t1
				l_index += table.getColumnIndex(n.getLeft().getColumn().getColumnName());
				l_flag = 1;
				break;
			} else
				l_index += table.getNoOfColumn();
		}

		// right
		for (Table table : tables) {
			if (table == null)
				continue;
			if (table.getTableName().equals(right)) // gives col index of t1
			{
				r_index += table.getColumnIndex(n.getRight().getColumn().getColumnName());
				r_flag = 1;
				break;
			} else
				r_index = r_index + table.getNoOfColumn();
		}
		boolean stringFlag = false;
		if (l_flag != -1 && r_flag != -1) {
			constr = "(" + jtColumns.get(l_index) + " (select O_" + jtName + " " + tupleIdLeft + " )) ";
			constr += "(" + jtColumns.get(r_index) + " (select O_" + jtName + " " + tupleIdRight + " )) ";
		} else {
			constr = "(" + jtColumns.get(l_index) + " (select O_" + jtName + " " + tupleIdLeft + " )) ";
			// constr += n.getOperator().equalsIgnoreCase("/=")?"!=":n.getOperator();
			constr += getConstantAsSMT(n.getRight());
			stringFlag = true;
		}

		// if(n.getOperator().equals("/="))
		// return "(not (= "+constr + ") )";
		Vector<String> strConstr = new Vector<>();

		strConstr.add("(" + (n.getOperator().equalsIgnoreCase("/=") ? "( not (= " : n.getOperator()) + " " + constr
				+ " )" + (n.getOperator().equalsIgnoreCase("/=") ? ")" : ""));

		// Uncomment later: right now generate whatever string solver is solving
		// if(jtName.contains("JSQ") || jtName.contains("GSQ")){ // Sunanda for
		// conditions on subquery table backward pass
		// return "(" + n.getOperator() + " " + constr + " )" ;
		// }
		constr = "";
		String s = n.getRight().toString();
		if (s.contains("[")) {
			String tableName = n.getLeft().getTableNameNo().replaceAll("\\d", "");
			String columnName = n.getLeft().getColumn().getColumnName();
			Vector<String> columnValues = cvc.getTableMap().getTable(tableName).getColumn(columnName).getColumnValues();

			// chaitra : while adding value to column, already it is checked if it exists,
			// no need to do here, can uncomment columnValues.remove(i); if required
			if (cvc.getStringSolver().generatedStringMap.containsKey(columnName)) {
				String v = cvc.getStringSolver().generatedStringMap.get(columnName);
				for (int i = columnValues.size() - 1; i >= 0; i--) {
					if (columnValues.get(i).equalsIgnoreCase(v)) {
						// columnValues.remove(i);
						break;
					}
				}
			}

			if (columnValues.size() > 20) {
				columnValues.subList(20, columnValues.size()).clear();
			}
			cvc.getTableMap().getTable(tableName).getColumn(columnName).setColumnValues(columnValues);
		}
		Vector<String> solvedStringConstraint = cvc.getStringSolver().solveConstraints(strConstr,
				cvc.getResultsetColumns(), cvc.getTableMap(), true);
		for (String str : solvedStringConstraint) {
			str = str.substring(str.indexOf('(') + 1, str.lastIndexOf(')'));
			constr += "\t\t" + str.replace("assert", "") + "\n";
		}
		// @shalini: Added non-null constraints for string selection conditions
		String nonConstr = cg.getAssertNotNullConditionForSQTable(cvc, n.getLeft(), " ",
				cvc.getTableMap().getSQTableByName(jtName), jtColumns, tables, l_index);
		nonConstr += cg.getAssertNotNullConditionForSQTable(cvc, n.getRight(), " ",
				cvc.getTableMap().getSQTableByName(jtName), jtColumns, tables, r_index);
		return "(and" + (constr + nonConstr) + ")";
		// return constr;

	}

	public static String generateConstraintsForStringConditions(GenerateCVC1 cvc, java.util.List<Node> nodes,
			ArrayList<String> jtColumns,
			String jtName, Vector<Table> tables, String tupleIdRight, String tupleIdLeft) throws Exception {
		if (nodes == null || nodes.isEmpty())
			return "";

		String finalConstr = "";
		String finalNonConstr = "";
		Vector<String> allStrConstr = new Vector<>();
		ConstraintGenerator cg = new ConstraintGenerator();

		for (Node n : nodes) {
			String constr = "";
			String left = n.getLeft().getTableNameNo() != null
					? (n.getLeft().getTableNameNo().replaceAll("\\d", "")).toLowerCase()
					: null;
			String right = n.getRight().getTableNameNo() != null
					? (n.getRight().getTableNameNo().replaceAll("\\d", "")).toLowerCase()
					: null;
			int l_index = 0, r_index = 0, l_flag = -1, r_flag = -1;
			// left
			for (Table table : tables) {
				if (table == null)
					continue;
				if (table.getTableName().equals(left)) { // gives col index of t1
					l_index += table.getColumnIndex(n.getLeft().getColumn().getColumnName());
					l_flag = 1;
					break;
				} else
					l_index += table.getNoOfColumn();
			}

			// right
			for (Table table : tables) {
				if (table == null)
					continue;
				if (table.getTableName().equals(right)) // gives col index of t1
				{
					r_index += table.getColumnIndex(n.getRight().getColumn().getColumnName());
					r_flag = 1;
					break;
				} else
					r_index = r_index + table.getNoOfColumn();
			}

			if (l_flag != -1 && r_flag != -1) {
				constr = "(" + jtColumns.get(l_index) + " (select O_" + jtName + " " + tupleIdLeft + " )) ";
				constr += "(" + jtColumns.get(r_index) + " (select O_" + jtName + " " + tupleIdRight + " )) ";
			} else {
				constr = "(" + jtColumns.get(l_index) + " (select O_" + jtName + " " + tupleIdLeft + " )) ";
				constr += n.getRight().getStrConst();
			}

			allStrConstr
					.add("(" + (n.getOperator().equalsIgnoreCase("/=") ? "( not (= " : n.getOperator()) + " " + constr
							+ " )" + (n.getOperator().equalsIgnoreCase("/=") ? ")" : ""));

			String s = n.getRight().toString();
			if (s.contains("[")) {
				String tableName = n.getLeft().getTableNameNo().replaceAll("\\d", "");
				String columnName = n.getLeft().getColumn().getColumnName();
				Vector<String> columnValues = cvc.getTableMap().getTable(tableName).getColumn(columnName)
						.getColumnValues();
				if (cvc.getStringSolver().generatedStringMap.containsKey(columnName)) {
					String v = cvc.getStringSolver().generatedStringMap.get(columnName);
					for (int i = columnValues.size() - 1; i >= 0; i--) {
						if (columnValues.get(i).equalsIgnoreCase(v)) {
							columnValues.remove(i);
							break;
						}
					}
				}

				if (columnValues.size() > 20) {
					columnValues.subList(20, columnValues.size()).clear();
				}
				cvc.getTableMap().getTable(tableName).getColumn(columnName).setColumnValues(columnValues);
			}

			// @shalini: Added non-null constraints for string selection conditions
			String nonConstr = cg.getAssertNotNullConditionForSQTable(cvc, n.getLeft(), " ",
					cvc.getTableMap().getSQTableByName(jtName), jtColumns, tables, l_index);
			nonConstr += cg.getAssertNotNullConditionForSQTable(cvc, n.getRight(), " ",
					cvc.getTableMap().getSQTableByName(jtName), jtColumns, tables, r_index);
			finalNonConstr += nonConstr;
		}

		Vector<String> solvedStringConstraint = cvc.getStringSolver().solveConstraints(allStrConstr,
				cvc.getResultsetColumns(), cvc.getTableMap(), true);
		for (String str : solvedStringConstraint) {
			str = str.substring(str.indexOf('(') + 1, str.lastIndexOf(')'));
			finalConstr += "\t\t" + str.replace("assert", "") + "\n";
		}

		return "(and " + finalConstr + finalNonConstr + ")";
	}

	/**
	 * Gets constraints for nodes which are involved in join conditions where each
	 * node is in different from clause sub queries
	 * 
	 * @param cvc
	 * @param queryBlock
	 * @param n1
	 * @param n2
	 * @param operator
	 * @return
	 * @throws Exception
	 */
	public static String getConstraintsForJoinsInDiffSubQueryBlocks(GenerateCVC1 cvc, QueryBlockDetails queryBlock,
			Node n1, Node n2, String operator) throws Exception {
		String constraintString = "";

		int leftGroup = 1, rightGroup = 1;

		/** get number of groups for each node */
		leftGroup = UtilsRelatedToNode.getNoOfGroupsForThisNode(cvc, queryBlock, n1);

		rightGroup = UtilsRelatedToNode.getNoOfGroupsForThisNode(cvc, queryBlock, n2);

		/** Get the details of each node */
		String t1 = getTableName(n1);
		String t2 = getTableName(n2);
		int pos1 = cvc.getTableMap().getTable(t1).getColumnIndex(getColumn(n1).getColumnName());
		int pos2 = cvc.getTableMap().getTable(t2).getColumnIndex(getColumn(n2).getColumnName());

		String r1 = getTableNameNo(n1);
		String r2 = getTableNameNo(n2);
		int offset1 = cvc.getRepeatedRelNextTuplePos().get(r1)[1];
		int offset2 = cvc.getRepeatedRelNextTuplePos().get(r2)[1];

		/** Get number of tuples of each relation occurrence */
		int tuples1 = 0, tuples2 = 0;
		if (cvc.getNoOfTuples().containsKey(r1)) {
			tuples1 = cvc.getNoOfTuples().get(r1);
		}
		if (cvc.getNoOfTuples().containsKey(r2)) {
			tuples2 = cvc.getNoOfTuples().get(r2);
		}
		ConstraintGenerator constrGen = new ConstraintGenerator();
		ArrayList<ConstraintObject> constrObjList = new ArrayList<ConstraintObject>();

		/** Do a round robin for the smaller value of the group number */
		for (int k = 1, l = 1;; k++, l++) {
			// constraintString += "ASSERT ("+
			// GenerateCVCConstraintForNode.genPositiveCondsForPred(queryBlock, n1,
			// ((k-1)*tuples1+offset1))+ operator +
			// GenerateCVCConstraintForNode.genPositiveCondsForPred(queryBlock, n2,
			// ((l-1)*tuples2+offset2))+");\n";

			/*
			 * ConstraintObject constrObj = new ConstraintObject();
			 * constrObj.setLeftConstraint(constrGen.genPositiveCondsForPred(queryBlock, n1,
			 * ((k-1)*tuples1+offset1)));
			 * constrObj.setRightConstraint(constrGen.genPositiveCondsForPred(queryBlock,
			 * n2, ((l-1)*tuples2+offset2)));
			 * constrObj.setOperator(operator);
			 * constrObjList.add(constrObj);
			 */
			constraintString += constrGen.getAssertConstraint(
					constrGen.genPositiveCondsForPred(queryBlock, n1, ((k - 1) * tuples1 + offset1)), operator,
					constrGen.genPositiveCondsForPred(queryBlock, n2, ((l - 1) * tuples2 + offset2)));
			if (leftGroup > rightGroup) {
				if (l == rightGroup && k < leftGroup)
					l = 0;
				if (k >= leftGroup)
					break;
			} else if (leftGroup < rightGroup) {
				if (l < rightGroup && k == leftGroup)
					k = 0;
				if (l >= rightGroup)
					break;
			} else {/** if tuples1==tuples2 */
				if (l == leftGroup)
					break;
			}
		}
		// constraintString =constrGen.generateANDConstraintsWithAssert(constrObjList);
		return constraintString;
	}

	/**
	 * Gets constraints for nodes which are involved in join conditions where each
	 * node is in different from clause sub queries
	 * 
	 * @param cvc
	 * @param queryBlock
	 * @param n1
	 * @param n2
	 * @param operator
	 * @return
	 * @throws Exception
	 */
	public static String getConstraintsForJoinsInDiffSubQueryBlocks1(GenerateCVC1 cvc, QueryBlockDetails queryBlock,
			Node n1, Node n2, String operator) throws Exception {
		String constraintString = "";

		int leftGroup = 1, rightGroup = 1;

		/** get number of groups for each node */
		leftGroup = UtilsRelatedToNode.getNoOfGroupsForThisNode(cvc, queryBlock, n1);

		rightGroup = UtilsRelatedToNode.getNoOfGroupsForThisNode(cvc, queryBlock, n2);

		/** Get the details of each node */
		String t1 = n1.getColumn().getTableName();
		String t2 = n2.getColumn().getTableName();
		// int pos1 =
		// cvc.getTableMap().getTable(t1).getColumnIndex(n1.getColumn().getColumnName());
		// int pos2 =
		// cvc.getTableMap().getTable(t2).getColumnIndex(n2.getColumn().getColumnName());

		int pos1 = cvc.getTableMap().getTable(t1.toUpperCase()).getColumnIndex(n1.getColumn().getColumnName()); // added
																												// by
																												// rambabu
		int pos2 = cvc.getTableMap().getTable(t2.toUpperCase()).getColumnIndex(n2.getColumn().getColumnName()); // added
																												// by
																												// rambabu

		String r1 = n1.getTableNameNo();
		String r2 = n2.getTableNameNo();
		int offset1 = cvc.getRepeatedRelNextTuplePos().get(r1)[1];
		int offset2 = cvc.getRepeatedRelNextTuplePos().get(r2)[1];

		/** Get number of tuples of each relation occurrence */
		int tuples1 = 0, tuples2 = 0;
		if (cvc.getNoOfTuples().containsKey(r1)) {
			tuples1 = cvc.getNoOfTuples().get(r1);
		}
		if (cvc.getNoOfTuples().containsKey(r2)) {
			tuples2 = cvc.getNoOfTuples().get(r2);
		}
		ConstraintGenerator constrGen = new ConstraintGenerator();
		ArrayList<ConstraintObject> constrObjList = new ArrayList<ConstraintObject>();
		/** Do a round robin for the smaller value of the group number */
		for (int k = 1, l = 1;; k++, l++) {
			// Populate constraint Object list and call AND function
			ConstraintObject constrObj = new ConstraintObject();
			constrObj.setLeftConstraint(
					constrGen.genPositiveCondsForPred(queryBlock, n1, ((k - 1) * tuples1 + offset1)));
			constrObj.setRightConstraint(
					constrGen.genPositiveCondsForPred(queryBlock, n2, ((l - 1) * tuples2 + offset2)));
			constrObj.setOperator(operator);
			constrObjList.add(constrObj);

			// constraintString += "("+
			// GenerateCVCConstraintForNode.genPositiveCondsForPred(queryBlock, n1,
			// ((k-1)*tuples1+offset1))+ operator +
			// GenerateCVCConstraintForNode.genPositiveCondsForPred(queryBlock, n2,
			// ((l-1)*tuples2+offset2))+") AND ";
			if (leftGroup > rightGroup) {
				if (l == rightGroup && k < leftGroup)
					l = 0;
				if (k >= leftGroup)
					break;
			} else if (leftGroup < rightGroup) {
				if (l < rightGroup && k == leftGroup)
					k = 0;
				if (l >= rightGroup)
					break;
			} else {/** if tuples1==tuples2 */
				if (l == leftGroup)
					break;
			}
		}
		constraintString = constrGen.generateANDConstraintsWithAssert(constrObjList);
		return constraintString;
	}

	/**
	 * 
	 * @param cvc
	 * @param queryBlock
	 * @param nulled
	 * @param P0
	 * @return
	 * @throws Exception
	 */
	/** FIXME: What if there are multiple groups in this query block */
	public static String genNegativeConds(GenerateCVC1 cvc, QueryBlockDetails queryBlock, Node nulled, Node P0)
			throws Exception {
		String constraintString = new String();

		if (cvc.isFne()) {
			String tableName = nulled.getTable().getTableName();
			constraintString += "ASSERT NOT EXISTS (i: O_" + tableName + "_INDEX_INT): " +
					"(O_" + GenerateCVCConstraintForNode.cvcMap(nulled.getColumn(), "i") +
					" = O_" + GenerateCVCConstraintForNode.cvcMap(P0.getColumn(), P0) + ");";
		} else {
			/**
			 * Open up FORALL and NOT EXISTS
			 */
			/** Get table names */
			String nulledTableNameNo = nulled.getTableNameNo();
			String tablenameno = P0.getTableNameNo();

			int count1 = -1, count2 = -1;

			/** Get the number of tuples for the both nodes */
			count1 = UtilsRelatedToNode.getNoOfTuplesForThisNode(cvc, queryBlock, nulled);
			count2 = UtilsRelatedToNode.getNoOfTuplesForThisNode(cvc, queryBlock, P0);

			/** Get next position for these tuples */
			int offset1 = cvc.getRepeatedRelNextTuplePos().get(nulledTableNameNo)[1];
			int offset2 = cvc.getRepeatedRelNextTuplePos().get(tablenameno)[1];
			ConstraintGenerator constrGen = new ConstraintGenerator();
			ArrayList<ConstraintObject> constrList = new ArrayList<ConstraintObject>();

			// constraintString += "ASSERT ";

			String tempconstr = "";
			for (int i = 1; i <= count1; i++) {
				for (int j = 1; j <= count2; j++) {
					String left = "", right = "";
					int i1, i2;
					if (nulled.getQueryType() == 1 && queryBlock.getFromClauseSubQueries() != null
							&& queryBlock.getFromClauseSubQueries().size() != 0) {
						left = ConstraintGenerator.getSolverMapping(nulled.getColumn(),
								(i - 1) * cvc.getNoOfTuples().get(nulled.getTableNameNo()) + offset1 + "");
						i1 = (i - 1) * cvc.getNoOfTuples().get(nulled.getTableNameNo()) + offset1;
					} else {
						left = ConstraintGenerator.getSolverMapping(nulled.getColumn(), i + offset1 - 1 + "");
						i1 = i + offset1 - 1;
					}

					if (P0.getQueryType() == 1 && queryBlock.getFromClauseSubQueries() != null
							&& queryBlock.getFromClauseSubQueries().size() != 0) {
						right = ConstraintGenerator.getSolverMapping(P0.getColumn(),
								(j - 1) * cvc.getNoOfTuples().get(P0.getTableNameNo()) + offset2 + "");
						i2 = (j - 1) * cvc.getNoOfTuples().get(P0.getTableNameNo()) + offset2;
					} else {
						right = ConstraintGenerator.getSolverMapping(P0.getColumn(), j + offset2 - 1 + "");
						i2 = j + offset2 - 1;
					}
					ConstraintObject conObj = new ConstraintObject();
					conObj.setLeftConstraint(left);
					conObj.setRightConstraint(right);
					conObj.setOperator("/=");
					constrList.add(conObj);

					Column cntCol1 = nulled.getTable().getColumn(nulled.getTable().getNoOfColumn() - 1); // added by
																											// sunanda
																											// for count
					ConstraintObject constrObj = new ConstraintObject();
					constrObj.setLeftConstraint(
							ConstraintGenerator.smtMap(cntCol1, ConstraintGenerator.ctx.mkInt(i1)).toString());
					constrObj.setOperator(">");
					constrObj.setRightConstraint(ConstraintGenerator.ctx.mkInt(0).toString());

					ConstraintObject constrObj1 = new ConstraintObject();

					Column cntCol2 = P0.getTable().getColumn(P0.getTable().getNoOfColumn() - 1); // added by sunanda for
																									// count
					constrObj1.setLeftConstraint(
							ConstraintGenerator.smtMap(cntCol2, ConstraintGenerator.ctx.mkInt(i2)).toString());
					constrObj1.setOperator(">");
					constrObj1.setRightConstraint(ConstraintGenerator.ctx.mkInt(0).toString());

					if (Configuration.getProperty("cntFlag").equalsIgnoreCase("true")) {
						constrList.add(constrObj);
						constrList.add(constrObj1);
					}
					tempconstr += constrGen.generateSMTAndConstraints(constrList, null);
				}
			}
			constraintString = constrGen.getAssertConstraint(constrGen.generateSMTOrConstraints(null, tempconstr));
			// constraintString = constrGen.generateANDConstraintsWithAssert(constrList);//
			// constraintString.substring(0,
			// constraintString.length()-4);
			// constraintString += ";";
		}
		return constraintString;
	}

	/**
	 * 
	 * @param cvc
	 * @param queryBlock
	 * @param nulled
	 * @param P0
	 * @return
	 */
	/** FIXME: What if there are multiple groups in this query block */
	public static String genNegativeConds(GenerateCVC1 cvc, QueryBlockDetails queryBlock, Column nulled, Node P0) {
		String constraintString = new String();
		ArrayList<ConstraintObject> constrList = new ArrayList<ConstraintObject>();
		ConstraintGenerator constrGen = new ConstraintGenerator();

		if (cvc.isFne()) {
			constraintString += "ASSERT NOT EXISTS (i: O_" + nulled.getTableName() + "_INDEX_INT): " +
					"(O_" + GenerateCVCConstraintForNode.cvcMap(nulled, "i") + " = O_"
					+ GenerateCVCConstraintForNode.cvcMap(P0.getColumn(), P0) + ");";
		} else {

			/** Open up FORALL and NOT EXISTS */

			// constraintString += "ASSERT ";
			checkRepeatedRelations(cvc, cvc.cloneNoOfOutputTuples()); // TEMPCODE Rahul Sharma to handle repeated
																		// relations
			for (int i = 1; i <= cvc.getNoOfOutputTuples(nulled.getTableName()); i++) {/**
																						 * FIXME: Handle repeated
																						 * relations
																						 */
				// constraintString += "(O_" + GenerateCVCConstraintForNode.cvcMap(nulled, i +
				// "") + " /= O_" + GenerateCVCConstraintForNode.cvcMap(P0.getColumn(), P0) + ")
				// AND ";
				ConstraintObject constr = new ConstraintObject();
				constr.setLeftConstraint(ConstraintGenerator.getSolverMapping(nulled, i + ""));
				constr.setOperator("/=");
				constr.setRightConstraint(ConstraintGenerator.getSolverMapping(P0.getColumn(), P0));
				constrList.add(constr);
			}
			constraintString = constrGen.generateANDConstraintsWithAssert(constrList);// constraintString.substring(0,
																						// constraintString.length()-4);
			// constraintString += ";";
		}
		return constraintString;
	}

	/**
	 * TEMPCODE Rahul Sharma : to check if there is repeated relations, and remove
	 * them
	 * 
	 * @param cvc
	 * @param noOfOutputTuples
	 */
	private static void checkRepeatedRelations(GenerateCVC1 cvc, HashMap<String, Integer> noOfOutputTuples) {
		// TODO Auto-generated method stub
		HashMap<String, Integer> tempMap = new HashMap<>(noOfOutputTuples.size());
		for (Map.Entry<String, Integer> entry : noOfOutputTuples.entrySet()) {
			// tempMap.put(entry.getKey().toLowerCase(), entry.getValue());
			tempMap.put(entry.getKey().toUpperCase(), entry.getValue());
		}
		cvc.setNoOfOutputTuples(tempMap);
	}

	public static String genNegativeCondsEqClass(GenerateCVC1 cvc, QueryBlockDetails queryBlock, Node c1, Node c2,
			int tuple) {
		String constraintString = new String();
		ArrayList<ConstraintObject> constrList = new ArrayList<ConstraintObject>();
		ConstraintGenerator constrGen = new ConstraintGenerator();

		for (int i = 1; i <= cvc.getNoOfOutputTuples(c1.getTable().getTableName()); i++) {
			ConstraintObject constr = new ConstraintObject();
			constr.setLeftConstraint(ConstraintGenerator.getSolverMapping(c1.getColumn(), i + ""));
			constr.setOperator("/=");
			constr.setRightConstraint(ConstraintGenerator.getSolverMapping(c2.getColumn(), tuple + ""));
			constrList.add(constr);
		}
		// constraintString = constraintString.substring(0,
		// constraintString.length()-4);
		constraintString = constrGen.generateANDConstraintsWithAssert(constrList);
		return constraintString.trim();
	}

	public static String genNegativeCondsEqClassForTuplePair(GenerateCVC1 cvc, QueryBlockDetails queryBlock, Node c1,
			Node c2, int tupleIndex1, int tupleIndex2) {

		String constraintString = new String();
		ConstraintGenerator constrGen = new ConstraintGenerator();

		constraintString = constrGen.getAssertConstraint(cvc, c1.getColumn(), tupleIndex1, c2.getColumn(), tupleIndex2,
				"/=");

		/*
		 * constraintString += "ASSERT ";
		 * constraintString += "(O_" +
		 * GenerateCVCConstraintForNode.cvcMap(c1.getColumn(), tupleIndex1 + "") +
		 * " /= O_" + GenerateCVCConstraintForNode.cvcMap(c2.getColumn(), tupleIndex2 +
		 * "") + ") AND ";
		 * 
		 * constraintString = constraintString.substring(0,
		 * constraintString.length()-4);
		 * constraintString += ";";
		 */

		return constraintString;
	}

	public static ArrayList<ConstraintObject> genNegativeCondsEqClassForAllTuplePairs(GenerateCVC1 cvc,
			QueryBlockDetails queryBlock, Node c1, Node c2, int tupleIndex1, int tupleIndex2) {
		String constraintString = new String();
		ConstraintGenerator constrGen = new ConstraintGenerator();
		ArrayList<ConstraintObject> constrList = new ArrayList<ConstraintObject>();

		for (int i = 1; i <= tupleIndex1; i++) {
			for (int j = 1; j <= tupleIndex2; j++) {

				ConstraintObject constr = new ConstraintObject();
				constr.setLeftConstraint(ConstraintGenerator.getSolverMapping(c1.getColumn(), i + ""));
				constr.setOperator("/=");
				constr.setRightConstraint(ConstraintGenerator.getSolverMapping(c2.getColumn(), j + ""));
				constrList.add(constr);
			}
		}
		// constraintString = constrGen.generateANDConstraintsWithAssert(constrList);
		// return constraintString.trim();
		return constrList;
	}

	/**
	 * Generates positive constraints for the given set of nodes
	 * 
	 * @param ec
	 */
	public static String genPositiveConds(GenerateCVC1 cvc, Vector<Node> ec) {

		String constraintString = "";

		for (int i = 0; i < ec.size() - 1; i++) {
			Column col1 = ec.get(i).getColumn();
			Column col2 = ec.get(i + 1).getColumn();

			constraintString += ConstraintGenerator.getPositiveStatement(col1, ec.get(i), col2, ec.get(i + 1));
		}
		return constraintString;
	}

}
