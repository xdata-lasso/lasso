package generateConstraints;

import java.io.File;
//imports by deeksha
import java.io.FileWriter;
import java.io.IOException;
import java.lang.invoke.StringConcatException;
import java.time.LocalDate;
// import javax.swing.Group;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.microsoft.z3.ArithExpr;
import com.microsoft.z3.ArrayExpr;
import com.microsoft.z3.ArraySort;
import com.microsoft.z3.BoolExpr;
import com.microsoft.z3.Constructor;
import com.microsoft.z3.Context;
import com.microsoft.z3.DatatypeExpr;
import com.microsoft.z3.DatatypeSort;
import com.microsoft.z3.EnumSort;
import com.microsoft.z3.Expr;
import com.microsoft.z3.FuncDecl;
import com.microsoft.z3.IntExpr;
import com.microsoft.z3.IntSort;
import com.microsoft.z3.Params;
import com.microsoft.z3.Quantifier;
import com.microsoft.z3.RealExpr;
import com.microsoft.z3.Solver;
import com.microsoft.z3.Sort;

import GenConstraints.GenConstraints;
import parsing.AggregateFunction;
import parsing.CaseCondition;
import parsing.Column;
import parsing.ConjunctQueryStructure;
import parsing.MutationStructure;
import parsing.Node;
import parsing.Table;
import stringSolver.StringConstraint;
import testDataGen.DataType;
import testDataGen.GenerateCVC1;
import testDataGen.QueryBlockDetails;
import testDataGen.levelStrcuture;
import util.Configuration;
import util.ConstraintObject;
import util.Utilities;

import net.sf.jsqlparser.statement.create.table.ColDataType;
import java.util.AbstractMap;

/**
 * This class generates the constraints based on solver in XData.Properties file
 * 
 * @author shree
 *
 */
// FIXME: Needs fine tuning - methods can be combined adding more parameters in
// constraint object.

public class ConstraintGenerator {
	private static Logger logger = Logger.getLogger(ConstraintGenerator.class.getName());
	private static boolean isCVC3 = false;
	private String constraintSolver;
	private static String solverSpecificCommentCharacter;
	private static boolean isTempJoin = false;
	private static boolean usingCnt = false;

	// deeksha comment : API call Context()
	// ----------------------------------------------------------------
	public static Context ctx = new Context();
	public static Solver solver = ctx.mkSolver();
	// --------------------------------------------------------------------
	// TODO: rename ctxSorts to something more meaningful; it has declarations other
	// than sorts
	public static HashMap<String, Sort> ctxSorts = new HashMap<String, Sort>(); // for storing Z3 context sorts; not
																				// able to extract directly from ctx.
	public static HashMap<String, FuncDecl> ctxFuncDecls = new HashMap<String, FuncDecl>(); // for storing Z3 context //
																							// chaitra changed to public
																							// function declarations
	public static HashMap<String, Expr> ctxConsts = new HashMap<String, Expr>();

	private static IntExpr intNull = ctx.mkIntConst("intNullVal");
	private static RealExpr realNull = ctx.mkRealConst("realNullVal");
	public static String enumArrayIndex = "";
	public static String enumIndexVar = "";

	/**
	 * Constructor
	 */
	public ConstraintGenerator() {
		setConstraintSolver(Configuration.getProperty("smtsolver"));
		if (Configuration.isEnumInt.equalsIgnoreCase("true")) {
			enumArrayIndex = Configuration.enumArrayIndex;
			enumIndexVar = Configuration.enumIndexVar;
		}
		// enumArrayIndex = enumArrayIndex.replaceAll("^\"|\"$", "");
		// enumIndexVar = enumIndexVar.replaceAll("^\"|\"$", "");

		this.isCVC3 = false;
		solverSpecificCommentCharacter = ";";

		if (Configuration.getProperty("tempJoins").equalsIgnoreCase("true")) {
			this.isTempJoin = true;
		} else {
			this.isTempJoin = false;
		}
	}

	/*
	 * Returns the Z3 context
	 */
	public Context getCtx() {
		return ctx;
	}

	public void clearContext() {
		ctxSorts = new HashMap<String, Sort>(); // for storing Z3 context sorts; not // able to extract directly from
												// ctx.
		ctxFuncDecls = new HashMap<String, FuncDecl>(); // for storing Z3 context // function declarations
		ctxConsts = new HashMap<String, Expr>();
		// ctx = new Context(); // tred ths but ddt wor
		// solver = ctx.mkSolver();
	}

	/*
	 * Returns the Z3 solver corresponding to context
	 */
	public Solver getSolver() {
		return solver;
	}

	/*
	 * Returns the CtxFuncDecl structure
	 */
	public static HashMap<String, FuncDecl> getCtxFuncDecl() {
		return ctxFuncDecls;
	}

	/**
	 * This method takes in the col name, table name, offset and position for
	 * columns on which the constraint is to be generated.
	 * This also takes the operator that joins the constraints. Checks the
	 * ConstraintContext for CVC/SMT.
	 * If it is CVC, it returns CVC format constraint, otherwise return SMT format
	 * constraint.
	 * 
	 * @param cvc
	 * @param tableName1
	 * @param offset1
	 * @param pos1
	 * @param tableName2
	 * @param offset2
	 * @param pos2
	 * @param col1
	 * @param col2
	 * @param operator
	 * @return
	 */

	public ConstraintObject getConstraint(String tableName1, Integer offset1, Integer pos1, String tableName2,
			Integer offset2, Integer pos2,
			Column col1, Column col2, String operator) {

		ConstraintObject con = new ConstraintObject();

		con.setLeftConstraint(
				tableName1 + "_" + col1.getColumnName() + pos1 + " (select O_" + tableName1 + " " + offset1 + ")");
		con.setRightConstraint(
				tableName2 + "_" + col2.getColumnName() + pos2 + " (select O_" + tableName2 + " " + offset2 + ")");
		con.setOperator(operator.toLowerCase());

		return con;
	}

	/**
	 * This method returns an assert constraint statement for the passed in columns
	 * and tupleIndices based on the solver.
	 * 
	 * @param cvc
	 * @param c1
	 * @param index1
	 * @param c2
	 * @param index2
	 * @param operator
	 * @return
	 */
	public String getAssertConstraint(GenerateCVC1 cvc, Column c1, Integer index1, Column c2, Integer index2,
			String operator) {

		String constraint = "";

		Expr smtIndex1 = (IntExpr) ctx.mkInt(index1);
		Expr smtIndex2 = (IntExpr) ctx.mkInt(index2);
		if (Configuration.isEnumInt.equalsIgnoreCase("true")) {
			EnumSort currentSort = (EnumSort) ConstraintGenerator.ctxSorts.get(cvc.enumArrayIndex);
			smtIndex1 = ctx.mkConst(cvc.enumIndexVar + Integer.toString(index1), currentSort);
			smtIndex2 = ctx.mkConst(cvc.enumIndexVar + Integer.toString(index1), currentSort);

		}
		constraint += "(assert (" + (operator.trim().equals("/=") ? "not (= " : operator) + " "
				+ smtMap(c1, smtIndex1) + " " + smtMap(c2, smtIndex2) + (operator.trim().equals("/=") ? ")" : "")
				+ ")) \n";

		return constraint;
	}

	/**
	 * This method returns an assert constraint statement for the passed in columns
	 * and tupleIndices based on the solver.
	 * 
	 * @param cvc
	 * @param c1
	 * @param index1
	 * @param c2
	 * @param index2
	 * @param operator
	 * @return
	 */
	public String getAssertConstraint(String constraint) {

		String constr = "";

		constr += "(assert " + constraint + ") \n";

		return constr;
	}

	/**
	 * 
	 * @param constraint1
	 * @param operator
	 * @param constraint2
	 * @return
	 */
	public String getAssertConstraint(String constraint1, String operator, String constraint2) {
		String constraint = "";

		constraint += "(assert (" + (operator.equals("/=") ? "not (= " : operator) + "  " + constraint1 + "  "
				+ constraint2 + (operator.equals("/=") ? " )" : " ") + " )) \n";
		if (constraint.length() < 11) {
			return "";
		}

		return constraint;
	}

	/**
	 * This method returns an assert constraint statement for the passed in columns
	 * and tupleIndices based on the solver.
	 * 
	 * @param cvc
	 * @param c1
	 * @param index1
	 * @param c2
	 * @param index2
	 * @param operator
	 * @return
	 */
	public String getAssertConstraint(String tableName1, Column col1, Integer index1, Integer pos1, String tableName2,
			Column col2, Integer index2, Integer pos2, String operator) {

		String constraint = "";

		constraint += "(assert (" + (operator.equals("/=") ? "not (= " : operator) +
				" (" + tableName1 + "_" + col1.getColumnName() + pos1 + " (select O_" + tableName1 + " " + index1
				+ "))" + " ("
				+ tableName2 + "_" + col2.getColumnName() + pos2 + " (select O_" + tableName2 + " " + index2 + "))"
				+ (operator.equals("/=") ? ")" : "") + ")) \n";

		return constraint;
	}

	/**
	 * Generates positive CVC3 constraint for given nodes and columns
	 * 
	 * @param col1
	 * @param n1
	 * @param col2
	 * @param n2
	 * @return
	 */
	public static String getPositiveStatement(Column col1, Node n1, Column col2, Node n2) {

		return "(assert (=" + " " + smtMap(col1, n1) + " " + smtMap(col2, n2) + "))\n";

	}

	// /**
	// * This method returns a String with ISNULL constraint
	// *
	// * @param cvc
	// * @param col
	// * @param offSet
	// * @return
	// */
	// public String getIsNullCondition(String tableName, Column col, String offSet)
	// {

	// String isNullConstraint = "";

	// if (col.getCvcDatatype().equals("INT") || col.getCvcDatatype().equals("REAL")
	// || col.getCvcDatatype().equals("DATE")
	// || col.getCvcDatatype().equals("TIME") ||
	// col.getCvcDatatype().equals("TIMESTAMP")) {
	// isNullConstraint = "ISNULL_" + col.getColumnName() + "(" + cvcMap(col, offSet
	// + "") + ")";
	// } else {
	// isNullConstraint = "ISNULL_" + col.getCvcDatatype() + "(" + cvcMap(col,
	// offSet + "") + ")";
	// }
	// return isNullConstraint;
	// }

	// /**
	// * This method returns an Expr with ISNULL constraint (for Z3)
	// *
	// * @param cvc
	// * @param col
	// * @param offSet
	// * @return
	// */
	// public BoolExpr getIsNullConditionZ3(GenerateCVC1 cvc, String tableName,
	// Column col, String offSet) {
	// String suffix;
	// // isnull function required add count > 0 in above function sunanda

	// if (col.getCvcDatatype().equalsIgnoreCase("INT") ||
	// col.getCvcDatatype().equalsIgnoreCase("REAL")
	// || col.getCvcDatatype().equalsIgnoreCase("DATE")
	// || col.getCvcDatatype().equalsIgnoreCase("TIME")
	// || col.getCvcDatatype().equalsIgnoreCase("TIMESTAMP")) {
	// suffix = col.getColumnName();
	// } else {
	// suffix = col.getCvcDatatype();
	// }

	// FuncDecl isNullDecl = ctxFuncDecls.get("ISNULL_" + suffix);
	// BoolExpr isNullApply = (BoolExpr) isNullDecl.apply(smtMap(col, (IntExpr)
	// ctx.mkInt(offSet)));
	// // Column cntCol =
	// //
	// cvc.getTableMap().getTable(tableName.toUpperCase()).getColumn(cvc.getTableMap().getTable(tableName.toUpperCase()).getNoOfColumn()-1);
	// // BoolExpr andWithCount = ctx.mkAnd(ctx.mkGt((ArithExpr)smtMap(cntCol,
	// // (IntExpr) ctx.mkInt(offSet)), ctx.mkInt(0)), isNullApply);
	// return isNullApply;
	// }

	/**
	 * This method takes in the ConstraintObject List as input and generates a
	 * constraint String AND'ing all conditions.
	 * The returned string holds the AND'ed constraints in SMT or CVC format.
	 * 
	 * @param cvc
	 * @param constraintList
	 * @return
	 */
	public String generateANDConstraints(ArrayList<ConstraintObject> constraintList) {
		String constraint = "";

		constraint = generateSMTAndConstraints(constraintList, null);

		return constraint;
	}

	/**
	 * This method takes in the ConstraintObject List as input and generates an
	 * ASSERT constraint String AND'ing all conditions.
	 * The returned string holds the AND'ed constraints in SMT or CVC format.
	 * 
	 * @param cvc
	 * @param constraintList
	 * @return
	 */

	public String generateANDConstraintsWithAssert(ArrayList<ConstraintObject> constraintList) {
		String constraint = "";

		constraint = "\n (assert " + generateSMTAndConstraints(constraintList, null) + ") \n";

		return constraint;
	}

	public String revertAndToOR(String constraintString) {
		String constraint = "";
		String constraint1 = "";

		if (constraintString.contains("(and ")) {
			constraint1 += constraintString.replaceAll("\\(and", "(or");

			constraint += "(assert " + constraint1 + ") \n";
		} else
			constraint = constraintString;

		return constraint;
	}

	// /**
	// * This method returns constraintString for primary keys with =>. It takes
	// left
	// * and right constraint strings and adds => on them and returns new string.
	// *
	// * @param cvc
	// * @param impliedConObj
	// * @param isImplied
	// * @return
	// */
	// public String getImpliedConstraints(ConstraintObject impliedConObj, boolean
	// isImplied) {
	// String constrString = "";
	// if (isCVC3) {
	// if (isImplied) {
	// constrString = "ASSERT (" + impliedConObj.getLeftConstraint() + " " +
	// impliedConObj.getOperator() + " "
	// + impliedConObj.getRightConstraint() + ");\n";
	// } else {
	// constrString = "ASSERT (" + impliedConObj.getLeftConstraint() + ") " +
	// impliedConObj.getOperator()
	// + " TRUE; \n";
	// }
	// } else {
	// if (isImplied) {
	// constrString = "\n (assert (=> \n\t" + impliedConObj.getLeftConstraint() + "
	// "
	// + impliedConObj.getRightConstraint() + "\n))";
	// } else {
	// constrString = "\n (assert (=> \n\t" + impliedConObj.getLeftConstraint() + "
	// true)) ";
	// }
	// }
	// return constrString;
	// }

	/**
	 * This method takes in the ConstraintObject List as input and generates a
	 * constraint String OR'ing all conditions.
	 * The returned string holds the OR'ed constraints in SMT or CVC format.
	 * 
	 * @param cvc
	 * @param constraintList
	 * @return
	 */
	public String generateOrConstraints(ArrayList<ConstraintObject> constraintList) {
		String constraint = "";

		constraint = generateSMTOrConstraints(constraintList, null);

		return constraint;
	}

	/**
	 * This method takes in the ConstraintObject List as input and generates an
	 * ASSERT constraint String OR'ing all conditions.
	 * The returned string holds the OR'ed constraints in SMT or CVC format.
	 * 
	 * @param cvc
	 * @param constraintList
	 * @return
	 */
	public String generateOrConstraintsWithAssert(ArrayList<ConstraintObject> constraintList) {
		String constraint = "";

		if (generateSMTOrConstraints(constraintList, null) != null
				&& !generateSMTOrConstraints(constraintList, null).isEmpty()) {

			if (Configuration.getProperty("tempJoins").equalsIgnoreCase("true")) {
				isTempJoin = true;
			} else {
				isTempJoin = false;
			}

			if (isTempJoin) {
				String constr, declare = "";
				int st_index = 0, end_index = 0;
				boolean inside = false;
				constr = generateSMTOrConstraints(constraintList, null);
				while (constr.indexOf("(declare-datatypes ()") != -1) {
					inside = true;
					st_index = constr.indexOf("(declare-datatypes ()");
					end_index = constr.indexOf("_TupleType))") + 12;
					if (!declare.contains(constr.substring(st_index, end_index)))
						declare += constr.substring(st_index, end_index) + " \n";
					constr = constr.substring(0, st_index) + constr.substring(end_index);
				}
				if (constr.isEmpty())
					constraint = "";
				else
					constraint = declare + "\n (assert " + constr + ") \n";
			} else
				constraint = "\n (assert " + generateSMTOrConstraints(constraintList, null) + ") \n";
		}

		return constraint;
	}

	public String generateSMTAndConstraints(ArrayList<ConstraintObject> constraintList, String constraintStr) {
		String constr1 = "";

		for (ConstraintObject con : constraintList) {
			constr1 = getSMTAndConstraint(con, constr1, constraintList);

			constraintStr = constr1 + "\t";

		}

		if (constraintStr == null || constraintStr == "") {
			return "";
		} else if (constraintList != null) {
			constraintStr = " (and " + constraintStr + ")";
		}
		return constraintStr;
	}

	public String generateSMTOrConstraints(ArrayList<ConstraintObject> constraintList, String constraintStr) {

		String constr1 = "";
		if (constraintList == null && constraintStr != null) {
			return " (or " + constraintStr + ")";
		}
		for (ConstraintObject con : constraintList) {
			// constraintStr += getSMTOrConstraint(con,constraintStr);
			constr1 = getSMTOrConstraint(con, constr1, constraintList);
			if (!constr1.isEmpty())
				constraintStr = constr1 + "\n\t\t";
		}

		if (constraintStr == null || constraintStr == "") {
			constraintStr = "";
		} else if (constraintList != null && constraintList.size() > 1) {
			constraintStr = " (or " + constraintStr + ")";
		}
		return constraintStr;
	}

	/**
	 * This method will return SMT constraints of the form (or (StringValue)
	 * (distinct (colname tableNameNo_colName)(colName tableNameNo_colName)) )
	 * StringValue holds the previous constraint of same form thus forming nested
	 * structure as required for SMT.
	 * 
	 * @param con
	 * @param s1
	 * @return
	 */

	public String getSMTAndConstraint(ConstraintObject con, String s1, ArrayList<ConstraintObject> conList) {
		// to be done using api comment by deeksha
		String cvcStr = "";

		if (s1 != null && !s1.isEmpty() || (s1 != null && !s1.isEmpty() && conList != null && conList.size() > 1)) {
			// cvcStr += " (and ";
			cvcStr += s1;
		}
		if (con != null) {

			String Rightconstr = "";
			String Leftconstr = "";
			///
			if ((con.getRightConstraint() != null && !con.getRightConstraint().isEmpty())) {
				Rightconstr = con.getRightConstraint().trim();

				int st_index = Rightconstr.indexOf("(assert");
				while (st_index != -1) {
					// Rightconstr.replaceFirst("(assert", " ");
					Leftconstr = Rightconstr.substring(0, st_index) + Leftconstr.substring(st_index + 7);
					int count = 1;
					int end_index = st_index + 1;
					for (; end_index < Rightconstr.length(); end_index++) {
						if (Rightconstr.charAt(end_index) == '(')
							count++;
						else if (Rightconstr.charAt(end_index) == ')')
							count--;
						if (count == 0) {
							Rightconstr = Rightconstr.substring(0, end_index) + Rightconstr.substring(end_index + 1);
							st_index = Rightconstr.indexOf("(assert");
							break;
						}

					}
					if (end_index == Rightconstr.length())
						break;
				}

			}

			if ((con.getLeftConstraint() != null && !con.getLeftConstraint().isEmpty())) {
				Leftconstr = con.getLeftConstraint().trim();
				int st_index = Leftconstr.indexOf("(assert");
				while (st_index != -1) {
					Leftconstr = Leftconstr.substring(0, st_index) + Leftconstr.substring(st_index + 7);
					// Leftconstr.replaceFirst(" assert ", " ");
					int count = 1;
					int end_index = st_index + 1;
					for (; end_index < Leftconstr.length(); end_index++) {
						if (Leftconstr.charAt(end_index) == '(')
							count++;
						else if (Leftconstr.charAt(end_index) == ')')
							count--;
						if (count == 0) {
							Leftconstr = Leftconstr.substring(0, end_index) + Leftconstr.substring(end_index + 1);
							st_index = Leftconstr.indexOf("(assert");
							break;
						}

					}
					if (end_index == Leftconstr.length())
						break;
				}

			}

			// If else statements are added to get the matching brackets based on the
			// operator and constraint

			if ((con.getOperator() != null && !con.getOperator().isEmpty())
					&& (con.getRightConstraint() != null && !con.getRightConstraint().isEmpty())) {

				cvcStr += "";
				if ((con.getOperator() != null && !(con.getOperator().isEmpty()))) {
					cvcStr += "(";
					if (con.getOperator().equals("/=")) {
						cvcStr += "not (= ";
					} else {
						cvcStr += con.getOperator() + " ";
					}
				} else {
					cvcStr += " ";
				}

				if (con.getLeftConstraint() != null && !con.getLeftConstraint().isEmpty()) {
					if (Leftconstr.trim().startsWith("(")) {
						cvcStr += Leftconstr + " ";
					} else {
						cvcStr += " (" + Leftconstr + ") ";
					}
				} else {
					cvcStr += " ";
				}

				if (con.getRightConstraint() != null && !con.getRightConstraint().isEmpty()) {
					if (isIntOrReal(con.getRightConstraint()) || Rightconstr.trim().startsWith("(")) {
						cvcStr += Rightconstr;
					} else {
						cvcStr += "(" + Rightconstr + ")";
					}
				} else {
					cvcStr += " ";
				}

				if ((con.getOperator() != null && !(con.getOperator().isEmpty()))) {
					if (con.getOperator().equals("/=")) {
						cvcStr += "))";
					} else {
						cvcStr += ")";
					}
				} else {
					cvcStr += " ";
				}

			} else {
				if (!Leftconstr.isEmpty())
					cvcStr += Leftconstr.trim().startsWith("(") ? " " + Leftconstr + " " : " (" + Leftconstr + ") ";
			}
		}
		if (s1 != null && !s1.isEmpty() || (s1 != null && !s1.isEmpty() && conList != null && conList.size() > 1)) {
			// cvcStr +=") ";
		}
		return cvcStr;
	}

	/**
	 * This method will return SMT constraints of the form (or (StringValue)
	 * (distinct (colname tableNameNo_colName)(colName tableNameNo_colName)) )
	 * StringValue holds the previous constraint of same form thus forming nested
	 * structure as required for SMT.
	 * 
	 * @param con
	 * @param s1
	 * @return
	 */
	public String getSMTOrConstraint(ConstraintObject con, String s1, ArrayList<ConstraintObject> conList) {

		String cvcStr = "";

		if (s1 != null && !s1.isEmpty() || (s1 != null && !s1.isEmpty() && conList != null && conList.size() > 1)) {
			// cvcStr += " (or ";
			cvcStr += s1;
		}

		if (con != null) {

			String Rightconstr = "";
			String Leftconstr = "";
			/// Code to remove nested assert string
			if ((con.getRightConstraint() != null && !con.getRightConstraint().isEmpty())) {
				Rightconstr = con.getRightConstraint().trim();

				int st_index = Rightconstr.indexOf("(assert");
				while (st_index != -1) {
					Leftconstr = Rightconstr.substring(0, st_index) + Leftconstr.substring(st_index + 7);
					int count = 1;
					int end_index = st_index + 1;
					for (; end_index < Rightconstr.length(); end_index++) {
						if (Rightconstr.charAt(end_index) == '(')
							count++;
						else if (Rightconstr.charAt(end_index) == ')')
							count--;
						if (count == 0) {
							Rightconstr = Rightconstr.substring(0, end_index) + Rightconstr.substring(end_index + 1);
							st_index = Rightconstr.indexOf("(assert");
							break;
						}

					}
					if (end_index == Rightconstr.length())
						break;
				}

			}

			if ((con.getLeftConstraint() != null && !con.getLeftConstraint().isEmpty())) {
				Leftconstr = con.getLeftConstraint().trim();
				int st_index = Leftconstr.indexOf("(assert");
				while (st_index != -1) {
					Leftconstr = Leftconstr.substring(0, st_index) + Leftconstr.substring(st_index + 7);
					int count = 1;
					int end_index = st_index + 1;
					for (; end_index < Leftconstr.length(); end_index++) {
						if (Leftconstr.charAt(end_index) == '(')
							count++;
						else if (Leftconstr.charAt(end_index) == ')')
							count--;
						if (count == 0) {
							Leftconstr = Leftconstr.substring(0, end_index) + Leftconstr.substring(end_index + 1);
							st_index = Leftconstr.indexOf("(assert");
							break;
						}

					}
					if (end_index == Leftconstr.length())
						break;
				}

			}

			if ((con.getOperator() != null && !con.getOperator().isEmpty()) && (con.getRightConstraint() != null
					&& !con.getRightConstraint().isEmpty())) {

				cvcStr += "";
				// If else statements are added to get the matching brackets based on the
				// operator and constraint

				if (con.getOperator() != null && !(con.getOperator().isEmpty())) {
					cvcStr += "(";
					if (con.getOperator().equals("/=")) {
						cvcStr += "not (= ";
					} else {
						cvcStr += con.getOperator() + " ";
					}
				} else {
					cvcStr += " ";
				}

				if (con.getLeftConstraint() != null && !con.getLeftConstraint().isEmpty()) {
					if (Leftconstr.trim().startsWith("(")) {
						cvcStr += Leftconstr + " ";
					} else {
						cvcStr += " (" + Leftconstr + ") ";
					}
				} else {
					cvcStr += " ";
				}

				if (con.getRightConstraint() != null && !con.getRightConstraint().isEmpty()) {
					if ((isIntOrReal(con.getRightConstraint()) || Rightconstr.trim().startsWith("("))) {
						cvcStr += Rightconstr;
					} else {
						cvcStr += "(" + Rightconstr + ")";
					}
				} else {
					cvcStr += " ";
				}

				if (con.getOperator() != null && !(con.getOperator().isEmpty())) {
					if (con.getOperator().equals("/=")) {
						cvcStr += "))";
					} else {
						cvcStr += ")";
					}
				} else {
					cvcStr += " ";
				}

			} else {
				if (!Leftconstr.isEmpty())
					cvcStr += Leftconstr.trim().startsWith("(") ? (" " + Leftconstr + " ")
							: " (" + con.getLeftConstraint() + ") ";
			}
		}

		return cvcStr;
	}

	/**
	 * This method checks if the parameter passed is Integer or real.
	 * 
	 * @param constraint
	 * @return
	 */
	public boolean isIntOrReal(String constraint) {
		if (constraint.length() > 0 && constraint.matches("[0-9]+")) {
			return true;
		} else if (constraint.length() > 0 && constraint.matches("[0-9]+.[0-9]+")) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * Used to get SMT LIB constraint for this column for the given tuple position
	 * 
	 * @param col
	 * @param fIndex
	 * @return
	 */
	public static Expr smtMap(Column col, Expr fIndex) {
		Table table = col.getTable();
		String tableName = col.getTableName();
		String columnName = col.getColumnName();
		int pos = table.getColumnIndex(columnName);
		Expr colValue = null;
		// relations are represented as ArrayExpr's
		ArrayExpr relation = (ArrayExpr) ctxConsts.get("O_" + tableName);

		DatatypeExpr tuple = (DatatypeExpr) ctx.mkSelect(relation, fIndex);

		DatatypeSort tupSort = (DatatypeSort) tuple.getSort();
		FuncDecl[] tupAccessors = tupSort.getAccessors()[0]; // tuples declared will have only one constructor,
																// hence[0].
		FuncDecl colAccessor = tupAccessors[pos];
		colValue = colAccessor.apply(tuple);
		// }
		return colValue;
	}

	/**
	 * Used to get SMT LIB constraint for this column
	 * 
	 * @param col
	 * @param n
	 * @return
	 */
	public static String smtMap(Column col, Node n) {
		Table table = col.getTable();
		String tableName = col.getTableName();
		String columnName = col.getColumnName();
		String tableNo = n.getTableNameNo();

		int index = Integer.parseInt(tableNo.substring(tableNo.length() - 1));
		int pos = table.getColumnIndex(columnName);

		String smtCond = "";
		// String colName =tableName+"_"+columnName;
		String colName = tableName + "_" + columnName + pos;
		smtCond = "(" + colName + " " + "(select O_" + tableName + " " + index + ") )";
		return smtCond;
	}

	public static Expr smtMap(String arrNameSQ, String index, int isIndexInt, int colIndex) {
		// Parameters :
		// arrNameSQ :- NAME Of relation
		// index :- row number to be selected
		// isIndexInt :- if you want to select variables "i", "j", then pass -1, else
		// pass the integer you want to use, in that case index parameter will be
		// ignored
		// colIndex :- index of column to be selected

		ArrayExpr subqueryRelationSQ = (ArrayExpr) ctxConsts.get(arrNameSQ);
		DatatypeExpr tupleSQ;
		EnumSort currentSort = (EnumSort) ConstraintGenerator.ctxSorts.get(enumArrayIndex);

		if (isIndexInt == -1) {
			Expr[] arrForIndexI = new Expr[] { ctx.mkIntConst(index) };
			if (Configuration.isEnumInt.equalsIgnoreCase("true")) {
				arrForIndexI = new Expr[] { ctx.mkConst(index, currentSort) };
			}
			tupleSQ = (DatatypeExpr) ctx.mkSelect(subqueryRelationSQ, arrForIndexI[0]);

		} else {
			Expr arrForIndex1 = (IntExpr) ctx.mkInt(isIndexInt);
			if (Configuration.isEnumInt.equalsIgnoreCase("true")) {
				arrForIndex1 = ctx.mkConst(enumIndexVar + Integer.toString(isIndexInt), currentSort);
			}
			tupleSQ = (DatatypeExpr) ctx.mkSelect(subqueryRelationSQ, arrForIndex1);

		}

		DatatypeSort tupSortSQ = (DatatypeSort) tupleSQ.getSort();
		FuncDecl[] tupAccessorsSQ = tupSortSQ.getAccessors()[0]; // tuples declared will have only one constructor,
																	// hence[0].

		// Indexing tuple accessor will give you value of particular column after
		// applying on tuple
		FuncDecl colAccessorSQ1 = tupAccessorsSQ[colIndex];

		Expr colValueSQ1 = colAccessorSQ1.apply(tupleSQ);
		return colValueSQ1;

	}

	/**
	 * This method gets the SMT / CVC constraint String mapping the table name,
	 * column name, index, position.
	 * 
	 * @param cvc
	 * @param col
	 * @param n
	 * @return
	 */
	public static String getSolverMapping(Column col, Node n) {

		return smtMap(col, n);

	}

	/**
	 * This method gets the SMT/CVC constraint string mapping for table name, column
	 * name, index, position.
	 * 
	 * @param cvc
	 * @param col
	 * @param index
	 * @return
	 */
	public static String getSolverMapping(Column col, String index) {

		return smtMap(col, (IntExpr) ctx.mkInt(Integer.parseInt(index))).toString();

	}

	/**
	 * Used to get SMT constraint for the given node for the given tuple position
	 * 
	 * @param n
	 * @param index
	 * @return
	 */
	public static String smtMapNode(Node n, String index) {

		if (n.getType().equalsIgnoreCase(Node.getValType())) {
			return getSMTValue(n);
		} else if (n.getType().equalsIgnoreCase(Node.getCastNodeType())) {
			return smtMapNode(n.getLeft(), index);
		} else if (n.getType().equalsIgnoreCase(Node.getColRefType())) {
			EnumSort currentSort = (EnumSort) ConstraintGenerator.ctxSorts.get(enumArrayIndex);
			if (Configuration.isEnumInt.equalsIgnoreCase("true"))
				return smtMap(n.getColumn(), ctx.mkConst(enumIndexVar + index, currentSort)).toString();
			else
				return smtMap(n.getColumn(), (IntExpr) ctx.mkInt(Integer.parseInt(index))).toString();

		} else if (n.getType().toString().equalsIgnoreCase("i")) {
			return "i";
		} else if (n.getType().equalsIgnoreCase(Node.getBroNodeType())
				|| n.getType().equalsIgnoreCase(Node.getBaoNodeType())) {

			return "(" + (n.getOperator().equals("/=") ? "not (= " : n.getOperator()) + " "
					+ smtMapNode(n.getLeft(), index) + " " + smtMapNode(n.getRight(), index)
					+ (n.getOperator().equals("/=") ? ")" : "") + ")";
		} else
			return "";
	}

	// public static String smtMapNode(Node n, String index1, String index2) {

	// if (n.getType().equalsIgnoreCase(Node.getValType())) {
	// return n.getStrConst();
	// } else if (n.getType().equalsIgnoreCase(Node.getColRefType())) {
	// EnumSort currentSort = (EnumSort)
	// ConstraintGenerator.ctxSorts.get(enumArrayIndex);
	// if (Configuration.isEnumInt.equalsIgnoreCase("true"))
	// return smtMap(n.getColumn(), ctx.mkConst(enumIndexVar + index1,
	// currentSort)).toString();
	// else
	// return smtMap(n.getColumn(), (IntExpr)
	// ctx.mkInt(Integer.parseInt(index1))).toString();

	// } else if (n.getType().toString().equalsIgnoreCase("i")) {
	// return "i";
	// } else if (n.getType().equalsIgnoreCase(Node.getBroNodeType())
	// || n.getType().equalsIgnoreCase(Node.getBaoNodeType())) {

	// return "(" + (n.getOperator().equals("/=") ? "not (= " : n.getOperator()) + "
	// "
	// + smtMapNode(n.getLeft(), index1) + " " + smtMapNode(n.getRight(), index2)
	// + (n.getOperator().equals("/=") ? ")" : "") + ")";
	// } else
	// return "";
	// }

	/**
	 * This method returns the constraint for the node and index position based on
	 * solver
	 * 
	 * @param cvc
	 * @param n
	 * @param index
	 * @return
	 */
	public static String getMapNode(Node n, String index) {

		if (smtMapNode(n, index) != null && !smtMapNode(n, index).isEmpty()) {
			return smtMapNode(n, index);
		} else {
			return "";
		}

	}

	// Specific methods for each datatype in solver file
	/**
	 * This method returns the header value for the Solver depending on whether
	 * solver is CVC / SMT
	 * If solver is CVC - it returns nothing
	 * If solver is SMT - it returns all options required for producing required
	 * output.
	 * 
	 * @param cvc
	 * @return
	 */
	public String getHeader() {
		String header = "";

		Params p = ctx.mkParams();
		p.add("produce-models", true); // other options invalid in z3 API
		p.add("smt.macro_finder", true); // check whether this is the right option name
		// p.add("model_compress", false); <-- Gives error for some reason, however this
		// param is set successfully in the .smt file
		solver.setParameters(p); // NOTE: these should be the settings for all solvers

		// header = "(set-logic ALL_SUPPORTED)";
		header += "(set-option :produce-models true)\n (set-option :smt.macro_finder true) \n (set-option :smt.mbqi true) \n";

		BoolExpr[] assertionIntNull = new BoolExpr[2];
		assertionIntNull[0] = ctx.mkEq(ConstraintGenerator.intNull, ctx.mkInt(-99999));
		assertionIntNull[1] = ctx.mkEq(ConstraintGenerator.realNull, ctx.mkReal("-99999.0"));

		header += getNullFuncForDatatype("int", "intNullVal", "-99999");
		header += getNullFuncForDatatype("real", "realNullVal", "-99999.0");

		// header += "\n(declare-fun " + ConstraintGenerator.intNull + " () Int)\n"; //
		// function defination using
		// "define-fun"
		// header += "(assert " + assertionIntNull[0].toString() + ")\n";
		// header += "\n(declare-fun " + ConstraintGenerator.realNull + " () Real)\n";
		// header += "(assert " + assertionIntNull[1].toString() + ")\n\n";

		// if(!ctxSorts.containsKey("DATE")){
		header += getDateDataType();
		getDateAccessors();
		header += getDateFunctions("<");
		header += getDateFunctions(">");
		header += getDateFunctions("=");
		header += getNullFuncForDatatype("DATE", "dateNullVal", "0000-00-00");
		header += getValidFuncForDateSimple();
		header += getAddIntervalFuncForDate();

		header += getTimeDataType();
		getTimeAccessors();
		header += getTimeFunctions("<");
		header += getTimeFunctions(">");
		header += getTimeFunctions("=");
		header += getNullFuncForDatatype("TIME", "timeNullVal", "99:99:99");
		header += getValidFuncForTime();
		// }

		return header + "\n\n";
	}

	// chaitra z3 apis generate null value declarations for datatypes - int and real
	/**
	 * @param datatype is a string - "int" or "real" or "date"
	 * @param funcName is the function name for assertion - currently "intNullVal"
	 *                 or "realNullVal" or "dateNullVal"
	 * @param nullVal  is the custom null value defined for datatype - as a string -
	 *                 e.g. "-99999"
	 * @return nothing
	 */
	public String getNullFuncForDatatype(String datatype, String funcName, String nullVal) {
		FuncDecl nullFuncDecl = null;
		Expr nullValue = null;
		String constraints = "";

		if (datatype.equalsIgnoreCase("int")) {
			nullFuncDecl = ctx.mkFuncDecl(funcName, new Sort[] {}, ctx.getIntSort());
			nullValue = ctx.mkInt(nullVal);
		} else if (datatype.equalsIgnoreCase("real")) {
			nullFuncDecl = ctx.mkFuncDecl(funcName, new Sort[] {}, ctx.getRealSort());
			nullValue = ctx.mkReal(nullVal);
		} else if (datatype.equalsIgnoreCase("date")) {
			nullFuncDecl = ctx.mkFuncDecl(funcName, new Sort[] {}, ctxSorts.get("DATE"));
			String[] parts = nullVal.split("-");
			int y = Integer.parseInt(parts[0]);
			int m = Integer.parseInt(parts[1]);
			int d = Integer.parseInt(parts[2]);
			DatatypeSort dateSort = (DatatypeSort) ctxSorts.get("DATE");
			FuncDecl constructor = dateSort.getConstructors()[0];
			nullValue = ctx.mkApp(constructor, ctx.mkInt(y), ctx.mkInt(m), ctx.mkInt(d));
		} else if (datatype.equalsIgnoreCase("time")) {
			nullFuncDecl = ctx.mkFuncDecl(funcName, new Sort[] {}, ctxSorts.get("TIME"));
			String[] parts = nullVal.split(":");
			int h = Integer.parseInt(parts[0]);
			int m = Integer.parseInt(parts[1]);
			int s = Integer.parseInt(parts[2]);
			DatatypeSort dateSort = (DatatypeSort) ctxSorts.get("TIME");
			FuncDecl constructor = dateSort.getConstructors()[0];
			nullValue = ctx.mkApp(constructor, ctx.mkInt(h), ctx.mkInt(m), ctx.mkInt(s));
		} else
			return "";
		ctxFuncDecls.put(funcName, nullFuncDecl);
		Expr nullConst = ctx.mkApp(nullFuncDecl);
		Expr funcBody = ctx.mkEq(nullConst, nullValue);
		solver.add(funcBody);

		constraints += nullFuncDecl.toString() + "\n";
		constraints += "(assert " + funcBody.toString() + ") \n";
		return constraints;
	}
	// chaitra z3 apis generate null value declarations for datatypes - int and real

	public void getCheckLimitsFunc(Column col) {
		String cvcDatatype = col.getCvcDatatype();
		if (cvcDatatype.equalsIgnoreCase("int")) {
			int min = (int) col.getMinVal();
			int max = (int) col.getMaxVal();
			min = min > Long.MIN_VALUE ? min - 1 : min;
			max = max < Long.MAX_VALUE ? max + 1 : max;
			getCheckLimitsIntFunc(col, min, max);
		} else if (cvcDatatype.equalsIgnoreCase("real")) {
			double min = col.getMinVal();
			double max = col.getMaxVal();
			getCheckLimitsRealFunc(col, min, max);
		} else {
			return;
		}
	}

	public void getCheckLimitsIntFunc(Column col, int minLimit, int maxLimit) {
		String funcName = "check" + col.getColumnName();
		FuncDecl checkFunc = ctx.mkFuncDecl(funcName, ctx.mkIntSort(), ctx.mkBoolSort());
		ctxFuncDecls.put(funcName, checkFunc);

		String varName = "i_" + col.getColumnName();
		Expr checkVar = ctx.mkConst(varName, ctx.getIntSort());

		Expr lowerBound = ctx.mkInt(minLimit);
		Expr upperBound = ctx.mkInt(maxLimit);
		Expr nullVal = ctx.mkApp(ctxFuncDecls.get("intNullVal"));

		BoolExpr rangeCheck = ctx.mkAnd(
				ctx.mkGe(checkVar, lowerBound),
				ctx.mkLe(checkVar, upperBound));
		BoolExpr nullCheck = ctx.mkEq(checkVar, nullVal);
		BoolExpr checkFuncBody = ctx.mkOr(rangeCheck, nullCheck);

		BoolExpr axiom = ctx.mkForall(
				new Expr[] { checkVar },
				ctx.mkEq(ctx.mkApp(checkFunc, checkVar), checkFuncBody),
				1, null, null, null, null);
		solver.add(axiom);
	}

	public void getCheckLimitsRealFunc(Column col, double minLimit, double maxLimit) {
		String funcName = "check" + col.getColumnName();
		FuncDecl checkFunc = ctx.mkFuncDecl(funcName, ctx.mkRealSort(), ctx.mkBoolSort());
		ctxFuncDecls.put(funcName, checkFunc);

		String varName = "r_" + col.getColumnName();
		Expr checkVar = ctx.mkConst(varName, ctx.getRealSort());

		Expr lowerBound = ctx.mkReal(Double.toString(minLimit));
		Expr upperBound = ctx.mkReal(Double.toString(maxLimit));
		Expr nullVal = ctx.mkApp(ctxFuncDecls.get("realNullVal"));

		BoolExpr rangeCheck = ctx.mkAnd(
				ctx.mkGe(checkVar, lowerBound),
				ctx.mkLe(checkVar, upperBound));
		BoolExpr nullCheck = ctx.mkEq(checkVar, nullVal);
		BoolExpr checkFuncBody = ctx.mkOr(rangeCheck, nullCheck);

		BoolExpr axiom = ctx.mkForall(
				new Expr[] { checkVar },
				ctx.mkEq(ctx.mkApp(checkFunc, checkVar), checkFuncBody),
				1, null, null, null, null);
		solver.add(axiom);
	}

	public void getCheckNull(Column col) {

	}

	public String getCheckFuncForDateCol(Column col) {

		long min = (long) col.getMinVal();
		long max = (long) col.getMaxVal();
		if (min == 0)
			min = -62091;
		if (max == 0)
			max = 193943;

		String minDate = "", maxDate = "";
		minDate = (LocalDate.ofEpochDay(min)).toString();
		maxDate = (LocalDate.ofEpochDay(max)).toString();

		DatatypeSort dateSort = (DatatypeSort) ctxSorts.get("DATE");
		FuncDecl constructor = dateSort.getConstructors()[0];
		String[] parts;
		int y, m, d;

		String funcName = "check" + col.getColumnName();
		FuncDecl checkFunc = ctx.mkFuncDecl(funcName, dateSort, ctx.mkBoolSort());
		ctxFuncDecls.put(funcName, checkFunc);

		Expr minVal;
		parts = minDate.split("-");
		y = Integer.parseInt(parts[0]);
		m = Integer.parseInt(parts[1]);
		d = Integer.parseInt(parts[2]);
		minVal = ctx.mkApp(constructor, ctx.mkInt(y), ctx.mkInt(m), ctx.mkInt(d));

		Expr maxVal;
		parts = maxDate.split("-");
		y = Integer.parseInt(parts[0]);
		m = Integer.parseInt(parts[1]);
		d = Integer.parseInt(parts[2]);
		maxVal = ctx.mkApp(constructor, ctx.mkInt(y), ctx.mkInt(m), ctx.mkInt(d));

		Expr checkVar = ctx.mkConst("d", dateSort);
		BoolExpr lowerCheck = null, upperCheck = null, rangeCheck = null;
		if (min != 0)
			lowerCheck = (BoolExpr) ctx.mkApp(ctxFuncDecls.get("gtDATE"), checkVar, minVal);
		if (max != 0)
			upperCheck = (BoolExpr) ctx.mkApp(ctxFuncDecls.get("ltDATE"), checkVar, maxVal);

		Expr nullVal = ctx.mkApp(ctxFuncDecls.get("dateNullVal"));
		BoolExpr nullCheck = ctx.mkEq(nullVal, checkVar);

		if (min != 0 && max != 0)
			rangeCheck = (BoolExpr) ctx.mkAnd(lowerCheck, upperCheck);
		else if (min != 0)
			rangeCheck = (BoolExpr) ctx.mkAnd(lowerCheck);
		else if (max != 0)
			rangeCheck = (BoolExpr) ctx.mkAnd(upperCheck);

		BoolExpr checkFuncBody = ctx.mkOr(rangeCheck, nullCheck);
		BoolExpr axiom = ctx.mkForall(
				new Expr[] { checkVar },
				ctx.mkEq(ctx.mkApp(checkFunc, checkVar), checkFuncBody),
				1, null, null, null, null);

		String constraints = "";
		constraints += checkFunc.toString() + "\n";
		constraints += "(assert " + axiom.toString() + ") \n";
		return constraints;
	}

	public String getDateNullDataValues(Column col) {
		String constraint = "";
		HashMap<Expr, Integer> nullValuesDate = new HashMap<Expr, Integer>();

		FuncDecl dateNullVal = ctxFuncDecls.get("dateNullVal");
		nullValuesDate.put(ctx.mkApp(dateNullVal), 0);
		constraint += defineIsNull(nullValuesDate, col);

		return constraint + "\n\n";
	}

	public String getTimeNullDataValues(Column col) {
		String constraint = "";
		HashMap<Expr, Integer> nullValuesDate = new HashMap<Expr, Integer>();

		FuncDecl timeNullVal = ctxFuncDecls.get("timeNullVal");
		nullValuesDate.put(ctx.mkApp(timeNullVal), 0);
		constraint += defineIsNull(nullValuesDate, col);

		return constraint + "\n\n";
	}

	public String getValidFuncForTime() {
		String constraints = "";

		DatatypeSort timeSort = (DatatypeSort) ctxSorts.get("TIME");
		FuncDecl getHours = ctxFuncDecls.get("getHours");
		FuncDecl getMinutes = ctxFuncDecls.get("getMinutes");
		FuncDecl getSeconds = ctxFuncDecls.get("getSeconds");

		Expr timeNullVal = ctx.mkApp(ctxFuncDecls.get("timeNullVal"));

		String funcName = "isValidTIME";
		FuncDecl checkCol = ctx.mkFuncDecl(funcName, ctxSorts.get("TIME"), ctx.mkBoolSort());
		ctxFuncDecls.put(funcName, checkCol);

		constraints = checkCol.toString() + "\n";

		Expr t = ctx.mkConst("t", timeSort);

		ArithExpr hour = (ArithExpr) ctx.mkApp(getHours, t);
		ArithExpr minute = (ArithExpr) ctx.mkApp(getMinutes, t);
		ArithExpr second = (ArithExpr) ctx.mkApp(getSeconds, t);

		BoolExpr hourCheck = ctx.mkAnd(ctx.mkGe(hour, ctx.mkInt(0)), ctx.mkLt(hour, ctx.mkInt(24)));
		BoolExpr minuteCheck = ctx.mkAnd(ctx.mkGe(minute, ctx.mkInt(0)), ctx.mkLt(minute, ctx.mkInt(60)));
		BoolExpr secondCheck = ctx.mkAnd(ctx.mkGe(second, ctx.mkInt(0)), ctx.mkLt(second, ctx.mkInt(60)));

		BoolExpr validTime = ctx.mkAnd(hourCheck, minuteCheck, secondCheck);
		BoolExpr nullCheck = ctx.mkEq(t, timeNullVal);

		BoolExpr funcBody = ctx.mkOr(validTime, nullCheck);

		BoolExpr axiom = ctx.mkForall(new Expr[] { t }, ctx.mkEq(ctx.mkApp(checkCol, t), funcBody), 1, null, null, null,
				null);
		solver.add(axiom);
		constraints += "(assert " + axiom.toString() + ")\n\n";
		return constraints;
	}

	public String getValidFuncForDateSimple() {
		String constraints = "";

		DatatypeSort dateSort = (DatatypeSort) ctxSorts.get("DATE");
		FuncDecl getDay = ctxFuncDecls.get("getDay");
		FuncDecl getMonth = ctxFuncDecls.get("getMonth");
		FuncDecl getYear = ctxFuncDecls.get("getYear");

		Expr dateNullVal = ctx.mkApp(ctxFuncDecls.get("dateNullVal"));
		String funcName = "isValidDATE";
		FuncDecl checkCol = ctx.mkFuncDecl(funcName, ctxSorts.get("DATE"), ctx.mkBoolSort());
		ctxFuncDecls.put(funcName, checkCol);
		constraints = checkCol.toString() + "\n";

		Expr d = ctx.mkConst("d", dateSort);
		ArithExpr year = (ArithExpr) ctx.mkApp(getYear, d);
		ArithExpr month = (ArithExpr) ctx.mkApp(getMonth, d);
		ArithExpr day = (ArithExpr) ctx.mkApp(getDay, d);

		// year between 1900 and 2500, month between 1 and 12, day between 1 and 30
		BoolExpr validDate = ctx.mkAnd(
				ctx.mkGe(year, ctx.mkInt(1900)),
				ctx.mkLe(year, ctx.mkInt(2500)),
				ctx.mkGe(month, ctx.mkInt(1)),
				ctx.mkLe(month, ctx.mkInt(12)),
				ctx.mkGe(day, ctx.mkInt(1)),
				ctx.mkLe(day, ctx.mkInt(30)));

		BoolExpr nullCheck = ctx.mkEq(d, dateNullVal);
		BoolExpr funcBody = ctx.mkOr(validDate, nullCheck);

		BoolExpr axiom = ctx.mkForall(
				new Expr[] { d },
				ctx.mkEq(ctx.mkApp(checkCol, d), funcBody),
				1, null, null, null, null);

		constraints += "(assert " + axiom.toString() + ")\n\n";
		return constraints;
	}

	public String getValidFuncForDate() {
		String constraints = "";

		DatatypeSort dateSort = (DatatypeSort) ctxSorts.get("DATE");
		FuncDecl getDay = ctxFuncDecls.get("getDay");
		FuncDecl getMonth = ctxFuncDecls.get("getMonth");
		FuncDecl getYear = ctxFuncDecls.get("getYear");

		Expr dateNullVal = ctx.mkApp(ctxFuncDecls.get("dateNullVal"));
		String funcName = "isValidDATE";
		FuncDecl checkCol = ctx.mkFuncDecl(funcName, ctxSorts.get("DATE"), ctx.mkBoolSort());
		ctxFuncDecls.put(funcName, checkCol);
		constraints = checkCol.toString() + "\n";

		Expr d = ctx.mkConst("d", dateSort);
		ArithExpr year = (ArithExpr) ctx.mkApp(getYear, d);
		ArithExpr month = (ArithExpr) ctx.mkApp(getMonth, d);
		ArithExpr day = (ArithExpr) ctx.mkApp(getDay, d);

		// leap year checking
		ArithExpr mod4 = ctx.mkMod(year, ctx.mkInt(4));
		ArithExpr mod100 = ctx.mkMod(year, ctx.mkInt(100));
		ArithExpr mod400 = ctx.mkMod(year, ctx.mkInt(400));
		BoolExpr leapYear = ctx.mkOr(
				ctx.mkAnd(ctx.mkEq(mod4, ctx.mkInt(0)), ctx.mkNot(ctx.mkEq(mod100, ctx.mkInt(0)))),
				ctx.mkEq(mod400, ctx.mkInt(0)));

		// february with 28 or 29 days
		BoolExpr isFeb = ctx.mkEq(month, ctx.mkInt(2));
		BoolExpr febCheck = ctx.mkAnd(isFeb,
				ctx.mkGe(day, ctx.mkInt(1)),
				ctx.mkLe(day, ctx.mkITE(leapYear, ctx.mkInt(29), ctx.mkInt(28))));

		// months with 31 days
		BoolExpr is31Month = ctx.mkOr(
				ctx.mkEq(month, ctx.mkInt(1)),
				ctx.mkEq(month, ctx.mkInt(3)),
				ctx.mkEq(month, ctx.mkInt(5)),
				ctx.mkEq(month, ctx.mkInt(7)),
				ctx.mkEq(month, ctx.mkInt(8)),
				ctx.mkEq(month, ctx.mkInt(10)),
				ctx.mkEq(month, ctx.mkInt(12)));
		BoolExpr day31Check = ctx.mkAnd(is31Month, ctx.mkGe(day, ctx.mkInt(1)), ctx.mkLe(day, ctx.mkInt(31)));

		// months with 30 days
		BoolExpr is30Month = ctx.mkOr(
				ctx.mkEq(month, ctx.mkInt(4)),
				ctx.mkEq(month, ctx.mkInt(6)),
				ctx.mkEq(month, ctx.mkInt(9)),
				ctx.mkEq(month, ctx.mkInt(11)));
		BoolExpr day30Check = ctx.mkAnd(is30Month, ctx.mkGe(day, ctx.mkInt(1)), ctx.mkLe(day, ctx.mkInt(30)));

		// final date is valid or null
		BoolExpr validDate = ctx.mkOr(day31Check, day30Check, febCheck);
		BoolExpr nullCheck = ctx.mkEq(d, dateNullVal);
		BoolExpr funcBody = ctx.mkOr(validDate, nullCheck);
		BoolExpr axiom = ctx.mkForall(
				new Expr[] { d },
				ctx.mkEq(ctx.mkApp(checkCol, d), funcBody),
				1, null, null, null, null);

		constraints += "(assert " + axiom.toString() + ")\n\n";

		return constraints;
	}

	public String getAddIntervalFuncForDate() {
		String constraints;
		DatatypeSort dateSort = (DatatypeSort) ctxSorts.get("DATE");
		FuncDecl getDay = ctxFuncDecls.get("getDay");
		FuncDecl getMonth = ctxFuncDecls.get("getMonth");
		FuncDecl getYear = ctxFuncDecls.get("getYear");

		FuncDecl addInterval = ctx.mkFuncDecl("addIntervalDays", new Sort[] { dateSort, ctx.getIntSort() }, dateSort);

		ctxFuncDecls.put("addIntervalDays", addInterval);
		constraints = addInterval.toString() + "\n";

		Expr d = ctx.mkConst("d", dateSort);
		Expr n = ctx.mkConst("n", ctx.getIntSort());

		ArithExpr day = (ArithExpr) ctx.mkApp(getDay, d);
		ArithExpr month = (ArithExpr) ctx.mkApp(getMonth, d);
		ArithExpr year = (ArithExpr) ctx.mkApp(getYear, d);

		ArithExpr newDayRaw = ctx.mkAdd(day, (ArithExpr) n);
		ArithExpr monthCarry = ctx.mkDiv(ctx.mkSub(newDayRaw, ctx.mkInt(1)), ctx.mkInt(30));
		ArithExpr newDay = ctx.mkAdd(ctx.mkMod(ctx.mkSub(newDayRaw, ctx.mkInt(1)), ctx.mkInt(30)), ctx.mkInt(1));

		ArithExpr newMonthRaw = ctx.mkAdd(month, monthCarry);
		ArithExpr yearCarry = ctx.mkDiv(ctx.mkSub(newMonthRaw, ctx.mkInt(1)), ctx.mkInt(12));

		ArithExpr newMonth = ctx.mkAdd(ctx.mkMod(ctx.mkSub(newMonthRaw, ctx.mkInt(1)), ctx.mkInt(12)), ctx.mkInt(1));
		ArithExpr newYear = ctx.mkAdd(year, yearCarry);

		FuncDecl constructor = dateSort.getConstructors()[0];

		Expr result = ctx.mkApp(constructor, newYear, newMonth, newDay);

		BoolExpr axiom = ctx.mkForall(
				new Expr[] { d, n },
				ctx.mkEq(ctx.mkApp(addInterval, d, n),
						result),
				1, null, null, null, null);
		solver.add(axiom);
		constraints += "(assert " + axiom.toString() + ")\n\n";
		return constraints;
	}

	/**
	 * This method returns the Constraint String for defining and declaring int,
	 * long and BigInt type data
	 * 
	 * @param cvc
	 * @param col
	 * @param minVal
	 * @param maxVal
	 * @return
	 */
	public String getIntegerDatatypes(Column col, long minVal, long maxVal) {

		String constraint = "";

		String funcName = "check" + col;
		FuncDecl getCol = ctx.mkFuncDecl(funcName, ctx.mkIntSort(), ctx.mkBoolSort());
		ctxFuncDecls.put(funcName, getCol);
		constraint = getCol.toString() + "\n";
		IntExpr[] iColArray = new IntExpr[] { ctx.mkIntConst("i_" + col) };
		Expr getColCall = getCol.apply(iColArray);

		minVal = minVal > Long.MIN_VALUE ? minVal - 1 : minVal; // TEST CODE: Pooja
		maxVal = maxVal < Long.MAX_VALUE ? maxVal + 1 : maxVal;

		// Expr condition = ctx.mkAnd(ctx.mkGt(iColArray[0], ctx.mkInt(minVal)),
		// ctx.mkLt(iColArray[0], ctx.mkInt(maxVal)));

		// Testing.....
		Expr condition = ctx.mkOr(
				ctx.mkAnd(ctx.mkGt(iColArray[0], ctx.mkInt(minVal)), ctx.mkLt(iColArray[0], ctx.mkInt(maxVal))),
				ctx.mkEq(iColArray[0], ctx.mkInt(-99999)));

		Expr body = ctx.mkEq(getColCall, condition);
		Expr funcQuantifier = ctx.mkForall(iColArray, body, 1, null, null, null, null);
		constraint += "(assert " + funcQuantifier.toString() + ")";

		return constraint + "\n\n";
	}

	/**
	 * This method returns a constraint string that holds the allowed null values
	 * for the integer data defined
	 * 
	 * @param cvc
	 * @param col
	 * @return
	 */
	public String getIntegerNullDataValues(Column col) {
		String constraint = "";
		HashMap<Expr, Integer> nullValuesInt = new HashMap<Expr, Integer>();

		nullValuesInt.put(ConstraintGenerator.intNull, 0);
		constraint += defineIsNull(nullValuesInt, col);

		return constraint + "\n\n";
	}

	/**
	 * This method returns the Constraint String for defining and declaring Real
	 * type data
	 * 
	 * @param cvc
	 * @param col
	 * @param minVal
	 * @param maxVal
	 * @return
	 */
	public String getRealDatatypes(Column col, double minVal, double maxVal) {
		String constraint = "";

		String funcName = "check" + col;
		FuncDecl getCol = ctx.mkFuncDecl(funcName, ctx.mkRealSort(), ctx.mkBoolSort());
		ctxFuncDecls.put(funcName, getCol);
		constraint = getCol.toString() + "\n";
		RealExpr[] rColArray = new RealExpr[] { ctx.mkRealConst("r_" + col) };
		Expr getColCall = getCol.apply(rColArray);
		// Expr condition = ctx.mkAnd(ctx.mkGe(rColArray[0],
		// ctx.mkReal(String.valueOf(minVal))), ctx.mkLe(rColArray[0],
		// ctx.mkReal(String.valueOf(maxVal))));
		Expr condition = ctx.mkOr(
				ctx.mkAnd(ctx.mkGe(rColArray[0], ctx.mkReal(String.valueOf(minVal))),
						ctx.mkLe(rColArray[0], ctx.mkReal(String.valueOf(maxVal)))),
				ctx.mkEq(rColArray[0], ctx.mkReal(-99999)));

		Expr body = ctx.mkEq(getColCall, condition);
		Expr funcQuantifier = ctx.mkForall(rColArray, body, 1, null, null, null, null);

		constraint += "(assert " + funcQuantifier.toString() + ")";

		return constraint + "\n\n";
	}

	/**
	 * This method returns a constraint string that holds the allowed null values
	 * for the Real data defined
	 * 
	 * @param cvc
	 * @param col
	 * @return
	 */
	public String getRealNullDataValues(Column col) {
		String constraint = "";
		HashMap<Expr, Integer> nullValuesReal = new HashMap<Expr, Integer>();
		nullValuesReal.put(ConstraintGenerator.realNull, 0);
		constraint += defineIsNull(nullValuesReal, col);

		return constraint + "\n\n";
	}

	/**
	 * This method returns the Constraint String for defining and declaring Boolean
	 * type data
	 * Booleans are represented as INT: 0 = FALSE, 1 = TRUE
	 * 
	 * @param col
	 * @return
	 */
	public String getBooleanDatatypes(Column col) {
		String constraint = "";

		String funcName = "check" + col;
		FuncDecl getCol = ctx.mkFuncDecl(funcName, ctx.mkIntSort(), ctx.mkBoolSort());
		ctxFuncDecls.put(funcName, getCol);
		constraint = getCol.toString() + "\n";

		IntExpr[] iColArray = new IntExpr[] { ctx.mkIntConst("i_" + col) };
		Expr getColCall = getCol.apply(iColArray);

		// Constraint: column value must be 0 or 1 (FALSE or TRUE)
		Expr condition = ctx.mkOr(
				ctx.mkEq(iColArray[0], ctx.mkInt(0)),
				ctx.mkEq(iColArray[0], ctx.mkInt(1)));

		Expr body = ctx.mkEq(getColCall, condition);
		Expr funcQuantifier = ctx.mkForall(iColArray, body, 1, null, null, null, null);
		constraint += "(assert " + funcQuantifier.toString() + ")";

		return constraint + "\n\n";
	}

	/**
	 * This method returns a constraint string that holds the allowed NULL values
	 * for Boolean columns (NULL = -99999)
	 * 
	 * @param col
	 * @return
	 */
	public String getBooleanNullDataValues(Column col) {
		String constraint = "";

		HashMap<Expr, Integer> nullValuesInt = new HashMap<Expr, Integer>();
		nullValuesInt.put(ConstraintGenerator.intNull, 0);
		constraint += defineIsNull(nullValuesInt, col);

		return constraint + "\n\n";
	}

	/**
	 * This method returns the <b>SMT Constraint</b> that holds the allowed Null
	 * values for given column
	 * 
	 * @param colValueMap
	 * @param col
	 * @return
	 */

	public static String defineIsNull(HashMap<Expr, Integer> colValueMap, Column col) {

		String IsNullValueString = "";
		Expr colNull = null;
		if (col.getCvcDatatype() != null && (col.getCvcDatatype().equalsIgnoreCase("Int")
				|| col.getCvcDatatype().equalsIgnoreCase("BOOLEAN"))) {
			colNull = ctx.mkConst(col.getColumnName().toLowerCase(), ctx.getIntSort());
		} else if (col.getCvcDatatype() != null && col.getCvcDatatype().equalsIgnoreCase("Real")) {
			colNull = ctx.mkConst(col.getColumnName().toLowerCase(), ctx.getRealSort());
		}
		// chaitra changed here for date - not null functions for date
		else if (col.getCvcDatatype() != null && col.getCvcDatatype().equalsIgnoreCase("DATE")) {
			colNull = ctx.mkConst(col.getColumnName().toLowerCase(), ctxSorts.get("DATE"));
		}
		// chaitra changed here for time - not null functions for time
		else if (col.getCvcDatatype() != null && col.getCvcDatatype().equalsIgnoreCase("TIME")) {
			colNull = ctx.mkConst(col.getColumnName().toLowerCase(), ctxSorts.get("TIME"));
		} else {
			colNull = ctx.mkConst(col.getColumnName().toLowerCase(), ctxSorts.get(col.getColumnName()));
		}

		String funcName = "ISNULL_" + col;
		FuncDecl isNullCol = ctx.mkFuncDecl(funcName, colNull.getSort(), ctx.mkBoolSort());
		ctxFuncDecls.put(funcName, isNullCol);
		IsNullValueString += isNullCol.toString() + "\n";

		Expr[] nullColArray = new Expr[] { colNull };
		Expr isNullColCall = isNullCol.apply(nullColArray);

		BoolExpr[] nullEqualityConds = colValueMap.keySet().stream().map(
				colValue -> ctx.mkEq(nullColArray[0], colValue)).toArray(
						size -> new BoolExpr[size]);
		BoolExpr nullValsOrCond = ctx.mkOr(nullEqualityConds);

		Expr body = ctx.mkEq(isNullColCall, nullValsOrCond);
		Expr funcQuantifier = ctx.mkForall(nullColArray, body, 1, null, null, null, null);
		IsNullValueString += "(assert " + funcQuantifier.toString() + ")\n";

		return IsNullValueString + "\n\n";
	}

	/**
	 * This method returns the Constraint String for defining and declaring String /
	 * VARCHAR type data
	 * 
	 * @param cvc
	 * @param columnValue
	 * @param col
	 * @param unique
	 * @return
	 * @throws Exception
	 */
	public String getStringDataTypes(Vector<String> columnValue, Column col, boolean unique) throws Exception {
		String constraint = "";
		String colValue = "";
		HashSet<String> uniqueValues = new HashSet<String>();
		String isNullMembers = "";
		checkAndRemoveDuplicateColumns(col);
		HashMap<Expr, Integer> nullValuesChar = new HashMap<Expr, Integer>();
		HashMap<Expr, Integer> notnullValuesChar = new HashMap<Expr, Integer>();
		Vector<String> colValues = new Vector<String>();

		if (columnValue.size() > 0) {
			if (!unique || !uniqueValues.contains(columnValue.get(0))) {
				colValue = Utilities.escapeCharacters(col.getColumnName()) + "__"
						+ Utilities.escapeCharacters(columnValue.get(0));// .trim());
				colValues.add("_" + colValue);
				uniqueValues.add(columnValue.get(0));
			}
			colValue = "";
			for (int j = 1; j < columnValue.size() || j < 4; j++) {
				colValue = "";
				if (j < columnValue.size()) {
					if (!unique || !uniqueValues.contains(columnValue.get(j))) {
						if (columnValue.get(j) != null) {
							colValue = Utilities.escapeCharacters(col.getColumnName()) + "__"
									+ Utilities.escapeCharacters(columnValue.get(j));
							uniqueValues.add(columnValue.get(j));
						}

					}
				} else {
					if (!uniqueValues.contains(((Integer) j).toString())) {
						colValue = Utilities.escapeCharacters(col.getColumnName()) + "__" + j;
					} else {
						continue;
					}
				}

				if (!colValue.isEmpty()) {
					colValues.add("_" + colValue);
				}
				// System.out.println(colValue);
			}

		}
		for (int j = 0; j < col.getCheckValues().size(); j++) {
			colValue = "";
			if (j < col.getCheckValues().size()) {
				if (!uniqueValues.contains(col.getCheckValues().get(j))) {
					if (col.getCheckValues().get(j) != null) {
						colValue = Utilities.escapeCharacters(col.getColumnName()) + "__"
								+ Utilities.escapeCharacters(col.getCheckValues().get(j));
						uniqueValues.add(col.getCheckValues().get(j));
					}

				}
			}

			if (!colValue.isEmpty()) {
				colValues.add("_" + colValue);
			}
			// System.out.println(colValue);
		}

		String nullVal = "NULL_" + col + "_1";
		colValues.add(nullVal);

		EnumSort colSort = null;
		if (ctxSorts.containsKey(col.getColumnName()) && ctxSorts.get(col.getColumnName()) instanceof EnumSort) {
			colSort = (EnumSort) ctxSorts.get(col.getColumnName());
		} else {
			try {
				colSort = ctx.mkEnumSort(col.getColumnName(), colValues.toArray(new String[colValues.size()]));
			} catch (Exception ex) {
				if (ctxSorts.containsKey(col.getColumnName()) && ctxSorts.get(col.getColumnName()) instanceof EnumSort) {
					colSort = (EnumSort) ctxSorts.get(col.getColumnName());
				} else {
					throw ex;
				}
			}
		}

		for (int i = 0; i < colSort.getConsts().length - 1; i++) { // all but last value, which is for null
			notnullValuesChar.put(colSort.getConsts()[i], 0);
		}

		nullValuesChar.put(colSort.getConst(colSort.getConsts().length - 1), 0); // put the null one in
																					// nullValuesChar

		ctxSorts.put(col.getColumnName(), colSort);
		solver = ctx.mkSolver();
		solver.push();

		// as of this writing, the API doesn't serialize unused declarations, therefore
		// dummy assertions are used
		Expr dummyVal = ctx.mkConst("dummy", colSort);
		BoolExpr dummyAssert = ctx.mkDistinct(dummyVal);
		solver.add(dummyAssert);
		String z3APIString = solver.toString();
		solver.pop(1); // pop out dummyVal and dummyAssert
		constraint = z3APIString.substring(0, z3APIString.indexOf("(declare-fun")) + "\n";

		// added for enum sort comparison
		Collections.sort(colValues);

		constraint += GetSolverHeaderAndFooter.generateCustomComparisonFunctionForEnumTypesExpr(col.getColumnName(),
				colValues, "map");

		constraint += GetSolverHeaderAndFooter.generateCustomComparisonFunctionForEnumTypesExpr(col.getColumnName(),
				colValues, "gt");
		Collections.sort(colValues, Collections.reverseOrder());

		constraint += GetSolverHeaderAndFooter.generateCustomComparisonFunctionForEnumTypesExpr(col.getColumnName(),
				colValues, "lt");

		constraint += GetSolverHeaderAndFooter.generateCustomComparisonFunctionForEnumTypesExpr(col.getColumnName(),
				colValues, "eq");

		constraint += defineIsNull(nullValuesChar, col) + "\n";

		// string check constraints - sunanda

		if (col.getCheckValues().size() > 0) {
			String funcName = "check" + col;
			FuncDecl getCol = ctx.mkFuncDecl(funcName, ctxSorts.get(col.getColumnName()), ctx.mkBoolSort());
			ctxFuncDecls.put(funcName, getCol);
			String constrainttemp = getCol.toString() + "\n";
			// ctx.mkConst("r_"+col, ctxSorts.get(col.getColumnName()));

			Expr[] rColArray = new Expr[] { ctx.mkConst("r_" + col, ctxSorts.get(col.getColumnName())) };
			Expr getColCall = getCol.apply(rColArray);
			Expr[] orArray = new Expr[col.getCheckValues().size()];
			int i = 0;
			for (String s : col.getCheckValues()) {
				colValue = Utilities.escapeCharacters(col.getColumnName()) + "__"
						+ Utilities.escapeCharacters(s);
				orArray[i] = ctx.mkEq(rColArray[0], ctx.mkConst("_" + colValue, ctxSorts.get(col.getColumnName())));
				i++;
			}
			Expr condition = ctx.mkOr(orArray);

			Expr body = ctx.mkEq(getColCall, condition);
			Expr funcQuantifier = ctx.mkForall(rColArray, body, 1, null, null, null, null);

			constrainttemp += "\n(assert " + funcQuantifier + ")\n\n";
			constraint += constrainttemp;
		}

		return constraint;
	}

	// chaitra declare date datatype
	public String getDateDataType() {
		// String contraints = "";
		int[] sortRefs = new int[] { 0, 0, 0 };
		Constructor dateConstructor = ctx.mkConstructor(
				"mk-date",
				"is-date",
				new String[] { "year", "month", "day" },
				new Sort[] { ctx.getIntSort(), ctx.getIntSort(), ctx.getIntSort() },
				sortRefs);
		DatatypeSort dateSort = ctx.mkDatatypeSort("DATE", new Constructor[] { dateConstructor });
		ctxSorts.put("DATE", dateSort);
		return "(declare-datatypes ((DATE 0)) (((mk-date (year Int) (month Int) (day Int)))))\n\n";
	}
	// chaitra declare date datatype end

	// chaitra create accessor functions
	public void getDateAccessors() {
		DatatypeSort dateSort = (DatatypeSort) ctxSorts.get("DATE");
		FuncDecl accessors[] = dateSort.getAccessors()[0];
		FuncDecl getYear = accessors[0];
		FuncDecl getMonth = accessors[1];
		FuncDecl getDay = accessors[2];
		ctxFuncDecls.put("getDay", getDay);
		ctxFuncDecls.put("getMonth", getMonth);
		ctxFuncDecls.put("getYear", getYear);
	}
	// chaitra create accessor functions end

	// chaitra create date functions
	public String getDateFunctions(String op) {
		DatatypeSort dateSort = (DatatypeSort) ctxSorts.get("DATE");
		FuncDecl getDay = ctxFuncDecls.get("getDay");
		FuncDecl getMonth = ctxFuncDecls.get("getMonth");
		FuncDecl getYear = ctxFuncDecls.get("getYear");

		String funcName = "";
		String funcBody = "";
		if (op.equalsIgnoreCase("<") || op.equalsIgnoreCase("lt"))
			funcName = "ltDATE";
		else if (op.equalsIgnoreCase(">") || op.equalsIgnoreCase("gt"))
			funcName = "gtDATE";
		else if (op.equalsIgnoreCase("=") || op.equalsIgnoreCase("eq"))
			funcName = "eqDATE";
		else
			return "";

		FuncDecl compFuncName = ctx.mkFuncDecl(funcName, new Sort[] { dateSort, dateSort }, ctx.getBoolSort());
		ctxFuncDecls.put(funcName, compFuncName);
		funcBody += "(declare-fun " + funcName + " (DATE DATE) Bool)\n";

		Expr x = ctx.mkConst("d1", dateSort);
		Expr y = ctx.mkConst("d2", dateSort);

		ArithExpr y1 = (ArithExpr) ctx.mkApp(getYear, x);
		ArithExpr y2 = (ArithExpr) ctx.mkApp(getYear, y);

		ArithExpr m1 = (ArithExpr) ctx.mkApp(getMonth, x);
		ArithExpr m2 = (ArithExpr) ctx.mkApp(getMonth, y);

		ArithExpr d1 = (ArithExpr) ctx.mkApp(getDay, x);
		ArithExpr d2 = (ArithExpr) ctx.mkApp(getDay, y);

		BoolExpr compFuncBody = null;
		if (funcName.equalsIgnoreCase("ltDate")) {
			// compare year first, then month, then day
			compFuncBody = ctx.mkOr(
					ctx.mkLt(y1, y2),
					ctx.mkAnd(
							ctx.mkEq(y1, y2),
							ctx.mkLt(m1, m2)),
					ctx.mkAnd(
							ctx.mkEq(y1, y2),
							ctx.mkEq(m1, m2),
							ctx.mkLt(d1, d2)));
		} else if (funcName.equalsIgnoreCase("gtDate")) {
			compFuncBody = ctx.mkOr(
					ctx.mkGt(y1, y2),
					ctx.mkAnd(
							ctx.mkEq(y1, y2),
							ctx.mkGt(m1, m2)),
					ctx.mkAnd(
							ctx.mkEq(y1, y2),
							ctx.mkEq(m1, m2),
							ctx.mkGt(d1, d2)));
		} else if (funcName.equalsIgnoreCase("eqDate")) {
			compFuncBody = ctx.mkAnd(
					ctx.mkEq(y1, y2),
					ctx.mkEq(m1, m2),
					ctx.mkEq(d1, d2));
		} else {
			return "";
		}

		BoolExpr compFuncAxiom = ctx.mkForall(
				new Expr[] { x, y },
				ctx.mkEq(
						ctx.mkApp(compFuncName, x, y),
						compFuncBody),
				1, null, null, null, null);
		solver.add(compFuncAxiom);
		funcBody += "(assert " + compFuncAxiom.toString() + ")\n\n";
		return funcBody;
	}
	// chaitra create date functions end

	// chaitra declare date datatype
	public String getTimeDataType() {
		// String contraints = "";
		int[] sortRefs = new int[] { 0, 0, 0 };
		Constructor timeConstructor = ctx.mkConstructor(
				"mk-time",
				"is-time",
				new String[] { "hours", "minutes", "seconds" },
				new Sort[] { ctx.getIntSort(), ctx.getIntSort(), ctx.getIntSort() },
				sortRefs);
		DatatypeSort timeSort = ctx.mkDatatypeSort("TIME", new Constructor[] { timeConstructor });
		ctxSorts.put("TIME", timeSort);
		return "(declare-datatypes ((TIME 0)) (((mk-time (hours Int) (minutes Int) (seconds Int)))))\n\n";
	}
	// chaitra declare date datatype end

	// chaitra create accessor functions
	public void getTimeAccessors() {
		DatatypeSort timeSort = (DatatypeSort) ctxSorts.get("TIME");
		FuncDecl accessors[] = timeSort.getAccessors()[0];
		FuncDecl getHours = accessors[0];
		FuncDecl getMinutes = accessors[1];
		FuncDecl getSeconds = accessors[2];
		ctxFuncDecls.put("getHours", getHours);
		ctxFuncDecls.put("getMinutes", getHours);
		ctxFuncDecls.put("getSeconds", getSeconds);
	}
	// chaitra create accessor functions end

	// chaitra create time functions
	public String getTimeFunctions(String op) {
		DatatypeSort timeSort = (DatatypeSort) ctxSorts.get("TIME");
		FuncDecl getHours = ctxFuncDecls.get("getHours");
		FuncDecl getMinutes = ctxFuncDecls.get("getMinutes");
		FuncDecl getSeconds = ctxFuncDecls.get("getSeconds");

		String funcName = "";
		String funcBody = "";
		if (op.equalsIgnoreCase("<") || op.equalsIgnoreCase("lt"))
			funcName = "ltTIME";
		else if (op.equalsIgnoreCase(">") || op.equalsIgnoreCase("gt"))
			funcName = "gtTIME";
		else if (op.equalsIgnoreCase("=") || op.equalsIgnoreCase("eq"))
			funcName = "eqTIME";
		else
			return "";

		FuncDecl compFuncName = ctx.mkFuncDecl(funcName, new Sort[] { timeSort, timeSort }, ctx.getBoolSort());
		ctxFuncDecls.put(funcName, compFuncName);
		funcBody += "(declare-fun " + funcName + " (TIME TIME) Bool)\n";

		Expr x = ctx.mkConst("d1", timeSort);
		Expr y = ctx.mkConst("d2", timeSort);

		ArithExpr h1 = (ArithExpr) ctx.mkApp(getHours, x);
		ArithExpr h2 = (ArithExpr) ctx.mkApp(getHours, y);

		ArithExpr m1 = (ArithExpr) ctx.mkApp(getMinutes, x);
		ArithExpr m2 = (ArithExpr) ctx.mkApp(getMinutes, y);

		ArithExpr s1 = (ArithExpr) ctx.mkApp(getSeconds, x);
		ArithExpr s2 = (ArithExpr) ctx.mkApp(getSeconds, y);

		BoolExpr compFuncBody = null;
		if (funcName.equalsIgnoreCase("ltTime")) {
			// compare year first, then month, then day
			compFuncBody = ctx.mkOr(
					ctx.mkLt(h1, h2),
					ctx.mkAnd(
							ctx.mkEq(h1, h2),
							ctx.mkLt(m1, m2)),
					ctx.mkAnd(
							ctx.mkEq(h1, h2),
							ctx.mkEq(m1, m2),
							ctx.mkLt(s1, s2)));
		} else if (funcName.equalsIgnoreCase("gtTime")) {
			compFuncBody = ctx.mkOr(
					ctx.mkGt(h1, h2),
					ctx.mkAnd(
							ctx.mkEq(h1, h2),
							ctx.mkGt(m1, m2)),
					ctx.mkAnd(
							ctx.mkEq(h1, h2),
							ctx.mkEq(m1, m2),
							ctx.mkGt(s1, s2)));
		} else if (funcName.equalsIgnoreCase("eqTime")) {
			compFuncBody = ctx.mkAnd(
					ctx.mkEq(h1, h2),
					ctx.mkEq(m1, m2),
					ctx.mkEq(s1, s2));
		} else {
			return "";
		}

		BoolExpr compFuncAxiom = ctx.mkForall(
				new Expr[] { x, y },
				ctx.mkEq(
						ctx.mkApp(compFuncName, x, y),
						compFuncBody),
				1, null, null, null, null);
		solver.add(compFuncAxiom);
		funcBody += "(assert " + compFuncAxiom.toString() + ")\n\n";
		return funcBody;
	}
	// chaitra create time functions end

	/**
	 * TEMPCODE Rahul Sharma
	 * TO check and remove duplicate entries from the column values
	 * 
	 * @param col : A column of a table
	 */

	private void checkAndRemoveDuplicateColumns(Column col) {
		Vector<String> columnValues = col.getColumnValues();
		Vector<String> uniqueColumnValues = new Vector<String>();
		uniqueColumnValues.addAll(columnValues);
		// columnValues.clear();
		// columnValues.addAll(uniqueColumnValues);
		col.getColumnValues().clear();
		for (String s : uniqueColumnValues) {
			if (!col.getColumnValues().contains(s))
				col.addColumnValues(s);
		}

	}

	/**
	 * This method returns the Footer Constraints based on the solver
	 * 
	 * @param cvc
	 * @return
	 */
	public String getFooter(GenerateCVC1 cvc) {

		String temp = "";

		temp += "\n\n(check-sat)"; // need to right generalize one

		temp += "\n(get-model)";

		return temp;
	}

	/**
	 * This method returns the Footer Constraints based on the solver
	 * 
	 * @param cvc
	 * @return
	 */
	public String getFooterForAgg(GenerateCVC1 cvc) {

		String temp = "";

		temp += "\n\n(check-sat)\n"; // need to right generalize one

		return temp;
	}

	/**
	 * This method returns the constraint String that holds the Tuple Types based on
	 * solver
	 * 
	 * @param cvc
	 * @param col
	 * @return
	 */
	// saurabh code begins
	public static String getTupleTypesForSolver(GenerateCVC1 cvc) {

		String tempStr = "";
		Table t;
		String temp;
		Vector<String> tablesAdded = new Vector<String>();
		tempStr += addCommentLine(" Tuple Types for Relations\n ");
		// System.out.println("here in tupletype");

		if (cvc.getConstraintSolver().equalsIgnoreCase("cvc3")) {
			Column c;

			tempStr += ConstraintGenerator.addCommentLine(" Tuple Types for Relations\n ");
			for (int i = 0; i < cvc.getResultsetTables().size(); i++) {
				t = cvc.getResultsetTables().get(i);
				temp = t.getTableName();
				if (!tablesAdded.contains(temp)) {
					tempStr += temp + "_TupleType: TYPE = [";
				}
				for (int j = 0; j < cvc.getResultsetColumns().size(); j++) {
					c = cvc.getResultsetColumns().get(j);
					if (c.getTableName().equalsIgnoreCase(temp)) {
						String s = c.getCvcDatatype();
						if (s != null && (s.equalsIgnoreCase("INT") || s.equalsIgnoreCase("REAL")
								|| s.equalsIgnoreCase("TIME") || s.equalsIgnoreCase("DATE")
								|| s.equalsIgnoreCase("TIMESTAMP")))
							tempStr += c.getColumnName() + ", ";
						else
							tempStr += c.getCvcDatatype() + ", ";
					}
				}
				tempStr = tempStr.substring(0, tempStr.length() - 2);
				tempStr += "];\n";
				/*
				 * Now create the Array for this TupleType
				 */
				tempStr += "O_" + temp + ": ARRAY INT OF " + temp + "_TupleType;\n";
			}
		} else {

			Solver dummySol = ctx.mkSolver(); // for getting string form of z3 context declarations

			String[] tablenames = new String[cvc.getResultsetTables().size()];
			for (int i = 0; i < cvc.getResultsetTables().size(); i++) {
				tablenames[i] = cvc.getResultsetTables().get(i).getTableName();
			}
			// added by deeksha
			if (Configuration.getProperty("cntFlag").equalsIgnoreCase("true")) {
				usingCnt = true;
			} else {
				usingCnt = false;
			}
			// end
			for (int i = 0; i < cvc.getResultsetTables().size(); i++) {
				int index = 0;
				t = cvc.getResultsetTables().get(i);
				temp = t.getTableName();
				// added by deeksha
				Boolean cntFlag = false;
				String[] attrNames = new String[t.getNoOfColumn()];
				Sort[] attrTypes = new Sort[t.getNoOfColumn()];

				checkResultSetColumns(cvc, cvc.getResultsetColumns()); // TEMPCODE Rahul Sharma // added to check if
																		// the resultsetcolumns contains duplicate
																		// columns

				for (Column c : cvc.getResultsetColumns()) {
					if (c.getTableName().equalsIgnoreCase(temp)) {
						String s = c.getCvcDatatype();
						// if (s != null && (s.equalsIgnoreCase("Int") || s.equals("TIME") ||
						// s.equals("DATE")
						// || s.equals("TIMESTAMP"))) { // TODO: check datetime types
						if (s != null && (s.equalsIgnoreCase("Int") || s.equalsIgnoreCase("TIMESTAMP")
								|| s.equals("BOOLEAN"))) {
							attrTypes[index] = ctx.getIntSort();
						}
						// chaitra changed here for date - declare datatypes tuple - sort is date
						else if (s != null && s.equalsIgnoreCase("DATE")) {
							attrTypes[index] = ctxSorts.get("DATE");
						}
						// chaitra changed here for time - declare datatypes tuple - sort is time
						else if (s != null && s.equalsIgnoreCase("TIME")) {
							attrTypes[index] = ctxSorts.get("TIME");
						} else if (s != null && (s.equalsIgnoreCase("Real"))) {
							attrTypes[index] = ctx.getRealSort();
						} else {
							attrTypes[index] = ctxSorts.get(s);
						}

						attrNames[index] = temp + "_" + c + index;
						index++;
					}
				}

				String tupleTypeName = temp + "_TupleType";
				Constructor[] cons = new Constructor[] {
						ctx.mkConstructor(tupleTypeName, "is_" + tupleTypeName, attrNames, attrTypes, null) };
				// API USAGE
				DatatypeSort tupleType = ctx.mkDatatypeSort(tupleTypeName, cons);
				ctxSorts.put(tupleTypeName, tupleType);
				ArraySort asort = ctx.mkArraySort(ctx.getIntSort(), tupleType);

				if (Configuration.isEnumInt.equalsIgnoreCase("true") && ctxSorts.containsKey(cvc.enumArrayIndex)) {
					asort = ctx.mkArraySort(getColumnSort(cvc.enumArrayIndex), tupleType);
				}
				String arrName = "O_" + temp;
				Expr aex = ctx.mkConst(arrName, asort);
				ctxSorts.put(arrName, asort);
				// System.out.println("heyyy");
				ctxConsts.put(arrName, aex);
				// adding dummy asserts so that solver has relevant declarations in string
				// returned by toString()
				BoolExpr dummyAssert = ctx.mkDistinct(aex);
				dummySol.add(dummyAssert);
				// }

				// testcode end----------------------------------------------

			}

			// Temporary procedure to extract relevant declarations from the solver string
			// String[] z3Statements = dummySol.toString().split("\n");
			// chaitra changed here : some statements are continued on a new line, hence
			// cannot be split on \n
			String[] z3Statements = dummySol.toString().split("(?<=\\))\n(?=\\()");
			Vector<String> includedStatements = new Vector<String>();

			for (String statement : z3Statements) {
				if (statement.contains("_TupleType ") || statement.contains("declare-fun O_")) {
					includedStatements.add(statement);
				}
				if (statement.contains("(assert")) {
					break;
				}
			}
			tempStr += String.join("\n\n", includedStatements);

		}
		// System.out.println(tempStr);

		return tempStr;
	}

	/**
	 * TEMPCODE Rahul Sharma : to check if there is any duplicate columns in
	 * resultsetcolumns
	 * 
	 * @param cvc
	 * @param resultsetColumns
	 */
	private static void checkResultSetColumns(GenerateCVC1 cvc, Vector<Column> resultsetColumns) {
		LinkedHashSet<Column> hashSet = new LinkedHashSet<Column>(resultsetColumns);
		resultsetColumns.clear();
		resultsetColumns.addAll(hashSet);
		cvc.setResultsetColumns(resultsetColumns);
	}

	public static String getConstraintsForValidCount(GenerateCVC1 cvc, String tableName, int tupleIndex,
			int countValue) {
		Column cntCol = cvc.getTableMap().getTable(tableName.toUpperCase())
				.getColumn(cvc.getTableMap().getTable(tableName.toUpperCase()).getNoOfColumn() - 1);
		Expr tempExpr = (IntExpr) ctx.mkInt(tupleIndex);
		if (Configuration.isEnumInt.equalsIgnoreCase("true")) {
			EnumSort currentSort = (EnumSort) ConstraintGenerator.ctxSorts.get(cvc.enumArrayIndex);
			tempExpr = ctx.mkConst(cvc.enumIndexVar + Integer.toString(tupleIndex), currentSort);
		}
		Expr andWithCount = (ArithExpr) smtMap(cntCol, tempExpr);

		return andWithCount.toString();
	}

	public static Expr getConstraintsForValidCountUsingTable(Table table, String tableName, int tupleIndex,
			int countValue) {
		Column cntCol = table.getColumn(table.getNoOfColumn() - 1);
		Expr andWithCount;

		if (Configuration.isEnumInt.equalsIgnoreCase("true")) {
			EnumSort currentSort = (EnumSort) ConstraintGenerator.ctxSorts.get(enumArrayIndex);
			andWithCount = (ArithExpr) smtMap(cntCol, ctx.mkConst(enumIndexVar + tupleIndex, currentSort));
		} else {
			andWithCount = (ArithExpr) smtMap(cntCol, (IntExpr) ctx.mkInt(tupleIndex));
		}

		// return andWithCount;
		return ctx.mkGt(andWithCount, ConstraintGenerator.ctx.mkInt(countValue));
	}

	public static Expr getConstraintsForInValidCountUsingTable(Table table, String tableName, int tupleIndex,
			int countValue) {
		Column cntCol = table.getColumn(table.getNoOfColumn() - 1);
		Expr andWithCount;

		if (Configuration.isEnumInt.equalsIgnoreCase("true")) {
			EnumSort currentSort = (EnumSort) ConstraintGenerator.ctxSorts.get(enumArrayIndex);
			andWithCount = (ArithExpr) smtMap(cntCol, ctx.mkConst(enumIndexVar + tupleIndex, currentSort));
		} else {
			andWithCount = (ArithExpr) smtMap(cntCol, (IntExpr) ctx.mkInt(tupleIndex));
		}

		// return andWithCount;
		return ctx.mkEq(andWithCount, ConstraintGenerator.ctx.mkInt(countValue));
	}

	/*
	 * Generate not null check constraints in assert statements
	 * 
	 */
	public static String genNULLCheckConstraints(Node n, int index) {
		/* Removing NUll enumerations */

		String constraint = "";
		Column col = n.getColumn();
		if (!isCVC3) {
			Table table = col.getTable();
			String type = col.getCvcDatatype();
			String tableName = col.getTableName();
			String columnName = col.getColumnName();
			int pos = table.getColumnIndex(columnName);
			String datatype = col.getCvcDatatype();

			String smtCond = "";
			String colName = tableName + "_" + columnName + pos;
			if (datatype != null && (datatype.equalsIgnoreCase("INT") || datatype.equalsIgnoreCase("REAL")
					|| datatype.equalsIgnoreCase("TIME") || datatype.equalsIgnoreCase("DATE")
					|| datatype.equalsIgnoreCase("TIMESTAMP")))
				constraint = "check" + n.getColumn().getColumnName() + "(" + colName + " " + "(select O_" + tableName
						+ " " + enumIndexVar + index + ") )";
			else
				constraint = "not (ISNULL_" + n.getColumn().getColumnName() + " (" + colName + " " + "(select O_"
						+ tableName + " " + enumIndexVar + index + ") ))";
		}

		return constraint;
	}

	/**
	 * Generate CVC3 constraints for the given node and its tuple position
	 * 
	 * @param queryBlock
	 * @param n
	 * @param index
	 * @return
	 */

	public static Expr putTableInCtx(GenerateCVC1 cvc, Vector<String> attrNames, Vector<Sort> attrTypes,
			String table_name) {
		String tupleTypeName = table_name + "_TupleType";
		Constructor[] cons = new Constructor[] {
				ctx.mkConstructor(tupleTypeName, "is_" + tupleTypeName, attrNames.toArray(new String[attrNames.size()]),
						attrTypes.toArray(new Sort[attrTypes.size()]), null) };
		DatatypeSort tupleType = ctx.mkDatatypeSort(tupleTypeName, cons);
		ctxSorts.put(tupleTypeName, tupleType);
		ArraySort asort = ctx.mkArraySort(ctx.getIntSort(), tupleType);
		if (Configuration.isEnumInt.equalsIgnoreCase("true") && ctxSorts.containsKey(cvc.enumArrayIndex)) {
			asort = ctx.mkArraySort(getColumnSort(cvc.enumArrayIndex), tupleType);
		}
		String arrName = "O_" + table_name;
		Expr aex = ctx.mkConst(arrName, asort);
		ctxSorts.put(arrName, asort);
		ctxConsts.put(arrName, aex);

		return aex;
	}

	public static Sort getColumnSort(String dataTypeOfColumn) {
		// if (dataTypeOfColumn.equalsIgnoreCase("int") ||
		// dataTypeOfColumn.equalsIgnoreCase("date")) {
		if (dataTypeOfColumn.equalsIgnoreCase("int") || dataTypeOfColumn.equalsIgnoreCase("boolean")) {
			return ctx.getIntSort();
		}
		// chaitra changed here for date - jsq column sort should be date
		else if (dataTypeOfColumn.equalsIgnoreCase("date")) {
			return ctxSorts.get("DATE");
		}
		// chaitra changed here for date - jsq column sort should be time
		else if (dataTypeOfColumn.equalsIgnoreCase("time")) {
			return ctxSorts.get("TIME");
		} else if (dataTypeOfColumn.equalsIgnoreCase("real")) {
			return ctx.getRealSort();
		} else if (dataTypeOfColumn.equalsIgnoreCase("string")) {
			return ctx.getStringSort();
		} else {
			return ctxSorts.get(dataTypeOfColumn);
		}
	}

	/**
	 * Function to generate constraints for declaration
	 * 
	 * @param aex : expression generated after putting table in context
	 * @return Vector of strings containing constraints
	 */
	public static Vector<String> declareRelation(Expr aex) {

		BoolExpr dummyAssert = ctx.mkDistinct(aex);
		solver.add(dummyAssert);
		String[] constraints = solver.toString().split("\n");
		Vector<String> includedStatements = new Vector<String>();

		// constraints contain extra datatype declarartions so we will filter only those
		// required for us
		for (String statement : constraints) {
			if (statement.contains("_TupleType ") || statement.contains("declare-fun O_")) {
				includedStatements.add(statement + "\n");
			}
			if (statement.contains("(assert")) {
				break;
			}
		}
		return includedStatements;

	}

	// for selection expression of a tuple from a relation using api
	public static Vector<String> declareRelation(Expr aex, String joinTable) {

		BoolExpr dummyAssert = ctx.mkDistinct(aex);
		solver.add(dummyAssert);
		String[] constraints = solver.toString().split("\n");
		Vector<String> includedStatements = new Vector<String>();

		// constraints contain extra datatype declarartions so we will filter only those
		// required for us
		for (String statement : constraints) {
			if (statement.contains("((" + joinTable + "_TupleType 0))")
					|| statement.contains("(declare-fun O_" + joinTable)) {
				includedStatements.add(statement + "\n");
			}
			if (statement.contains("(assert")) {
				break;
			}
		}
		return includedStatements;

	}

	public static Expr genSelectTest(GenerateCVC1 cvc, String tableName, int colIndex, int index) {

		Expr pos = (IntExpr) ctx.mkInt(index);
		if (Configuration.isEnumInt.equalsIgnoreCase("true")) {
			EnumSort currentSort = (EnumSort) ConstraintGenerator.ctxSorts.get(cvc.enumArrayIndex);
			pos = ctx.mkConst(cvc.enumIndexVar + Integer.toString(index), currentSort);
		}
		// check if subquerytable is in context or not
		if (ctxConsts.get("O_" + tableName) == null) {
			Pattern pattern = Pattern.compile("(\\d+)$");
			Matcher matcher = pattern.matcher(tableName);
			String numberStr = "0";
			if (matcher.find())
				numberStr = matcher.group(1);

			String temp = "where_" + numberStr;
			int noOfAttr = cvc.subqueryConstraintsMap.get("where").SQTableName.get(tableName).size();
			ArrayList<String> listOfAttr = cvc.subqueryConstraintsMap.get("from").SQColumns.get(tableName);
			Vector<String> attrNames = new Vector<String>();
			Vector<Sort> attrType = new Vector<Sort>();

			for (int i = 0; i < noOfAttr; i++) {
				attrNames.add(listOfAttr.get(i));
				Column column = cvc.getResultsetColumns().get(i + 1);
				attrType.add(getColumnSort(column.getCvcDatatype()));
			}
			Expr aex = putTableInCtx(cvc, attrNames, attrType, tableName);

			String functionName = "GETAGGVAL";

			Sort[] agg = new Sort[2];

			FuncDecl getAggVal = ctx.mkFuncDecl(functionName, attrType.toArray(new Sort[attrType.size()]),
					ctx.mkBoolSort());
			ctxFuncDecls.put(functionName, getAggVal);

			// -----------------------------------------------------
		}

		ArrayExpr subqueryRelation = (ArrayExpr) ctxConsts.get("O_" + tableName);

		DatatypeExpr tuple = (DatatypeExpr) ctx.mkSelect(subqueryRelation, pos);

		DatatypeSort tupSort = (DatatypeSort) tuple.getSort();
		FuncDecl[] tupAccessors = tupSort.getAccessors()[0];
		FuncDecl colAccessor = tupAccessors[colIndex];
		Expr resultantExpr = colAccessor.apply(tuple);

		return resultantExpr;
	}

	public static Expr selectCol(GenerateCVC1 cvc, String tableName, int colIndex, int index) {
		Table table;
		if (tableName.contains("O_")) {
			tableName = (tableName.split("_")[1]);
		}

		table = cvc.getTableMap().getSQTableByName(tableName);
		Expr pos = (IntExpr) ctx.mkInt(index);
		if (Configuration.isEnumInt.equalsIgnoreCase("true")) {
			EnumSort currentSort = (EnumSort) ConstraintGenerator.ctxSorts.get(cvc.enumArrayIndex);
			pos = ctx.mkConst(cvc.enumIndexVar + Integer.toString(index), currentSort);
		}
		// check if subquerytable is in context or not
		if (ctxConsts.get("O_" + tableName) == null) {
			int noOfAttr = table.getNoOfColumn();
			ArrayList<String> listOfAttr = new ArrayList<>();
			for (int i = 0; i < noOfAttr; i++)
				listOfAttr.add(table.getColumn(i).toString());

			Vector<String> attrNames = new Vector<String>();
			Vector<Sort> attrType = new Vector<Sort>();

			for (int i = 0; i < noOfAttr; i++) {
				attrNames.add(listOfAttr.get(i));
				Column column = table.getColumn(i);
				attrType.add(getColumnSort(column.getCvcDatatype()));
			}
			Expr aex = putTableInCtx(cvc, attrNames, attrType, tableName);

			String functionName = "GETAGGVAL";

			Sort[] agg = new Sort[2];

			FuncDecl getAggVal = ctx.mkFuncDecl(functionName, attrType.toArray(new Sort[attrType.size()]),
					ctx.mkBoolSort());
			ctxFuncDecls.put(functionName, getAggVal);

			// -----------------------------------------------------
		}

		ArrayExpr subqueryRelation = (ArrayExpr) ctxConsts.get("O_" + tableName);

		DatatypeExpr tuple = (DatatypeExpr) ctx.mkSelect(subqueryRelation, pos);

		DatatypeSort tupSort = (DatatypeSort) tuple.getSort();
		FuncDecl[] tupAccessors = tupSort.getAccessors()[0];
		FuncDecl colAccessor = tupAccessors[colIndex];
		Expr resultantExpr = colAccessor.apply(tuple);

		return resultantExpr;
	}

	/**
	 * 
	 * @param cvc
	 * @param tableName
	 * @param colIndex
	 * @param index
	 * @return Expr : It is selection expression which selects col of index tuple
	 *         from given tablename
	 */
	public static Expr genSelectTest2(GenerateCVC1 cvc, String tableName, int colIndex, String index) {
		// Solver dummySol = ctx.mkSolver();

		// if offset / tuple no is string
		Expr[] nullArr = new Expr[] { ctx.mkIntConst(String.valueOf(index)) }; // : this will work with string like i ,
		if (Configuration.isEnumInt.equalsIgnoreCase("true")) {
			EnumSort currentSort = (EnumSort) ConstraintGenerator.ctxSorts.get(cvc.enumArrayIndex);
			nullArr = new Expr[] { ctx.mkConst(String.valueOf(index), currentSort) };
		} // j
		if (!tableName.contains("O_"))
			tableName = "O_" + tableName;
		// check if subquerytable is in context or not
		if (ctxConsts.get(tableName) == null) {
			int noOfAttr = cvc.subqueryConstraintsMap.get("where").SQTableName.get(tableName).size();
			ArrayList<String> listOfAttr = cvc.subqueryConstraintsMap.get("where").SQColumns.get(tableName);
			Vector<String> attrNames = new Vector<String>();
			Vector<Sort> attrType = new Vector<Sort>();

			for (int i = 0; i < noOfAttr; i++) {
				attrNames.add(listOfAttr.get(i));
				Column column = cvc.getResultsetColumns().get(i + 1);
				attrType.add(getColumnSort(column.getCvcDatatype()));
			}
			Expr aex = putTableInCtx(cvc, attrNames, attrType, tableName);

		}
		ArrayExpr subqueryRelation;
		// constraints for selection expression

		subqueryRelation = (ArrayExpr) ctxConsts.get(tableName);

		DatatypeExpr tuple = (DatatypeExpr) ctx.mkSelect(subqueryRelation, nullArr);

		DatatypeSort tupSort = (DatatypeSort) tuple.getSort();
		FuncDecl[] tupAccessors = tupSort.getAccessors()[0];
		FuncDecl colAccessor = tupAccessors[colIndex];
		Expr resultantExpr = colAccessor.apply(tuple);

		return resultantExpr;
	}

	/**
	 * This function returns string having constraint of type "equation"
	 * 
	 * @param cvc
	 * @param table1
	 * @param col1
	 * @param offset1
	 * @param table2
	 * @param col2
	 * @param offset2
	 * @return
	 */

	public static String genEquiCondTest(GenerateCVC1 cvc, String table1, int col1, int offset1, String table2,
			int col2, int offset2) {

		// Expr temp = genSelectTest2(cvc, table1 , col1 , "x!0" );
		Expr left = genSelectTest(cvc, table1, col1, offset1);
		Expr right = genSelectTest(cvc, table2, col2, offset2);

		// equation expression
		Expr eq = ctx.mkEq(left, right);

		return eq.toString();
	}

	public static String genPositiveCondsForPred(QueryBlockDetails queryBlock, Node n, int index) {

		if (n.getType().equalsIgnoreCase(Node.getColRefType())) {

			Expr temp = ctx.mkInt(index);
			if (Configuration.isEnumInt.equalsIgnoreCase("true")) {
				EnumSort currentSort = (EnumSort) ConstraintGenerator.ctxSorts.get(enumArrayIndex);
				temp = ctx.mkConst(enumIndexVar + Integer.toString(index), currentSort);
			}
			return smtMap(n.getColumn(), temp).toString();

		} else if (n.getType().equalsIgnoreCase(Node.getCastNodeType())) {
			return genPositiveCondsForPred(queryBlock, n.getLeft(), index);
		} else if (n.getType().equalsIgnoreCase(Node.getValType())) {
			if (!n.getStrConst().contains("$"))
				return getSMTValue(n);
			else
				return queryBlock.getParamMap().get(n.getStrConst());
		} else if (n.getType().equalsIgnoreCase(Node.getCastNodeType())) {
			// Handle CAST(expression AS type)
			String targetType = n.getCastType().toString().toUpperCase();
			String innerExpr = genPositiveCondsForPred(queryBlock, n.getLeft(), index);
			// try the no-index variant as a fallback
			if (innerExpr == null || innerExpr.isEmpty()) {
				innerExpr = genPositiveCondsForPred(queryBlock, n.getLeft());
			}
			// if recursive generation still failed for some reason, try direct mapping for
			// simple nodes
			if (innerExpr == null || innerExpr.isEmpty()) {
				Node left = n.getLeft();
				if (left != null) {
					if (left.getType().equalsIgnoreCase(Node.getColRefType())) {
						Expr temp = ctx.mkInt(index);
						innerExpr = smtMap(left.getColumn(), temp).toString();
						// fall through
					} else if (left.getType().equalsIgnoreCase(Node.getValType())) {
						if (!left.getStrConst().contains("$"))
							innerExpr = getSMTValue(left);
						else
							innerExpr = queryBlock.getParamMap().get(left.getStrConst());
					}
				}
			}

			// For CAST INT AS REAL - use (to_real expr)
			if ((targetType.contains("REAL") || targetType.contains("NUMERIC") || targetType.contains("DECIMAL"))) {
				return "(to_real " + innerExpr + ")";
			}
			// For CAST REAL AS INT - use (to_int expr)
			else if (targetType.contains("INT") || targetType.contains("INTEGER")) {
				return "(to_int " + innerExpr + ")";
			}
			// For other types, pass through
			return innerExpr;
		} else if (n.getType().equalsIgnoreCase(Node.getBroNodeType())
				|| n.getType().equalsIgnoreCase(Node.getBaoNodeType())
				|| n.getType().equalsIgnoreCase(Node.getLikeNodeType()) ||
				n.getType().equalsIgnoreCase(Node.getAndNodeType())
				|| n.getType().equalsIgnoreCase(Node.getOrNodeType())) {
			if (isCVC3) {

				return "( " + genPositiveCondsForPred(queryBlock, n.getLeft(), index) + " " + n.getOperator() + " " +
						genPositiveCondsForPred(queryBlock, n.getRight(), index) + ")";
			} else {

				return "( " + (n.getOperator().equals("/=") ? "not (= " : n.getOperator()) + " "
						+ genPositiveCondsForPred(queryBlock, n.getLeft(), index) + " " +
						genPositiveCondsForPred(queryBlock, n.getRight(), index)
						+ (n.getOperator().equals("/=") ? " )" : "") + " )";
			}
		}
		return null;
	}

	public static String genPositiveCondsForPredF(GenerateCVC1 cvc, QueryBlockDetails queryBlock, Node n,
			String index) {
		if (n != null) {
			if (n.getType().equalsIgnoreCase(Node.getColRefType())) {

				Expr tempExpr = index.matches("-?\\d+") ? ctx.mkInt(index) : ctx.mkIntConst(index);

				if (Configuration.isEnumInt.equalsIgnoreCase("true")) {
					EnumSort currentSort = (EnumSort) ConstraintGenerator.ctxSorts.get(cvc.enumArrayIndex);
					tempExpr = ctx.mkConst(index, currentSort);
				}
				return smtMap(n.getColumn(), tempExpr).toString();

			} else if (n.getType().equalsIgnoreCase(Node.getCastNodeType())) {
				// shalini: CAST node: extract the string from the left child and convert based
				// on castType
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
									DatatypeSort dateSort = (DatatypeSort) ctxSorts.get("DATE");
									FuncDecl constructor = dateSort.getConstructors()[0];
									Expr dateValue = ctx.mkApp(constructor, ctx.mkInt(y), ctx.mkInt(m), ctx.mkInt(d));
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
									DatatypeSort timeSort = (DatatypeSort) ctxSorts.get("TIME");
									FuncDecl constructor = timeSort.getConstructors()[0];
									Expr timeValue = ctx.mkApp(constructor, ctx.mkInt(h), ctx.mkInt(m), ctx.mkInt(s));
									return timeValue.toString();
								} catch (NumberFormatException e) {
									// Number format error - fall through
								}
							}
						}
					}
				}
				// Fallback: process the inner expression
				return genPositiveCondsForPredF(cvc, queryBlock, n.getLeft(), index);
			} else if (n.getType().equalsIgnoreCase(Node.getValType())) {
				if (!n.getStrConst().contains("$")) {
					if (n.getStrConst().contains("/")) {
						String[] values = n.getStrConst().split("/");
						return "(/ " + values[0] + " " + values[1] + " )";
					}
					return getSMTValue(n);
				}

				else
					return queryBlock.getParamMap().get(n.getStrConst());
			}
			// chaitra if predicate contains time - return it as date datatype
			else if (n.getType().equalsIgnoreCase(Node.getTimeType())) {
				String[] values = n.getStrConst().split(":");
				int h = Integer.parseInt(values[0]);
				int m = Integer.parseInt(values[1]);
				int s = Integer.parseInt(values[2]);
				DatatypeSort timeSort = (DatatypeSort) ctxSorts.get("TIME");

				FuncDecl getDay = ctxFuncDecls.get("getHours");
				FuncDecl getMonth = ctxFuncDecls.get("getMinutes");
				FuncDecl getYear = ctxFuncDecls.get("getSeconds");

				FuncDecl constructor = timeSort.getConstructors()[0];
				Expr dateValue = ctx.mkApp(constructor, ctx.mkInt(h), ctx.mkInt(m), ctx.mkInt(s));
				return dateValue.toString();
			}
			// chaitra if predicate contains date - return it as date datatype
			else if (n.getType().equalsIgnoreCase(Node.getDateType())) {
				// chaitra changed here for date - handle intervals
				if (n.getStrConst().contains("interval") || n.getStrConst().contains("INTERVAL")) {
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
					DatatypeSort dateSort = (DatatypeSort) ctxSorts.get("DATE");

					FuncDecl getDay = ctxFuncDecls.get("getDay");
					FuncDecl getMonth = ctxFuncDecls.get("getMonth");
					FuncDecl getYear = ctxFuncDecls.get("getYear");

					FuncDecl constructor = dateSort.getConstructors()[0];
					Expr dateValue = ctx.mkApp(constructor, ctx.mkInt(y), ctx.mkInt(m), ctx.mkInt(d));
					return dateValue.toString();
				}
			} else if (n.getType().equalsIgnoreCase(Node.getBroNodeType())
					|| n.getType().equalsIgnoreCase(Node.getBaoNodeType())
					|| n.getType().equalsIgnoreCase(Node.getLikeNodeType()) ||
					n.getType().equalsIgnoreCase(Node.getAndNodeType())
					|| n.getType().equalsIgnoreCase(Node.getOrNodeType())) {
				if (isCVC3) {
					return "( " + genPositiveCondsForPredF(cvc, queryBlock, n.getLeft(), index) + " " + n.getOperator()
							+ " " +
							genPositiveCondsForPredF(cvc, queryBlock, n.getRight(), index) + ")";
				} else {

					if ((n.getLeft() != null && n.getLeft().getStrConst() != null
							&& n.getLeft().getStrConst().contains("INTERVAL")) ||
							(n.getRight() != null && n.getRight().getStrConst() != null
									&& n.getRight().getStrConst().contains("INTERVAL"))) {
						return "(addIntervalDays " + genPositiveCondsForPredF(cvc, queryBlock, n.getLeft(), index) + " "
								+
								genPositiveCondsForPredF(cvc, queryBlock, n.getRight(), index) + ")";
					} else {
						return "( " + (n.getOperator().equals("/=") ? "not (= " : n.getOperator()) + " "
								+ genPositiveCondsForPredF(cvc, queryBlock, n.getLeft(), index) + " " +
								genPositiveCondsForPredF(cvc, queryBlock, n.getRight(), index)
								+ (n.getOperator().equals("/=") ? " )" : "") + " )";
					}
				}
			} else if (n.getType().equalsIgnoreCase(Node.getAggrNodeType())) {
				Expr tempExpr = ctx.mkInt(index);

				return smtMap(n.getColumn(), tempExpr).toString();
			}
			// chaitra changed here for extract node type for date : e.g. extract (year from
			// date)
			else if (n.getType().equalsIgnoreCase(Node.getExtractFuncType())) {

				Expr tempExpr = ctx.mkInt(index);
				if (Configuration.isEnumInt.equalsIgnoreCase("true")) {
					EnumSort currentSort = (EnumSort) ConstraintGenerator.ctxSorts.get(cvc.enumArrayIndex);
					tempExpr = ctx.mkConst(index, currentSort);
				}

				String part = n.getStrConst();
				String funcName = "";
				if (part.equalsIgnoreCase("year"))
					funcName = "getYear";
				else if (part.equalsIgnoreCase("month"))
					funcName = "getMonth";
				else if (part.equalsIgnoreCase("day"))
					funcName = "getDay";
				else
					return null;
				Expr getPart = ctx.mkApp(ctxFuncDecls.get(funcName), smtMap(n.getLeft().getColumn(), tempExpr));

				return getPart.toString();
			} else if (n.getType().equalsIgnoreCase(Node.getCastNodeType())) {
				// Handle CAST(expression AS type)
				String targetType = n.getCastType().toString().toUpperCase();
				String innerExpr = genPositiveCondsForPredF(cvc, queryBlock, n.getLeft(), index);
				if (innerExpr == null || innerExpr.isEmpty()) {
					// skip the no-index fallback - we need to preserve the index parameter
					// the direct handling below will create the correct constraint with index
					innerExpr = "";
				}
				if (innerExpr == null || innerExpr.isEmpty()) {
					Node left = n.getLeft();
					if (left != null) {
						if (left.getType().equalsIgnoreCase(Node.getColRefType())) {
							Expr tempExpr = ctx.mkInt(index);
							innerExpr = smtMap(left.getColumn(), tempExpr).toString();
						} else if (left.getType().equalsIgnoreCase(Node.getValType())) {
							if (!left.getStrConst().contains("/")) {
								if (!left.getStrConst().contains("$"))
									innerExpr = getSMTValue(left);
								else
									innerExpr = queryBlock.getParamMap().get(left.getStrConst());
							} else {
								String[] values = left.getStrConst().split("/");
								innerExpr = "(/ " + values[0] + " " + values[1] + " )";
							}
						}
					}
				}
				// For CAST INT AS REAL - use (to_real expr)
				if ((targetType.contains("REAL") || targetType.contains("NUMERIC") || targetType.contains("DECIMAL"))) {
					return "(to_real " + innerExpr + ")";
				}
				// For CAST REAL AS INT - use (to_int expr)
				else if (targetType.contains("INT") || targetType.contains("INTEGER")) {
					return "(to_int " + innerExpr + ")";
				}
				// For other types, pass through
				return innerExpr;
			}

		}
		return null;
	}

	private static String getSMTValue(Node n) {
		if (n == null || n.getStrConst() == null) {
			return null;
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
	 * Generate SMT/CVC constraints for the given node
	 * 
	 * @param queryBlock
	 * @param n
	 * @return
	 */

	public static String genPositiveCondsForPred(QueryBlockDetails queryBlock, Node n) {
		if (n.getType().equalsIgnoreCase(Node.getColRefType())) {

			return smtMap(n.getColumn(), n);

		} else if (n.getType().equalsIgnoreCase(Node.getCastNodeType())) {
			return genPositiveCondsForPred(queryBlock, n.getLeft());
		} else if (n.getType().equalsIgnoreCase(Node.getValType())) {

			if (!n.getStrConst().contains("$"))
				return getSMTValue(n);
			else
				return queryBlock.getParamMap().get(n.getStrConst());
		} else if (n.getType().equalsIgnoreCase(Node.getCastNodeType())) {
			// Handle CAST(expression AS type)
			String targetType = n.getCastType().toString().toUpperCase();
			String innerExpr = genPositiveCondsForPred(queryBlock, n.getLeft());
			if (innerExpr == null || innerExpr.isEmpty()) {
				return null;
			}
			// For CAST INT AS REAL - use (to_real expr)
			if ((targetType.contains("REAL") || targetType.contains("NUMERIC") || targetType.contains("DECIMAL"))) {
				return "(to_real " + innerExpr + ")";
			}
			return innerExpr;
		} else if (n.getType().equalsIgnoreCase(Node.getBroNodeType())
				|| n.getType().equalsIgnoreCase(Node.getBaoNodeType())
				|| n.getType().equalsIgnoreCase(Node.getLikeNodeType()) ||
				n.getType().equalsIgnoreCase(Node.getAndNodeType())
				|| n.getType().equalsIgnoreCase(Node.getOrNodeType())) {

			if (isCVC3) {
				return "(" + genPositiveCondsForPred(queryBlock, n.getLeft()) + " " + n.getOperator() + " " +
						genPositiveCondsForPred(queryBlock, n.getRight()) + ")";
			} else {
				return "(" + (n.getOperator().equals("/=") ? "not (= " : n.getOperator()) + " "
						+ genPositiveCondsForPred(queryBlock, n.getLeft()) + " " +
						genPositiveCondsForPred(queryBlock, n.getRight()) + (n.getOperator().equals("/=") ? ")" : "")
						+ ")";
			}

		}
		return null;
	}

	/**
	 * 
	 * @param cvc
	 * @param queryBlock
	 * @param n
	 * @param index
	 * @param paramId
	 * @return
	 */
	public static String genPositiveCondsForPred(QueryBlockDetails queryBlock, Node n, int index, String paramId) {// For
																													// parameters
		ConstraintGenerator constraintGenerator = new ConstraintGenerator();
		return constraintGenerator.genPositiveCondsForPred(queryBlock, n, index);
	}

	/**
	 * 
	 * @param cvc
	 * @param queryBlock
	 * @param n
	 * @param index
	 * @param paramId
	 * @return
	 */
	public static String genPositiveCondsForPredWithAssert(QueryBlockDetails queryBlock, Node n, int index,
			String paramId) {// For parameters

		ConstraintGenerator constraintGenerator = new ConstraintGenerator();

		return "(assert " + constraintGenerator.genPositiveCondsForPred(queryBlock, n, index) + ")\n";

	}

	/**
	 * 
	 * @param queryBlock
	 * @param n
	 * @param hm
	 * @return
	 */
	public static String genPositiveCondsForPred(QueryBlockDetails queryBlock, Node n, Map<String, Character> hm) {
		Character index = null;
		if (n.getType().equalsIgnoreCase(Node.getColRefType())) {
			if (hm.containsKey(n.getTable().getTableName())) {
				index = hm.get(n.getTable().getTableName());
			} else {
				Iterator it = hm.entrySet().iterator();
				index = 'i';
				while (it.hasNext()) {
					Map.Entry pairs = (Map.Entry) it.next();
					char temp = (Character) pairs.getValue();
					if (temp > index)
						index = temp;
				}
				index++;
				hm.put(n.getTable().getTableName(), index);
			}
			// return cvcMap(n.getColumn(), index+"");

			return smtMap(n.getColumn(), ctx.mkIntConst(index + "")).toString();

		} else if (n.getType().equalsIgnoreCase(Node.getValType())) {
			if (!n.getStrConst().contains("$"))
				return getSMTValue(n);
			else
				return queryBlock.getParamMap().get(n.getStrConst());
		} else if (n.getType().equalsIgnoreCase(Node.getBroNodeType())
				|| n.getType().equalsIgnoreCase(Node.getBaoNodeType())
				|| n.getType().equalsIgnoreCase(Node.getLikeNodeType()) ||
				n.getType().equalsIgnoreCase(Node.getAndNodeType())
				|| n.getType().equalsIgnoreCase(Node.getOrNodeType())) {

			return "(and " + (n.getOperator().equals("/=") ? "not (= " : n.getOperator()) + " "
					+ genPositiveCondsForPred(queryBlock, n.getLeft(), hm) + " " +
					genPositiveCondsForPred(queryBlock, n.getRight(), hm)
					+ (n.getOperator().equals("/=") ? ")" : "");

		}
		return "";
	}

	// /**
	// * Generate CVC3 constraints for the given node and its tuple position.
	// *
	// * @param queryBlock
	// * @param n
	// * @param index
	// * @return
	// */
	// public static String genPositiveCondsForPredAsString(GenerateCVC1 cvc,
	// QueryBlockDetails queryBlock, Node n,
	// int index) {

	// if (isCVC3) {
	// return "" + genPositiveCondsForPred(queryBlock, n, index) + "";
	// } else {
	// return "" + genPositiveCondsForPred(queryBlock, n, index) + "";
	// }
	// }

	// /**
	// *
	// * @param left
	// * @param right
	// * @return
	// */
	// public static String processImpliedConstraints(String left, String right) {
	// String result = "";

	// if (isCVC3) {
	// result = "ASSERT " + left + " => " + right + ";\n";
	// } else {
	// result = "(assert " + "(=> " + left + " " + right + ")) \n";
	// }
	// return result;
	// }

	// /**
	// *
	// * @param col
	// * @param index
	// * @param constraint
	// * @return
	// */
	// public String getAndSetNotNullValuesBeforeFooter(Column col, Integer index) {

	// String constraint;

	// if (col != null && col.getCvcDatatype() != null
	// && (col.getCvcDatatype().equalsIgnoreCase("INT") ||
	// col.getCvcDatatype().equalsIgnoreCase("REAL")
	// || col.getCvcDatatype().equalsIgnoreCase("TIME")
	// || col.getCvcDatatype().equalsIgnoreCase("TIMESTAMP")
	// || col.getCvcDatatype().equalsIgnoreCase("DATE"))) {

	// // constraint += "\n (assert NOTISNULL_"+col.getColumnName()+"
	// // "+smtMap(col,Integer.toString(index))+")";
	// constraint = "\n (assert (get" + col.getColumnName() + " "
	// + smtMap(col, (IntExpr) ctx.mkInt(index)).toString() + "))";

	// } else {

	// constraint = "\n (assert (NOTISNULL_" + col.getCvcDatatype() + " "
	// + smtMap(col, (IntExpr) ctx.mkInt(index)).toString() + "))";

	// }
	// return constraint;
	// }

	// /**
	// * This method is used by GenerateConstraintsRelatedToBranchQuery class for
	// * generating ProjectedColBranchQuery constraints
	// *
	// * @param cvc
	// * @param tempTable
	// * @param index
	// * @param pos
	// * @param operator
	// * @param rightConstraint
	// * @param col
	// * @return
	// */
	// public String getStringConstraints(Table tempTable, Integer index, Integer
	// pos, String operator,
	// String rightConstraint, Column col) {

	// String constraint = "";
	// String smtCond = "";

	// if (isCVC3) {
	// constraint = "\n ASSERT (O_" + tempTable + "[" + index + "]." + pos + " " +
	// operator + " " + rightConstraint
	// + ");\n";

	// } else {
	// String colName = col.getColumnName() + pos;
	// smtCond = "(" + colName + " " + "(select O_" + tempTable + " " + index + ")
	// )";

	// constraint = "\n (assert (" + (operator.equals("/=") ? "not (= " : operator)
	// + " " + rightConstraint + " "
	// + ((smtCond != null && !smtCond.isEmpty()) ? smtCond : "") +
	// (operator.equals("/=") ? ")" : "") + "))\n";

	// }

	// return constraint;
	// }

	// /**
	// * This method is used by GenerateConstraintsRelatedToBranchQuery class for
	// * generating StringConstraintsForBranchQuery constraints
	// *
	// * @param cvc
	// * @param tempTable
	// * @param index
	// * @param pos
	// * @param operator
	// * @param tempTableRight
	// * @param indexRight
	// * @param posRight
	// * @param col
	// * @return
	// */
	// public String getStringConstraints(Table tempTable, Integer index, Integer
	// pos, String operator,
	// Table tempTableRight, Integer indexRight, Integer posRight, Column leftCol,
	// Column rightCol) {

	// String constraint = "";
	// String smtCond1 = "";
	// String smtCond2 = "";

	// if (isCVC3) {

	// constraint += "\n ASSERT ";
	// if (operator.equals("!=")) {
	// constraint += " NOT ";
	// operator = "=";
	// }
	// constraint += "(O_" + tempTable.getTableName() + "[" + index + "]." + pos;
	// constraint += operator + " O_" + tempTableRight.getTableName() + "[" +
	// indexRight + "]." + posRight + ");";

	// } else {
	// String colName = leftCol.getColumnName() + pos;

	// smtCond1 = "(" + colName + " " + " (select O_" + tempTable + " " + index + ")
	// )";
	// smtCond2 = "(" + rightCol.getColumnName() + "" + posRight + " " + " (select
	// O_" + tempTableRight + " "
	// + indexRight + ") )";

	// constraint = "\n (assert (" + (operator.equals("/=") ? "not (= " : operator)
	// + " " + smtCond1 + " "
	// + smtCond2 + (operator.equals("/=") ? ")" : "") + "))";

	// }

	// return constraint;
	// }

	// public String getConstraintsForSUMWithAssert(String operator, String opVal,
	// String constraint,
	// Table tempHavingTable, Integer j, Integer tempHavingColIndex, Column col) {

	// String addConstraint = "";
	// if (isCVC3) {

	// if (constraint == null || constraint.isEmpty()) {
	// addConstraint = "\n ASSERT (";
	// }

	// addConstraint += constraint + " + " + "O_" + tempHavingTable.getTableName() +
	// "[" + j + "]."
	// + tempHavingColIndex;

	// if (constraint == null || constraint.isEmpty()) {
	// addConstraint += ");";
	// }
	// } else {

	// if (constraint == null || constraint.isEmpty()) {
	// addConstraint = "\n (assert (";
	// }
	// String colName = col.getColumnName() + tempHavingColIndex;
	// addConstraint += " + (" + constraint + ") (" + colName + " " + "(select O_" +
	// tempHavingTable + " " + j
	// + "))";

	// if (constraint == null || constraint.isEmpty()) {
	// addConstraint += "));";
	// }

	// }

	// return addConstraint;

	// }

	// public String getConstraintsForSUMWithoutAssert(String operator, String
	// opVal, String constraint,
	// Table tempHavingTable, Integer j, Integer tempHavingColIndex, Column col) {

	// String addConstraint = "";
	// if (isCVC3) {
	// addConstraint += constraint + " + " + "O_" + tempHavingTable.getTableName() +
	// "[" + j + "]."
	// + tempHavingColIndex;
	// } else {
	// String colName = col.getColumnName() + tempHavingColIndex;
	// addConstraint += " + (" + constraint + ") (" + colName + " " + "(select O_" +
	// tempHavingTable + " " + j
	// + "))";
	// }
	// return addConstraint;

	// }

	// public String getConstraintsForAVG(String constraint, int count, String
	// operator, String value, Column col) {
	// String addConstraint = "";

	// if (isCVC3) {
	// addConstraint += "\n ASSERT ((";
	// addConstraint += constraint + ") / " + count;
	// addConstraint += " " + operator + " " + value + ");";

	// } else {

	// addConstraint += "\n(assert (" + (operator.equals("/=") ? "not (= " :
	// operator) + " (/ " + constraint + " "
	// + count + ") " + value + (operator.equals("/=") ? ")" : "") + "))";
	// }
	// return addConstraint;
	// }

	public static String removeAllDigit(String str) {
		// Converting the given string
		// into a character array
		char[] charArray = str.toCharArray();
		String result = "";

		// Traverse the character array
		for (int i = 0; i < charArray.length; i++) {

			// Check if the specified character is not digit
			// then add this character into result variable
			if (!Character.isDigit(charArray[i])) {
				result = result + charArray[i];
			}
		}
		return result;
	}

	public static String GetGroupByConstraintsForSubqueryTableWithoutCount(GenerateCVC1 cvc, QueryBlockDetails qbt,
			String subqueryType) {
		File testFile = null;

		// write api code here to generate string
		testFile = new File(Configuration.homeDir + "/temp_smt/groupbyconstraints" + ".smt");
		if (!testFile.exists()) {

			testFile.delete();
		}

		String ConstraintsStr = "";

		try {
			testFile.createNewFile();
			// number of tuples
			int numberOfTuples = 3;
			int numberOfGroups = 2;

			ArrayList<Node> groupByNodes;
			ArrayList<Node> projectedNodes = new ArrayList<>();

			int i, j;
			groupByNodes = qbt.getGroupByNodes();

			for (i = 0; i < qbt.getProjectedCols().size(); i++) {
				if (qbt.getProjectedCols().get(i).getAgg() != null) {
					projectedNodes.add(qbt.getProjectedCols().get(i));
				}
			}

			boolean isJoin = false;
			if (qbt.getBaseRelations().size() > 1)
				isJoin = true;

			Node[] projectedColumnNodes = new Node[projectedNodes.size()]; // all the columns which are projected
			Node[] groupByColumnNodes = new Node[groupByNodes.size()]; // all the columns which are in group by

			int numberOfGroupByColumns = groupByNodes.size();
			int numberOfPRojectedColumns = projectedNodes.size();

			// String[] attrNamesSQ = new String[numberOfGroupByColumns +
			// numberOfPRojectedColumns]; // names of attributes
			Vector<String> attrNamesSQ = new Vector<String>(); // in SQ table
			Vector<Sort> attrTypesSQ = new Vector<Sort>();
			// Sort[] attrTypesSQ = new Sort[numberOfGroupByColumns +
			// numberOfPRojectedColumns]; // types of attributes in
			// SQ table

			String subquery_table_name = "GSQ" + qbt.getLevel(); // hardcoded now, need changes when multilevel approach
																	// is implemented
			String[] groupby_column = new String[numberOfGroupByColumns];

			for (i = 0; i < numberOfPRojectedColumns; i++) {
				projectedColumnNodes[i] = projectedNodes.get(i);
			}

			for (i = 0; i < groupByNodes.size(); i++) {
				groupByColumnNodes[i] = groupByNodes.get(i);
				groupby_column[i] = groupByColumnNodes[i].getColumn().getColumnName();
				attrNamesSQ.add(groupby_column[i]);
				String groupby_column_dt = groupByColumnNodes[i].getColumn().getCvcDatatype();

				attrTypesSQ.add(getColumnSort(groupby_column_dt));
				//
				attrNamesSQ.set(i, subquery_table_name + "_" + attrNamesSQ.get(i) + i);
			}

			String[] agg_functions = new String[projectedNodes.size()];
			String[] agg_column_name = new String[projectedNodes.size()];
			String[] agg_column_dt = new String[projectedNodes.size()];
			String agg_table = removeAllDigit(qbt.getBaseRelations().get(0)).toLowerCase();

			AggregateFunction[] aggColumn = new AggregateFunction[projectedNodes.size()];
			Solver dummySol = ctx.mkSolver(); // for getting string form of z3 context declarations
			int[] indexOfProjectedColmnsInSQ = new int[projectedNodes.size()];

			for (j = 0; j < projectedNodes.size(); j++) {
				aggColumn[j] = projectedColumnNodes[j].getAgg();
				agg_functions[j] = aggColumn[j].getFunc().toString();
				agg_column_name[j] = aggColumn[j].getAggExp().getColumn().getColumnName();
				attrNamesSQ.add(agg_column_name[j]); // i last element

				agg_column_dt[j] = aggColumn[j].getAggExp().getColumn().getCvcDatatype();
				agg_table = aggColumn[j].getAggExp().getTable().getTableName();
				attrTypesSQ.add(getColumnSort(agg_column_dt[j]));
				attrNamesSQ.set(i + j, subquery_table_name + "_" + agg_functions[j] + attrNamesSQ.get(i + j));
				indexOfProjectedColmnsInSQ[j] = i + j;
			}

			String arrNameSQ = "O_" + subquery_table_name;

			// creating context for subquery_table_name
			Expr aex = putTableInCtx(cvc, attrNamesSQ, attrTypesSQ, subquery_table_name);

			ArrayList attrNamesBQArrayList = cvc.getDatatypeColumns();
			// if join present in subquery - base table for aggregate will be taken from
			// fromTempJoinTableName

			if (isJoin) {
				agg_table = cvc.subqueryConstraintsMap.get("from").SQTableName.keySet().iterator().next();
				attrNamesBQArrayList = cvc.subqueryConstraintsMap.get("from").SQColumns.get(agg_table);
			}

			Vector<String> attrNamesBQ = new Vector<String>();
			Vector<Sort> attrTypesBQ = new Vector<Sort>();

			// creating context for base_table_name

			String arrNameBQ = "O_" + agg_table;

			if (isJoin) {
				// attrNamesBQ = new String[attrNamesBQArrayList.size()];
				// attrTypesBQ = new Sort[attrNamesBQArrayList.size()];
				for (int k = 0; k < attrNamesBQArrayList.size(); k++) {
					// Column column = cvc.getResultsetColumns().get(k);

					arrNameBQ = "O_" + cvc.subqueryConstraintsMap.get("from").SQTableName.keySet().iterator().next();

					attrNamesBQ.add("" + attrNamesBQArrayList.get(k));
					attrTypesBQ.add(getColumnSort(
							cvc.subqueryConstraintsMap.get("from").SQColumnsDataTypes.get(agg_table).get(k)));
				}
			} else {
				// attrNamesBQ = new String[attrNamesBQArrayList.size() - 1];
				// attrTypesBQ = new Sort[attrNamesBQArrayList.size() - 1];
				for (int k = 0; k < attrNamesBQArrayList.size() - 1; k++) {
					Column column = cvc.getResultsetColumns().get(k + 1);

					arrNameBQ = "O_" + agg_table;
					attrNamesBQ.add(agg_table + "_" + column.getColumnName() + k);
					attrTypesBQ.add(getColumnSort(column.getCvcDatatype()));
				}
			}

			// putting base table in context
			Expr aexBQ = putTableInCtx(cvc, attrNamesBQ, attrTypesBQ, agg_table);
			// end putting base table in context

			// adding dummy asserts so that solver has relevant declarations in string
			// returned by toString()
			BoolExpr dummyAssert = ctx.mkDistinct(aex);

			dummySol.add(dummyAssert);

			String[] constraints = dummySol.toString().split("\n");

			String tempStr = "";

			Vector<String> includedStatements = new Vector<String>();

			for (String statement : constraints) {
				if (statement.contains("_TupleType ") || statement.contains("declare-fun O_")) {
					includedStatements.add(statement);
				}
				if (statement.contains("(assert")) {
					break;
				}
			}
			tempStr += String.join("\n\n", includedStatements);

			// Tuple type declaration constraints of Subquery table
			// ***************************************************************************************************
			// Aggregate functions

			Expr[] assertAggValDef = new Expr[projectedNodes.size()];
			Expr[] assertAggValCall = new Expr[projectedNodes.size()];
			String[] functionName = new String[projectedNodes.size()];
			Expr[] arrForIndexI = new Expr[] { ctx.mkIntConst("i") };

			IntExpr[] arrForIntIndex = new IntExpr[numberOfTuples + 1];

			arrForIntIndex[0] = (IntExpr) ctx.mkInt(0);

			FuncDecl[] DeclAssertAggVal = new FuncDecl[projectedNodes.size()]; // Function declaration for asserting agg
																				// val fun
			String[] DefineAssertAggVal = new String[projectedNodes.size()]; // Function defination for asserting agg
																				// val fun

			for (int p = 0; p < numberOfTuples; p++) {
				arrForIntIndex[p] = (IntExpr) ctx.mkInt(p + 1);
			}

			if (projectedNodes.size() > 0) {

				Expr eqs = ctx.mkEq(dummyAssert, dummyAssert);

				for (i = 0; i < projectedNodes.size(); i++) {

					functionName[i] = "GETAGGVAL" + projectedColumnNodes[i].getAgg().getFunc()
							+ projectedColumnNodes[i].getColumn().getColumnName(); // function names

					DeclAssertAggVal[i] = ctx.mkFuncDecl(functionName[i], ctx.getIntSort(), ctx.mkBoolSort()); // creating
																												// function
																												// declarations

					ctxFuncDecls.put(functionName[i], DeclAssertAggVal[i]); // putting function declaration in context

					DefineAssertAggVal[i] = "(define-fun " + functionName[i] + "((i Int))Bool"; // function defination
																								// using "define-fun"

					if (projectedColumnNodes[i].getAgg().getFunc().equals("SUM")) {
						// function definations if it is SUM

						Expr[] colValueSQ = new Expr[numberOfGroupByColumns + 1];
						for (int s = 0; s < numberOfGroupByColumns; s++) {
							colValueSQ[s] = smtMap(arrNameSQ, "i", -1, s);
						}
						Expr colValueSQ1 = smtMap(arrNameSQ, "i", -1, indexOfProjectedColmnsInSQ[i]);

						Expr[][] colValueBQ = new Expr[numberOfGroupByColumns + 1][numberOfTuples];
						BoolExpr[][] calculateAggregate = new BoolExpr[numberOfTuples][numberOfGroupByColumns];
						Expr[] ifthenelseExpr = new Expr[numberOfTuples];
						ArithExpr[][] multieExpr = new ArithExpr[numberOfTuples][2];
						Expr[] multiplyexpr = new Expr[numberOfTuples];
						ArithExpr[] addExpr = new ArithExpr[numberOfTuples];
						Expr[] andForIfthenelse = new Expr[numberOfTuples];

						// Done for base table
						// arrName contains name if table which will be used in select
						// Creating base relation and finally tuple accessor for the table

						// Expr t1 = ctx.mkInt(1);
						// Expr t2 = ctx.mkInt(0);
						// Function 1

						String temp = "";

						if (isJoin) {
							String joinTable = cvc.subqueryConstraintsMap.get("from").SQTableName.keySet().iterator()
									.next();
							for (int q = 0; q < cvc.subqueryConstraintsMap.get("from").SQColumns.get(joinTable)
									.size(); q++) {

								attrNamesBQ.set(q, removeAllDigit(attrNamesBQ.get(q).split("__")[1]));

							}
						}

						for (int p = 0; p < numberOfTuples; p++) {
							int s;
							for (s = 0; s < numberOfGroupByColumns; s++) {
								colValueBQ[s][p] = smtMap(arrNameBQ, "i", p + 1,
										cvc.getDatatypeColumns().indexOf(groupby_column[s]));
								calculateAggregate[p][s] = (BoolExpr) ctx.mkEq(colValueSQ[s], colValueBQ[s][p]);

							}
							andForIfthenelse[p] = ctx.mkAnd(calculateAggregate[p]);
							colValueBQ[s][p] = smtMap(arrNameBQ, "i", p + 1,
									cvc.getDatatypeColumns().indexOf(agg_column_name[i]));

							ifthenelseExpr[p] = ctx.mkITE((BoolExpr) andForIfthenelse[p], ctx.mkInt(1), ctx.mkInt(0));
							multieExpr[p][1] = (ArithExpr) colValueBQ[numberOfGroupByColumns][p];
							multieExpr[p][0] = (ArithExpr) ifthenelseExpr[p];
							multiplyexpr[p] = ctx.mkMul(multieExpr[p]);
							addExpr[p] = (ArithExpr) multiplyexpr[p];

						}

						Expr additionexpr1 = ctx.mkAdd(addExpr);
						Expr eqexpr2 = ctx.mkEq(colValueSQ1, additionexpr1);
						assertAggValCall[i] = DeclAssertAggVal[i].apply(arrForIndexI);
						assertAggValDef[i] = eqexpr2;

					}

					else if (projectedColumnNodes[i].getAgg().getFunc().equals("COUNT")) {
						Expr[] colValueSQ = new Expr[numberOfGroupByColumns + 1];
						for (int s = 0; s < numberOfGroupByColumns; s++) {
							colValueSQ[s] = smtMap(arrNameSQ, "i", -1, s);
						}
						Expr colValueSQ1 = smtMap(arrNameSQ, "i", -1, indexOfProjectedColmnsInSQ[i]);
						Expr[][] colValueBQ = new Expr[numberOfGroupByColumns + 1][numberOfTuples];
						BoolExpr[][] calculateAggregate = new BoolExpr[numberOfTuples][numberOfGroupByColumns];
						Expr[] ifthenelseExpr = new Expr[numberOfTuples];
						ArithExpr[][] multieExpr = new ArithExpr[numberOfTuples][2];
						Expr[] multiplyexpr = new Expr[numberOfTuples];
						ArithExpr[] addExpr = new ArithExpr[numberOfTuples];
						Expr[] andForIfthenelse = new Expr[numberOfTuples];

						// Done for base table
						// arrName contains name if table which will be used in select
						// Creating base relation and finally tuple accessor for the table

						// Function 1

						for (int p = 0; p < numberOfTuples; p++) {
							int s;
							for (s = 0; s < numberOfGroupByColumns; s++) {
								colValueBQ[s][p] = smtMap(arrNameBQ, "i", p + 1,
										cvc.getDatatypeColumns().indexOf(groupby_column[s]));
								calculateAggregate[p][s] = (BoolExpr) ctx.mkEq(colValueSQ[s], colValueBQ[s][p]);

							}
							andForIfthenelse[p] = ctx.mkAnd(calculateAggregate[p]);
							colValueBQ[s][p] = smtMap(arrNameBQ, "i", p,
									cvc.getDatatypeColumns().indexOf(agg_column_name[i]));

							ifthenelseExpr[p] = ctx.mkITE((BoolExpr) andForIfthenelse[p], ctx.mkInt(1), ctx.mkInt(0));
							multieExpr[p][0] = (ArithExpr) ifthenelseExpr[p];
							addExpr[p] = (ArithExpr) ifthenelseExpr[p];
						}
						Expr additionexpr1 = ctx.mkAdd(addExpr);
						Expr eqexpr2 = ctx.mkEq(colValueSQ1, additionexpr1);
						assertAggValCall[i] = DeclAssertAggVal[i].apply(arrForIndexI);
						assertAggValDef[i] = eqexpr2;
					}

				}
			}

			// Function 2 SQ Forward function
			String functionName2 = "SQTABLE_" + qbt.getLevel() + "_FORWARD";
			FuncDecl sqTableIForward = ctx.mkFuncDecl(functionName2, ctx.getIntSort(), ctx.mkBoolSort());
			ctxFuncDecls.put(functionName2, sqTableIForward);

			String DefinesqTableIForward = "(define-fun " + functionName2 + "((i1 Int))Bool";

			Expr[] arrForIndexj1 = new Expr[] { ctx.mkIntConst("j1") };

			Expr compareExpr1 = ctx.mkLt((ArithExpr) (IntExpr) ctx.mkInt(0), (ArithExpr) ctx.mkIntConst("j1"));
			Expr compareExpr2 = ctx.mkLe((ArithExpr) ctx.mkIntConst("j1"),
					(ArithExpr) (IntExpr) ctx.mkInt(numberOfGroups));
			Expr andExpr1 = ctx.mkAnd((BoolExpr) compareExpr1, (BoolExpr) compareExpr2);

			Expr[] colValueBQForForward = new Expr[numberOfGroupByColumns];
			Expr[] colValueSQForForward = new Expr[numberOfGroupByColumns];
			BoolExpr[] eqExprForward = new BoolExpr[numberOfGroupByColumns + 1];

			for (i = 0; i < numberOfGroupByColumns; i++) {
				colValueSQForForward[i] = smtMap(arrNameSQ, "j1", -1, i);
				colValueBQForForward[i] = smtMap(arrNameBQ, "i1", -1,
						cvc.getDatatypeColumns().indexOf(groupby_column[i]));
				eqExprForward[i] = (BoolExpr) ctx.mkEq(colValueSQForForward[i], colValueBQForForward[i]);
			}
			eqExprForward[i] = (BoolExpr) andExpr1;

			Expr andExpr2 = ctx.mkAnd(eqExprForward);
			Expr exitsExpr1 = ctx.mkExists(arrForIndexj1, andExpr2, 1, null, null, null, null);

			// Function 3 SQ Backward function
			String functionName3 = "SQTABLE_" + qbt.getLevel() + "_BACKWARD";
			FuncDecl sqTableIBackward = ctx.mkFuncDecl(functionName3, ctx.getIntSort(), ctx.mkBoolSort());
			ctxFuncDecls.put(functionName3, sqTableIBackward);
			String DefinesqTableIBackward = "(define-fun " + functionName3 + "((k1 Int))Bool";

			Expr[] arrForIndexK1 = new Expr[] { ctx.mkIntConst("k1") };
			Expr[] arrForIndexL1 = new Expr[] { ctx.mkIntConst("l1") };

			Expr compareExpr3 = ctx.mkLt((ArithExpr) (IntExpr) ctx.mkInt(0), (ArithExpr) ctx.mkIntConst("l1"));
			Expr compareExpr4 = ctx.mkLe((ArithExpr) ctx.mkIntConst("l1"),
					(ArithExpr) (IntExpr) ctx.mkInt(numberOfTuples));

			Expr andExpr3 = ctx.mkAnd((BoolExpr) compareExpr3, (BoolExpr) compareExpr4);

			Expr[] colValueBQForBackward = new Expr[numberOfGroupByColumns];
			Expr[] colValueSQForBackward = new Expr[numberOfGroupByColumns];
			BoolExpr[] eqExprBackward = new BoolExpr[numberOfGroupByColumns + 1];

			for (i = 0; i < numberOfGroupByColumns; i++) {
				colValueSQForBackward[i] = smtMap(arrNameSQ, "k1", -1, i);
				colValueBQForBackward[i] = smtMap(arrNameBQ, "l1", -1,
						cvc.getDatatypeColumns().indexOf(groupby_column[i]));
				eqExprBackward[i] = (BoolExpr) ctx.mkEq(colValueSQForBackward[i], colValueBQForBackward[i]);
			}
			eqExprBackward[i] = (BoolExpr) andExpr3;

			Expr andExpr4 = ctx.mkAnd(eqExprBackward);

			Expr exitsExpr2 = ctx.mkExists(arrForIndexL1, andExpr4, 1, null, null, null, null);

			//
			ConstraintsStr += "\n\n" + tempStr;
			ConstraintsStr += "\n\n" + DefinesqTableIBackward.toString() + "\n\n " + exitsExpr2.toString() + ")"
					+ "\n\n";
			ConstraintsStr += "\n\n" + DefinesqTableIForward.toString() + "\n\n " + exitsExpr1.toString() + ")"
					+ "\n\n";

			BoolExpr[] assertSqTableIForward1 = new BoolExpr[numberOfTuples];
			BoolExpr[] assertSqTableIBackward1 = new BoolExpr[numberOfGroups];
			BoolExpr[][] assertAggValFunsCall = new BoolExpr[projectedNodes.size()][numberOfGroups];

			for (int s = 0; s < numberOfTuples; s++) {
				assertSqTableIForward1[s] = (BoolExpr) sqTableIForward.apply(arrForIntIndex[s]);
			}
			for (int s = 0; s < numberOfGroups; s++) {
				assertSqTableIBackward1[s] = (BoolExpr) sqTableIBackward.apply(arrForIntIndex[s]);
			}

			BoolExpr andAssertsForward = ctx.mkAnd(assertSqTableIForward1);
			BoolExpr andAssertsBackward = ctx.mkAnd(assertSqTableIBackward1);
			//
			// function asserts for number of tuples

			for (i = 0; i < projectedNodes.size(); i++) {
				ConstraintsStr += "\n\n" + DefineAssertAggVal[i] + "\n\n " + assertAggValDef[i].toString() + ")"
						+ "\n\n";
				for (j = 0; j < numberOfGroups; j++) {
					assertAggValFunsCall[i][j] = (BoolExpr) DeclAssertAggVal[i].apply(arrForIntIndex[j]);
				}
				BoolExpr andAssertAggValFunsCall = ctx.mkAnd(assertAggValFunsCall[i]);
				ConstraintsStr += "\n (assert " + andAssertAggValFunsCall + " )\n";

			}

			ConstraintsStr += "\n\n (assert " + andAssertsForward.toString() + ")" + "\n\n";
			ConstraintsStr += "\n\n (assert " + andAssertsBackward.toString() + ")" + "\n\n";

			FileWriter myWriter = new FileWriter(Configuration.homeDir + "/temp_smt/groupbyconstraints" + ".smt");
			myWriter.write(ConstraintsStr);
			myWriter.close();

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ConstraintsStr;

	}
	public static void replaceGSQWithHSQ(GenerateCVC1 cvc, QueryBlockDetails qb, int level) {
		if (qb == null) return;

		String oldName = "GSQ" + level;
		String newName = "HSQ" + level;

		// 1. Replace in the current block
		if (qb.baseSQ != null && qb.baseSQ.equalsIgnoreCase(oldName)) {
			qb.baseSQ = newName;
		}

		if (qb.getBaseRelations() != null) {
			for (int i = 0; i < qb.getBaseRelations().size(); i++) {
				if (qb.getBaseRelations().get(i).equalsIgnoreCase(oldName)) {
					qb.getBaseRelations().set(i, newName);
				}
			}
		}

		if (qb.getBaseSQRelations() != null) {
			for (int i = 0; i < qb.getBaseSQRelations().size(); i++) {
				if (qb.getBaseSQRelations().get(i).equalsIgnoreCase(oldName)) {
					qb.getBaseSQRelations().set(i, newName);
				}
			}
		}

		// 2. Recurse down
		if (qb.getLeftBlockDetails() != null) {
			replaceGSQWithHSQ(cvc, qb.getLeftBlockDetails(), level);
		}
		if (qb.getRightBlockDetails() != null) {
			replaceGSQWithHSQ(cvc, qb.getRightBlockDetails(), level);
		}
		for (QueryBlockDetails n : qb.getWhereClauseSubQueries()) {
			replaceGSQWithHSQ(cvc, n, level);
		}
		for (QueryBlockDetails n : qb.getFromClauseSubQueries()) {
			replaceGSQWithHSQ(cvc, n, level);
		}
		for (QueryBlockDetails n : qb.withClauseBlockDetails) {
			replaceGSQWithHSQ(cvc, n, level);
		}

		if (qb == cvc.getOuterBlock()) {
			if (cvc.aliasMappingToLevels != null) {
				for (levelStrcuture lvs : cvc.aliasMappingToLevels.values()) {
					if (lvs.getRepSQTable() != null && lvs.getRepSQTable().equalsIgnoreCase(oldName)) {
						lvs.setRepSQTable(newName);
					}
				}
			}
			if (cvc.aliasMappingToLevelsForWith != null) {
				for (levelStrcuture lvs : cvc.aliasMappingToLevelsForWith.values()) {
					if (lvs.getRepSQTable() != null && lvs.getRepSQTable().equalsIgnoreCase(oldName)) {
						lvs.setRepSQTable(newName);
					}
				}
			}
		}
	}

		public static String generateConstraintsForHSQTable(GenerateCVC1 cvc, QueryBlockDetails qbt,
			AggregateDataStructure aggregateDS, int numberOfTuples, int numberOfGroups) throws Exception {

		String hsqTableName = "HSQ" + (qbt.getLevel());
		String gsqTableName = aggregateDS.subqueryTableName;

		Vector<String> attrNamesHSQ = new Vector<String>();
		Vector<Sort> attrTypesHSQ = new Vector<Sort>();
		cvc.putNoOfMaxOutputTuples(hsqTableName, numberOfGroups);
		cvc.putNoOfOutputTuples(hsqTableName, numberOfGroups);
		cvc.getNoOfTuples().put(hsqTableName, numberOfGroups);

		Table hsqTable = new Table(hsqTableName);
		Table gsqTable = cvc.getTableMap().getSQTableByName(gsqTableName);
		
		if (gsqTable != null) {
			hsqTable.setSQType(gsqTable.getSQType());
			for (Column col : gsqTable.getColumns().values()) {
				Column hsqCol = new Column(col);
				// Update column names from GSQ prefix to HSQ prefix if necessary
				String newColName = col.getColumnName().replace(gsqTableName, hsqTableName);
				hsqCol.setColumnName(newColName);
				hsqCol.setTableName(hsqTableName);
				hsqCol.setTable(hsqTable);
				hsqTable.addColumn(hsqCol);
			}
			cvc.getTableMap().getSQTables().put(hsqTableName, hsqTable);
		}

		for (int i = 0; i < aggregateDS.attrColumnsOfSQ.size(); i++) {
			String colName = aggregateDS.attrColumnsOfSQ.get(i);
			attrNamesHSQ.add(hsqTableName + "_" + colName + i);
			attrTypesHSQ.add(aggregateDS.attrTypesOfSQ.get(i));
		}
		int hsqCntIndex = attrNamesHSQ.size();
		attrNamesHSQ.add(hsqTableName + "__XDATA_CNT");
		attrTypesHSQ.add(ctx.getIntSort());

		Expr aex = putTableInCtx(cvc, attrNamesHSQ, attrTypesHSQ, hsqTableName);

		Solver dummySol = ctx.mkSolver();
		dummySol.add(ctx.mkDistinct(aex));
		String[] dummyConstraints = dummySol.toString().split("\n");
		Vector<String> includedStatements = new Vector<String>();
		for (String statement : dummyConstraints) {
			if (statement.contains("_TupleType ") || statement.contains("declare-fun O_")) {
				includedStatements.add(statement);
			}
			if (statement.contains("(assert")) {
				break;
			}
		}
		String hsqStr = "\n\n" + String.join("\n\n", includedStatements) + "\n\n";

		String mapFuncName = hsqTableName + "_map_" + gsqTableName;
		FuncDecl mapFuncDecl = ctx.mkFuncDecl(mapFuncName, new Sort[] { ctx.getIntSort(), ctx.getIntSort() },
				ctx.mkBoolSort());
		cvc.ctxFuncDecls.put(mapFuncName, mapFuncDecl);

		Expr x0 = ctx.mkIntConst("x!0");
		Expr x1 = ctx.mkIntConst("x!1");

		BoolExpr[] mapEqs = new BoolExpr[aggregateDS.attrColumnsOfSQ.size()];
		for (int i = 0; i < aggregateDS.attrColumnsOfSQ.size(); i++) {
			Expr gsqVal = smtMap("O_" + gsqTableName, "x!0", -1, i);
			Expr hsqVal = smtMap("O_" + hsqTableName, "x!1", -1, i);
			mapEqs[i] = ctx.mkEq(gsqVal, hsqVal);
		}
		BoolExpr mapBody = ctx.mkAnd(mapEqs);

		hsqStr += "(define-fun " + mapFuncName + "((x!0 Int) (x!1 Int)) Bool\n";
		hsqStr += mapBody.toString() + "\n)\n\n";

		// Setup iteration variables
		Expr i1 = ctx.mkIntConst("i1");
		Expr[] i1Arr = new Expr[] { i1 };
		Expr j1 = ctx.mkIntConst("j1");
		Expr[] ijArr = new Expr[] { i1, j1 };

		int gsqCntIndex = aggregateDS.attrColumnsOfSQ.indexOf(aggregateDS.countColOfSQ.getColumnName());

		Expr hsqCntI = smtMap("O_" + hsqTableName, "i1", -1, hsqCntIndex);
		Expr hsqGsqCntI = smtMap("O_" + hsqTableName, "i1", -1, gsqCntIndex);

		BoolExpr a1 = ctx.mkEq(hsqCntI, ctx.mkMul((ArithExpr) hsqGsqCntI));
		BoolExpr a2 = ctx.mkOr(a1, ctx.mkEq(hsqCntI, ctx.mkInt(0)));
		BoolExpr cntConds = ctx.mkAnd(ctx.mkGe((ArithExpr) hsqCntI, ctx.mkInt(0)),
				ctx.mkLe((ArithExpr) hsqCntI, ctx.mkInt(numberOfGroups)), a2);
		Expr forall1 = ctx.mkForall(i1Arr, cntConds, 1, null, null, null, null);
		hsqStr += "(assert " + forall1.toString() + ")\n\n";

		Vector<BoolExpr> uniqueEqsList = new Vector<BoolExpr>();
		for (int i = 0; i < aggregateDS.attrColumnsOfSQ.size(); i++) {
			if (i != gsqCntIndex) {
				Expr hsqValI = smtMap("O_" + hsqTableName, "i1", -1, i);
				Expr hsqValJ = smtMap("O_" + hsqTableName, "j1", -1, i);
				uniqueEqsList.add(ctx.mkEq(hsqValI, hsqValJ));
			}
		}
		BoolExpr[] uniqueEqs = uniqueEqsList.toArray(new BoolExpr[0]);
		BoolExpr uniqueLHS = ctx.mkAnd(ctx.mkAnd(uniqueEqs), ctx.mkNot(ctx.mkEq(i1, j1)));
		Expr hsqCntJ = smtMap("O_" + hsqTableName, "j1", -1, hsqCntIndex);
		BoolExpr uniqueRHS = ctx.mkOr(ctx.mkEq(hsqCntI, ctx.mkInt(0)), ctx.mkEq(hsqCntJ, ctx.mkInt(0)));
		BoolExpr uniqueBody = ctx.mkImplies(uniqueLHS, uniqueRHS);
		Expr forall2 = ctx.mkForall(ijArr, uniqueBody, 1, null, null, null, null);
		hsqStr += "(assert " + forall2.toString() + ")\n\n";

		BoolExpr inRange = ctx.mkAnd(ctx.mkGt((ArithExpr) i1, ctx.mkInt(0)),
				ctx.mkLe((ArithExpr) i1, ctx.mkInt(numberOfGroups)));

		Expr gsqCntI = smtMap("O_" + gsqTableName, "i1", -1, gsqCntIndex);
		BoolExpr baseCntGt0 = ctx.mkGt((ArithExpr) gsqCntI, ctx.mkInt(0));

		ArrayList<Node> aggConstraints = qbt.getAggConstraints();
		String aggStr = "";
		for (int j = 0; j < aggConstraints.size(); j++) {
			aggStr += getAggregateConstraintsWithCount(cvc, aggConstraints.get(j), aggregateDS.subqueryTableName,
					aggregateDS.attrColumnsOfSQ, aggregateDS.attrTypesOfSQ, aggregateDS.columnToIndexMapInSQ, "i1");
		}
        
		String finalAssert = "(assert (forall ((i1 Int))\n" +
				"    (let ((in_range (and (> i1 0) (<= i1 " + numberOfGroups + "))))\n" +
				"        (let ((meets_sql_filter (and " + baseCntGt0.toString() + " " + aggStr + ")))\n" +
				"            (let ((a!1 (and (> " + hsqCntI.toString() + " 0)\n" +
				"                (" + mapFuncName + " i1 i1))))\n" +
				"  (ite (and in_range meets_sql_filter)\n" +
				"       a!1\n" +
				"       (= " + hsqCntI.toString() + " 0)))\n" +
				"        )\n" +
				"    )\n" +
				"))";

		hsqStr += finalAssert + "\n";

		return hsqStr;
	}



	public static String GetGroupByConstraintsForSubqueryTableWithCount(GenerateCVC1 cvc, QueryBlockDetails qbt,
			String subqueryType, String SQtableName) throws CloneNotSupportedException {
		String indexType = "Int";
		if (Configuration.getProperty("isEnumInt").equalsIgnoreCase("true"))
			indexType = cvc.enumArrayIndex;
		// write api code here to generate string

		String ConstraintsStr = "";

		try {
			// number of tuples
			int numberOfTuples = 0; // get the number of tuples in base table from cvc
			int numberOfGroups = 0;

			AggregateDataStructure aggregateDS = new AggregateDataStructure(
					SQtableName == "" ? "GSQ" + qbt.getLevel() : SQtableName + qbt.getLevel());
			ProjectedNodesData projectedNodeDs = new ProjectedNodesData();

			// ArrayList<Node> groupByNodes; // comment
			ArrayList<Node> projectedNodes = new ArrayList<>();

			int i, j;

			// groupByNodes = qbt.getGroupByNodes(); // comment

			// groupByNodes = GenConstraints.HandleExtraGroupByMutations(groupByNodes,
			// cvc.getCurrentMutant()); // comment

			for (i = 0; i < qbt.getProjectedCols().size(); i++) {
				if (qbt.getProjectedCols().get(i).getAgg() != null) {
					projectedNodes.add(qbt.getProjectedCols().get(i));
				} else if (!GenerateJoinPredicateConstraints.isPureBaoNode(qbt.getProjectedCols().get(i))) {
					projectedNodes.add(qbt.getProjectedCols().get(i));
				}
			}
			GroupByNodesData groupByNodeDS = new GroupByNodesData(qbt.getGroupByNodes());
			groupByNodeDS.noOfGroupByColumns = groupByNodeDS.getGroupByNodes().size();

			projectedNodeDs.putProjectedNodes(projectedNodes);
			projectedNodeDs.noOfProjectedColumns = projectedNodes.size();

			// to handle extra group by column mutations
			GenConstraints.HandleExtraGroupByMutations(groupByNodeDS.getGroupByNodes(), cvc.getCurrentMutant());

			// checking if join subquery table created
			boolean isJoin = true;
			// uncomment later

			Vector<String> primaryKeySQ = new Vector<String>(); // comment

			String cntColumnName = aggregateDS.subqueryTableName + "_XDATA_CNT";

			Solver dummySol = ctx.mkSolver(); // for getting string form of z3 context declarations

			// int[] indexOfProjectedColmnsInSQ = new int[projectedNodes.size()]; // comment

			HashMap<String, Object> aggTableDetails = createTempTableColumnsForAggregates(aggregateDS, groupByNodeDS,
					projectedNodeDs, subqueryType);

			// chaitra remove previously added bao node - try adding in group by??
			for (i = 0; i < qbt.getProjectedCols().size(); i++) {
				if (qbt.getProjectedCols().get(i).getAgg() == null) {
					projectedNodes.remove(qbt.getProjectedCols().get(i));
				}
			}
			// chaitra remove previously added bao node - try adding in group by?? end

			cvc.getTableMap().putSQTables((Map<String, Table>) aggTableDetails.get("TableMap"));

			Expr aex = putTableInCtx(cvc, aggregateDS.attrColumnsOfSQ,
					aggregateDS.attrTypesOfSQ, aggregateDS.subqueryTableName); // uncomment

			ArrayList attrNamesBQArrayList = cvc.getDatatypeColumns();

			String agg_table = "";
			if (isJoin) {
				if (subqueryType.equalsIgnoreCase(subqueryType)
						&& cvc.subqueryConstraintsMap.containsKey(subqueryType)) {
					aggregateDS.baseTableName = cvc.subqueryConstraintsMap.get(subqueryType).SQTableName.keySet()
							.iterator().next();
					agg_table = cvc.subqueryConstraintsMap.get(subqueryType).SQTableName.keySet().iterator().next();
					numberOfTuples = cvc.getNoOfTuples()
							.get(cvc.subqueryConstraintsMap.get(subqueryType).SQTableName.keySet().iterator().next());
					attrNamesBQArrayList = cvc.subqueryConstraintsMap.get(subqueryType).SQColumns.get(agg_table);
					Table baseTable = cvc.getTableMap().getSQTableByName(agg_table);
					for (i = 0; i < groupByNodeDS.groupByColumnsFromRefTables.size(); i++) {
						for (j = 0; j < attrNamesBQArrayList.size(); j++) {

							if (attrNamesBQArrayList.get(j).toString()
									.contains(groupByNodeDS.groupByColumnsFromRefTables.get(i).getColumnName())
									&& attrNamesBQArrayList.get(j).toString().contains(
											groupByNodeDS.groupByColumnsFromRefTables.get(i).getTableName())) {
								if (i > groupByNodeDS.groupByColumnsFromJSQ.size())
									groupByNodeDS.groupByColumnsFromJSQ.add(
											baseTable.getColumn(attrNamesBQArrayList.get(j).toString()));
								else
									groupByNodeDS.groupByColumnsFromJSQ.add(i,
											baseTable.getColumn(attrNamesBQArrayList.get(j).toString()));
								break;
							}
						}

					}
					int addIndex = 0;
					for (i = 0; i < projectedNodes.size(); i++) {
						for (j = 0; j < attrNamesBQArrayList.size(); j++) {
							// FIX ME CHAITRA : one column is a substring of the other, this logic does not
							// work.
							if (attrNamesBQArrayList.get(j).toString()
									.contains(projectedNodes.get(i).getColumn().getColumnName())
									&& attrNamesBQArrayList.get(j).toString()
											.contains(projectedNodes.get(i).getColumn().getTableName())) {
								projectedNodeDs.aggregateColumnsFromJSQ.add(addIndex,
										baseTable.getColumn(attrNamesBQArrayList.get(j).toString()));
								addIndex++;
								break;
							}
						}

					}
				}
			}

			Vector<String> attrNamesBQ = new Vector<String>();
			Vector<Sort> attrTypesBQ = new Vector<Sort>();

			// creating context for base_table_name

			Table sqi = cvc.getTableMap().getSQTableByName(aggregateDS.subqueryTableName);
			boolean isExits = cvc.getTableMap().getSQTableByName(agg_table).getIsExist();

			sqi.setIsExist(isExits);

			// String arrNameBQ = "O_" + agg_table; // comment
			aggregateDS.arrayNameOfBQInCtx = "O_" + agg_table;
			if (isJoin) {
				// attrNamesBQ = new String[attrNamesBQArrayList.size()];
				// attrTypesBQ = new Sort[attrNamesBQArrayList.size()];
				for (int k = 0; k < attrNamesBQArrayList.size(); k++) {
					// Column column = cvc.getResultsetColumns().get(k);

					if (subqueryType.equalsIgnoreCase(subqueryType)
							&& cvc.subqueryConstraintsMap.containsKey(subqueryType)) {
						// arrNameBQ = "O_"
						// +
						// cvc.subqueryConstraintsMap.get(subqueryType).SQTableName.keySet().iterator().next();
						// // comment
						aggregateDS.arrayNameOfBQInCtx = "O_"
								+ cvc.subqueryConstraintsMap.get(subqueryType).SQTableName.keySet().iterator().next();
						aggregateDS.attrNamesBQ.add("" + attrNamesBQArrayList.get(k));
						aggregateDS.attrTypesBQ.add(getColumnSort(
								cvc.subqueryConstraintsMap.get(subqueryType).SQColumnsDataTypes.get(agg_table).get(k)));

					}

				}
			}

			// putting base table in context
			// Expr aexBQ = putTableInCtx(cvc, attrNamesBQ, attrTypesBQ, agg_table); //
			// comment
			Expr aexBQ = putTableInCtx(cvc, aggregateDS.attrNamesBQ,
					aggregateDS.attrTypesBQ, aggregateDS.baseTableName); // uncomment

			// end putting base table in context

			cvc.getNoOfTuples().put(aggregateDS.subqueryTableName, numberOfTuples);
			cvc.putNoOfOutputTuples(aggregateDS.subqueryTableName, numberOfTuples);

			// returned by toString()
			BoolExpr dummyAssert = ctx.mkDistinct(aex);

			dummySol.add(dummyAssert);

			String[] constraints = dummySol.toString().split("\n");

			String tempStr = "";

			Vector<String> includedStatements = new Vector<String>();

			for (String statement : constraints) {
				if (statement.contains("_TupleType ") || statement.contains("declare-fun O_")) {
					includedStatements.add(statement);
				}
				if (statement.contains("(assert")) {
					break;
				}
			}
			tempStr += String.join("\n\n", includedStatements);

			// Tuple type declaration constraints of Subquery table

			// ***************************************************************************************************
			// primary key constraints for SQ table using COUNT

			Expr cntOfSQColumnSQi1 = ConstraintGenerator.genSelectTest2(cvc, aggregateDS.subqueryTableName,
					aggregateDS.attrColumnsOfSQ.indexOf(aggregateDS.countColOfSQ.getColumnName()), "i1");
			Expr cntOfSQColumnSQj1 = ConstraintGenerator.genSelectTest2(cvc, aggregateDS.subqueryTableName,
					aggregateDS.attrColumnsOfSQ.indexOf(aggregateDS.countColOfSQ.getColumnName()), "j1");

			// ***************************************************************************************************

			// }
			String primaryKeyConstraintsOfSQ = getPrimaryKeyConstraintsForGSQTable(cvc, aggregateDS, indexType,
					numberOfTuples);

			// Aggregate functions

			Expr[] arrForIndexI = new Expr[] { ctx.mkIntConst("i") };

			int cntColumnBQIndex = aggregateDS.attrNamesOfBQ.size() - 1;
			Expr[] arrForIntIndex = new Expr[numberOfTuples + 1];
			// Boolean ifSumPresent = false;
			// Boolean ifCountPresent = false;
			int p;
			for (p = 0; p < numberOfTuples; p++) {
				arrForIntIndex[p + 1] = (IntExpr) ctx.mkInt(p + 1);
			}
			arrForIntIndex[0] = (IntExpr) ctx.mkInt(0);

			if (Configuration.isEnumInt.equalsIgnoreCase("true")) {
				EnumSort currentSort = (EnumSort) ConstraintGenerator.ctxSorts.get(cvc.enumArrayIndex);
				arrForIndexI = new Expr[] { ctx.mkConst("i", currentSort) };
				arrForIntIndex[0] = ctx.mkConst(cvc.enumIndexVar + 0, currentSort);
				for (p = 0; p < numberOfTuples; p++) {
					arrForIntIndex[p] = ctx.mkConst(cvc.enumIndexVar + (p + 1), currentSort);
				}
			}
			if (isJoin) {
				cntColumnBQIndex = attrNamesBQArrayList.size() - 1;
				// selectCntBQ = smtMap(arrNameBQ, "i1", p, cntColumnBQIndex);

			}

			HashMap<String, Object> aggCalls = generateAggregateConstraints(cvc, qbt, aggregateDS, projectedNodeDs,
					groupByNodeDS, arrForIndexI, numberOfTuples, cntColumnBQIndex);

			Vector<Expr> assertAggValDef = (Vector<Expr>) aggCalls.get("assertAggValDef");
			Vector<Expr> assertAggValCall = (Vector<Expr>) aggCalls.get("assertAggValCall");
			Vector<String> functionName = (Vector<String>) aggCalls.get("functionName");
			Vector<FuncDecl> DeclAssertAggVal = (Vector<FuncDecl>) aggCalls.get("DeclAssertAggVal"); // Function
																										// declaration
																										// for asserting
																										// agg val
			Vector<String> DefineAssertAggVal = (Vector<String>) aggCalls.get("DefineAssertAggVal"); // Function
																										// defination
																										// for asserting
																										// agg val fun

			Expr selectCntBQ;
			selectCntBQ = genSelectTest2(cvc, aggregateDS.arrayNameOfBQInCtx, cntColumnBQIndex, "i1");
			Expr checkIfBQTupleIsValid = ctx.mkGt((ArithExpr) selectCntBQ, ctx.mkInt(0));

			// Function 2 SQ Forward function
			EnumSort currentSort = (EnumSort) ConstraintGenerator.ctxSorts.get(cvc.enumArrayIndex);

			aggregateDS.attrNamesOfBQ = attrNamesBQArrayList;
			HashMap<String, Object> forwardPassData = generateForwardPassConstraints(cvc, qbt, aggregateDS,
					groupByNodeDS, projectedNodeDs, cntColumnBQIndex,
					numberOfTuples, checkIfBQTupleIsValid, currentSort, indexType, 1);

			FuncDecl sqTableIForward = (FuncDecl) forwardPassData.get("sqTableIForward");
			String DefinesqTableIForward = (String) forwardPassData.get("DefinesqTableIForward");
			Expr exitsExpr1 = (Expr) forwardPassData.get("exitsExpr1");

			// Function 3 SQ Backward function

			HashMap<String, Object> backwardPassData = generateBackwardPassConstraints(cvc, qbt, aggregateDS,
					groupByNodeDS, projectedNodeDs, cntColumnBQIndex,
					numberOfTuples, checkIfBQTupleIsValid, currentSort, indexType);

			FuncDecl sqTableIBackward = (FuncDecl) backwardPassData.get("sqTableIBackward");
			String DefinesqTableIBackward = (String) backwardPassData.get("DefinesqTableIBackward");
			Expr impliesExprBackward = (Expr) backwardPassData.get("impliesExprBackward");
			Expr[] eqExprBackward = (Expr[]) backwardPassData.get("eqExprBackward");
			Expr[] colValueBQForBackward = (Expr[]) backwardPassData.get("colValueBQForBackward");
			Expr[] colValueSQForBackward = (Expr[]) backwardPassData.get("colValueSQForBackward");

			// // end of backward function

			ConstraintsStr += "\n\n" + tempStr;
			ConstraintsStr += primaryKeyConstraintsOfSQ;
			ConstraintsStr += "\n\n" + DefinesqTableIForward.toString() + "\n\n " + "(and \n\t (=> \n\t\t"
					+ checkIfBQTupleIsValid + "\n\n\t" + exitsExpr1.toString() + ")))" + "\n\n";
			ConstraintsStr += "\n\n" + DefinesqTableIBackward.toString() + "\n\n " + impliesExprBackward.toString()
					+ ")" + "\n\n";

			BoolExpr[] assertSqTableIForward1 = new BoolExpr[numberOfTuples];
			Vector<BoolExpr> assertAggValFunsCall = new Vector<BoolExpr>();

			for (int s = 0; s < numberOfTuples; s++) {
				assertSqTableIForward1[s] = (BoolExpr) sqTableIForward.apply(arrForIntIndex[s + 1]);
			}

			BoolExpr andAssertsForward = ctx.mkAnd(assertSqTableIForward1);

			Expr assertSqTableIBackward1;

			if (Configuration.isEnumInt.equalsIgnoreCase("true")) {
				assertSqTableIBackward1 = sqTableIBackward.apply(ctx.mkConst("i1", currentSort));
			} else
				assertSqTableIBackward1 = sqTableIBackward.apply(ctx.mkIntConst("i1"));

			// function asserts for number of tuples
			Expr backwardExprAnd = ctx.mkAnd((BoolExpr) assertSqTableIBackward1);
			i = 0;

			for (i = 0; i < assertAggValDef.size(); i++) {
				if (assertAggValDef.get(i) != null) {
					ConstraintsStr += "\n\n" + DefineAssertAggVal.get(i) + "\n\n " + assertAggValDef.get(i).toString()
							+ ")" + "\n\n";
					if (Configuration.isEnumInt.equalsIgnoreCase("true")) {
						assertAggValFunsCall
								.add((BoolExpr) DeclAssertAggVal.get(i).apply(ctx.mkConst("i1", currentSort)));
					} else
						// assertSqTableIBackward1 = sqTableIBackward.apply(ctx.mkIntConst("i1"));
						assertAggValFunsCall.add((BoolExpr) DeclAssertAggVal.get(i).apply(ctx.mkIntConst("i1")));
				} else {
					assertAggValFunsCall.add(ctx.mkTrue());
					System.out.println(
							"************ Not supported for this Aggregate Function Name: " + functionName.get(i));
				}
			}

			assertAggValFunsCall.add((BoolExpr) assertSqTableIBackward1);

			Object[] temp = assertAggValFunsCall.toArray();
			Expr[] array = Arrays.copyOf(
					temp, temp.length, Expr[].class);

			BoolExpr andAssertBackwardAndAggValFunsCall = ctx.mkAnd(array); // work from here
			Expr[] iColArray = new IntExpr[] { ctx.mkIntConst("i1") };

			if (Configuration.isEnumInt.equalsIgnoreCase("true")) {
				iColArray = new Expr[] { ctx.mkConst("i1", currentSort) };
			}

			Expr backwardAsssertsFinal = ctx.mkForall((Expr[]) iColArray, (Expr) andAssertBackwardAndAggValFunsCall, 1,
					null, null, null, null);

			ConstraintsStr += "\n\n (assert " + andAssertsForward.toString() + ")" + "\n\n";
			ConstraintsStr += "\n\n (assert " + backwardAsssertsFinal.toString() + ")" + "\n\n";

			// Constraints for constrained aggregation - test code for having - start



			// write correlation update here - parismita
			// Looking at global correlation map and process correlation if is to be
			// processed at current level
			Table sqTable = cvc.getTableMap().getSQTableByName(aggregateDS.subqueryTableName);
			Set<Node> corrConds = cvc.correlationHashMap.keySet();
			Vector<Node> corrC = new Vector<Node>(corrConds);
			for (Node globalCorrConds : corrC) {
				// correlationStructure cs = cvc.correlationHashMap.get(globalCorrConds);
				if ((globalCorrConds.getLeft().getLevel() == qbt.getLevel() - 1)
						|| (globalCorrConds.getRight().getLevel() == qbt.getLevel() - 1)) {
					GenerateJoinPredicateConstraints.updateTableAndColumnOfCorrelatedConditionWithAboveLevel(cvc, qbt,
							globalCorrConds, sqTable, qbt.getLevel(), true);
					globalCorrConds.setExpired(true);
				} else if (cvc.correlationHashMap.get(globalCorrConds).getQueryType().equalsIgnoreCase("FROM")) {
					int leftlevel = globalCorrConds.getLeft().getLevel();
					int rghtlevel = globalCorrConds.getRight().getLevel();
					int nodelevel = globalCorrConds.getLevel();
					int processlevel = cvc.correlationHashMap.get(globalCorrConds).getProcessLevel();
					if (processlevel < qbt.getLevel()) {
						GenerateJoinPredicateConstraints.updateTableAndColumnOfCorrelatedConditionWithAboveLevel(cvc,
								qbt,
								globalCorrConds, sqTable, qbt.getLevel(), true);
						globalCorrConds.setExpired(true);
					}
				}
			}
			String constr = "";
			if (qbt.isConstrainedAggregation() && Configuration.getProperty("QueryEquivalenceCheck").equalsIgnoreCase("true") 
					&& ((cvc.getCurrentMutant() == null)
							|| cvc.getCurrentMutant() != null && cvc.getCurrentMutant().getMutationTypeNumber() != 7
									&& cvc.getCurrentMutant().getMutationTypeNumber() != 8)){
				String hsqConstraints = generateConstraintsForHSQTable(cvc, qbt, aggregateDS, numberOfTuples, numberOfTuples);
    			constr += hsqConstraints;	
				qbt.getBaseRelations().clear();
				qbt.getBaseSQRelations().clear();
				qbt.getBaseSQRelations().add("GSQ" + qbt.getLevel());
				qbt.baseSQ="HSQ"+qbt.getLevel();
				
				replaceGSQWithHSQ(cvc, cvc.getOuterBlock(), qbt.getLevel());
				return ConstraintsStr+constr;

				}
			if (qbt.isConstrainedAggregation()
					&& ((cvc.getCurrentMutant() == null)
							|| cvc.getCurrentMutant() != null && cvc.getCurrentMutant().getMutationTypeNumber() != 7
									&& cvc.getCurrentMutant().getMutationTypeNumber() != 8)) {
				ArrayList<Node> aggConstraints = qbt.getAggConstraints();
				String tempstragg = "";

				for (i = 1; i <= numberOfTuples; i++) {
					String tep = "";
					Expr cntOfSQColumnSQint = ConstraintGenerator.genSelectTest(cvc, aggregateDS.subqueryTableName,
							aggregateDS.attrColumnsOfSQ.indexOf(aggregateDS.countColOfSQ.getColumnName()), i);

					for (j = 0; j < aggConstraints.size(); j++) {
						
						tep += getAggregateConstraintsWithCount(cvc, aggConstraints.get(j),
								aggregateDS.subqueryTableName,
								aggregateDS.attrColumnsOfSQ, aggregateDS.attrTypesOfSQ,
								aggregateDS.columnToIndexMapInSQ, i);
					}
					tempstragg += "(and " + ctx.mkGt(cntOfSQColumnSQint, ctx.mkInt(0)).toString() + "\n\t" + tep + " )";
				}
				constr += "(assert(or" + tempstragg + "))";
				// constr = "(assert (exists ((i1 " + indexType + "))"
				// // \n\t(=> "

				// + "(and " + ctx.mkGt(cntOfSQColumnSQi1, ctx.mkInt(0)).toString() + "\n\t" +
				// constr + " )))";
			}

			// aggregate Constraints end

			// extra group by attribute killing constraints - start

			Expr mutantConstrExpr = ctx.mkTrue();
			if (cvc.getCurrentMutant() != null && (cvc.getCurrentMutant().getMutationTypeNumber() == 7
					|| cvc.getCurrentMutant().getMutationTypeNumber() == 8)) {

				Expr cntValidSQ = getConstraintsForValidCountUsingTable(
						cvc.getTableMap().getSQTableByName(aggregateDS.subqueryTableName),
						aggregateDS.subqueryTableName, 1, 0);
				int indSq = getIndexOfMutantColumnCount(aggregateDS.attrColumnsOfSQ, cvc.getCurrentMutant(), "COUNT",
						1);
				int indBq = getIndexOfMutantColumnCount(
						cvc.getTableMap().getSQTableByName(aggregateDS.baseTableName).getColumnIndexList(),
						cvc.getCurrentMutant(), "COUNT", 0);
				Expr countMutant = ctx.mkEq(smtMap(aggregateDS.arrayNameOfSQInCtx, "1", 1, indSq), ctx.mkInt(2));
				Expr backGroupByi, backGroupByj;

				for (i = 0; i < groupByNodeDS.noOfGroupByColumns; i++) {
					colValueSQForBackward[i] = smtMap(aggregateDS.arrayNameOfSQInCtx, "", 1, i);
					colValueBQForBackward[i] = smtMap(aggregateDS.arrayNameOfBQInCtx, "i", -1,
							attrNamesBQArrayList.indexOf(groupByNodeDS.groupByColumnsFromJSQ.get(i).getColumnName()));
					if (groupByNodeDS.groupByNodes.get(i).getIsMutant())
						eqExprBackward[i] = (BoolExpr) ctx.mkTrue();
					else
						eqExprBackward[i] = (BoolExpr) ctx.mkEq(colValueSQForBackward[i], colValueBQForBackward[i]);
				}

				ArrayList<Node> aggConstraints = qbt.getAggConstraints();

				Expr[] constAggExpr = new Expr[aggConstraints.size()];
				Expr isNotNull;
				for (i = 0; i < aggConstraints.size(); i++) {
					Column c;
					AggregateFunction agg;
					Node n = aggConstraints.get(i);
					if (n.getLeft() != null) {
						c = n.getLeft().getColumn();
						agg = n.getLeft().getAgg();
					} else {
						c = n.getRight().getColumn();
						agg = n.getRight().getAgg();
					}
					int index = projectedNodeDs.aggregateColumnsFromRefTables.indexOf(c);
					Column constrColumn = projectedNodeDs.aggregateColumnsFromJSQ.get(index);
					index = cvc.getTableMap().getSQTableByName(constrColumn.getTableName())
							.getColumnIndex(constrColumn.getColumnName());

					Expr constrAggExpri, constrAggExprj;
					if (agg.getFunc().equalsIgnoreCase(n.getAgg().getAggCOUNT())) {
						constrAggExpri = ctx.mkTrue();
						constrAggExprj = ctx.mkTrue();
					} else {
						constrAggExpri = getConstraintAggregationForMutants(cvc, constrColumn, n, index, "i");
						constrAggExprj = getConstraintAggregationForMutants(cvc, constrColumn, n, index, "j");

					}

					Expr isNotNulli = ctx.mkNot(
							ctxFuncDecls
									.get("ISNULL_" + c.getColumnName())
									.apply(ConstraintGenerator.genSelectTest2(cvc, constrColumn.getTableName(), index,
											"i")));
					Expr isNotNullj = ctx.mkNot(
							ctxFuncDecls
									.get("ISNULL_" + c.getColumnName())
									.apply(ConstraintGenerator.genSelectTest2(cvc, constrColumn.getTableName(), index,
											"j")));
					constAggExpr[i] = ctx.mkAnd(constrAggExpri, constrAggExprj, isNotNulli, isNotNullj);
				}

				Expr finalConstAggExpr = ctx.mkAnd(constAggExpr);
				Expr andExpr4 = ctx.mkAnd(eqExprBackward);
				backGroupByi = ctx.mkAnd((BoolExpr) andExpr4,
						ctx.mkGt(smtMap(aggregateDS.arrayNameOfBQInCtx, "i", -1, cntColumnBQIndex), ctx.mkInt(0)));

				for (i = 0; i < groupByNodeDS.noOfGroupByColumns; i++) {

					colValueSQForBackward[i] = smtMap(aggregateDS.arrayNameOfSQInCtx, "", 1, i);
					colValueBQForBackward[i] = smtMap(aggregateDS.arrayNameOfBQInCtx, "j", -1,
							attrNamesBQArrayList.indexOf(groupByNodeDS.groupByColumnsFromJSQ.get(i).getColumnName()));
					if (groupByNodeDS.groupByNodes.get(i).getIsMutant())
						eqExprBackward[i] = (BoolExpr) ctx.mkTrue();
					else
						eqExprBackward[i] = (BoolExpr) ctx.mkEq(colValueSQForBackward[i], colValueBQForBackward[i]);
				}
				andExpr4 = ctx.mkAnd(eqExprBackward);
				backGroupByj = ctx.mkAnd((BoolExpr) andExpr4,
						ctx.mkGt(smtMap(aggregateDS.arrayNameOfBQInCtx, "j", -1, cntColumnBQIndex), ctx.mkInt(0)));

				// }

				Expr mutantEq = ctx
						.mkNot(ctx.mkEq(smtMap(aggregateDS.arrayNameOfBQInCtx, "i", -1, indBq),
								smtMap(aggregateDS.arrayNameOfBQInCtx, "j", -1, indBq)));

				Expr[] arrForIndex = new Expr[] { ctx.mkIntConst("i"), ctx.mkIntConst("j") };

				mutantConstrExpr = ctx.mkAnd(cntValidSQ, countMutant, ctx.mkExists(arrForIndex,
						ctx.mkAnd(backGroupByi, backGroupByj, mutantEq), 1, null, null, null, null));
				mutantConstrExpr = ctx.mkAnd(cntValidSQ, ctx.mkExists(arrForIndex,
						ctx.mkAnd(backGroupByi, backGroupByj, mutantEq, finalConstAggExpr), 1, null, null, null, null));
				ctx.mkOr(ctx.mkTrue());

			}

			// For Agg mutant

			boolean skipMut2 = false;
			if (cvc.getCurrentMutant() != null && cvc.getCurrentMutant().getMutationTypeNumber() == 2) {
				Column mutColumn = ((Node) cvc.getCurrentMutant().getMutationLoc()).getColumn();
				if (!mutColumn.getCvcDatatype().equalsIgnoreCase("int")
						&& !mutColumn.getCvcDatatype().equalsIgnoreCase("real"))
					skipMut2 = true;
			}
			if (cvc.getCurrentMutant() != null && cvc.getCurrentMutant().getMutationTypeNumber() == 2) {
				Expr cntValidSQ = getConstraintsForValidCountUsingTable(
						cvc.getTableMap().getSQTableByName(aggregateDS.subqueryTableName),
						aggregateDS.subqueryTableName, 1, 0);

				Expr[] arrForIndex = new Expr[] { ctx.mkIntConst("i"), ctx.mkIntConst("j"), ctx.mkIntConst("k") };

				String aggFun = "COUNT";
				int indSq = getIndexOfMutantColumnCount(aggregateDS.attrColumnsOfSQ, cvc.getCurrentMutant(), aggFun, 1);
				// int indBq = getIndexOfMutantColumnCount(
				// cvc.getTableMap().getSQTableByName(aggregateDS.baseTableName).getColumnIndexList(),
				// cvc.getCurrentMutant(), 0);

				Expr countMutant = ctx.mkEq(smtMap(aggregateDS.arrayNameOfSQInCtx, "1", 1, indSq), ctx.mkInt(3));
				Expr backGroupByi, backGroupByj, backGroupByk;

				for (i = 0; i < groupByNodeDS.noOfGroupByColumns; i++) {

					colValueSQForBackward[i] = smtMap(aggregateDS.arrayNameOfSQInCtx, "", 1, i);
					colValueBQForBackward[i] = smtMap(aggregateDS.arrayNameOfBQInCtx, "i", -1,
							attrNamesBQArrayList.indexOf(groupByNodeDS.groupByColumnsFromJSQ.get(i).getColumnName()));
					if (groupByNodeDS.groupByNodes.get(i).getIsMutant())
						eqExprBackward[i] = (BoolExpr) ctx.mkTrue();
					else
						eqExprBackward[i] = (BoolExpr) ctx.mkEq(colValueSQForBackward[i], colValueBQForBackward[i]);
				}
				Expr andExpr4 = ctx.mkAnd(eqExprBackward);
				backGroupByi = ctx.mkAnd((BoolExpr) andExpr4,
						ctx.mkGt(smtMap(aggregateDS.arrayNameOfBQInCtx, "i", -1, cntColumnBQIndex), ctx.mkInt(0)));

				for (i = 0; i < groupByNodeDS.noOfGroupByColumns; i++) {

					colValueSQForBackward[i] = smtMap(aggregateDS.arrayNameOfSQInCtx, "", 1, i);
					colValueBQForBackward[i] = smtMap(aggregateDS.arrayNameOfBQInCtx, "j", -1,
							attrNamesBQArrayList.indexOf(groupByNodeDS.groupByColumnsFromJSQ.get(i).getColumnName()));
					if (groupByNodeDS.groupByNodes.get(i).getIsMutant())
						eqExprBackward[i] = (BoolExpr) ctx.mkTrue();
					else
						eqExprBackward[i] = (BoolExpr) ctx.mkEq(colValueSQForBackward[i], colValueBQForBackward[i]);
				}
				andExpr4 = ctx.mkAnd(eqExprBackward);
				backGroupByj = ctx.mkAnd((BoolExpr) andExpr4,
						ctx.mkGt(smtMap(aggregateDS.arrayNameOfBQInCtx, "j", -1, cntColumnBQIndex), ctx.mkInt(0)));

				for (i = 0; i < groupByNodeDS.noOfGroupByColumns; i++) {

					colValueSQForBackward[i] = smtMap(aggregateDS.arrayNameOfSQInCtx, "", 1, i);
					colValueBQForBackward[i] = smtMap(aggregateDS.arrayNameOfBQInCtx, "k", -1,
							attrNamesBQArrayList.indexOf(groupByNodeDS.groupByColumnsFromJSQ.get(i).getColumnName()));
					if (groupByNodeDS.groupByNodes.get(i).getIsMutant())
						eqExprBackward[i] = (BoolExpr) ctx.mkTrue();
					else
						eqExprBackward[i] = (BoolExpr) ctx.mkEq(colValueSQForBackward[i], colValueBQForBackward[i]);
				}
				andExpr4 = ctx.mkAnd(eqExprBackward);
				backGroupByk = ctx.mkAnd((BoolExpr) andExpr4,
						ctx.mkGt(smtMap(aggregateDS.arrayNameOfBQInCtx, "k", -1, cntColumnBQIndex), ctx.mkInt(0)));

				Column mutColumn = ((Node) cvc.getCurrentMutant().getMutationLoc()).getColumn();
				int ind = projectedNodeDs.aggregateColumnsFromRefTables.indexOf(mutColumn);
				Column mutColumnBQ = projectedNodeDs.aggregateColumnsFromJSQ.get(ind);
				ind = aggregateDS.attrNamesOfBQ.indexOf(mutColumnBQ.getColumnName());

				Expr aggColi = genSelectTest2(cvc, mutColumnBQ.getTableName(), ind, "i");
				Expr aggColj = genSelectTest2(cvc, mutColumnBQ.getTableName(), ind, "j");
				Expr aggColk = genSelectTest2(cvc, mutColumnBQ.getTableName(), ind, "k");

				Expr indexNotEq1 = ctx.mkNot(ctx.mkEq(ctx.mkIntConst("i"), ctx.mkIntConst("j")));
				Expr indexNotEq2 = ctx.mkNot(ctx.mkEq(ctx.mkIntConst("j"), ctx.mkIntConst("k")));
				Expr indexNotEq3 = ctx.mkNot(ctx.mkEq(ctx.mkIntConst("k"), ctx.mkIntConst("i")));

				Expr isNotNulli, isNotNullj, isNotNullk;

				if (mutColumn.getCvcDatatype().equalsIgnoreCase("int")
						|| mutColumn.getCvcDatatype().equalsIgnoreCase("real")) {
					isNotNulli = ctx.mkNot(
							ctxFuncDecls
									.get("CHECKALL_NULL"
											+ (mutColumn.getCvcDatatype().equalsIgnoreCase("Int") ? "Int" : "Real"))
									.apply(ConstraintGenerator.genSelectTest2(cvc, mutColumnBQ.getTableName(), ind,
											"i")));

					isNotNullj = ctx.mkNot(
							ctxFuncDecls
									.get("CHECKALL_NULL"
											+ (mutColumn.getCvcDatatype().equalsIgnoreCase("Int") ? "Int" : "Real"))
									.apply(ConstraintGenerator.genSelectTest2(cvc, mutColumnBQ.getTableName(), ind,
											"j")));

					isNotNullk = ctx.mkNot(
							ctxFuncDecls
									.get("CHECKALL_NULL"
											+ (mutColumn.getCvcDatatype().equalsIgnoreCase("Int") ? "Int" : "Real"))
									.apply(ConstraintGenerator.genSelectTest2(cvc, mutColumnBQ.getTableName(), ind,
											"k")));
				} else {
					isNotNulli = ctx.mkNot(
							ctxFuncDecls
									.get("ISNULL_"
											+ (mutColumn.getCvcDatatype()))
									.apply(ConstraintGenerator.genSelectTest2(cvc, mutColumnBQ.getTableName(), ind,
											"i")));
					isNotNullj = ctx.mkNot(
							ctxFuncDecls
									.get("ISNULL_"
											+ mutColumn.getCvcDatatype())
									.apply(ConstraintGenerator.genSelectTest2(cvc, mutColumnBQ.getTableName(), ind,
											"j")));
					isNotNullk = ctx.mkNot(
							ctxFuncDecls
									.get("ISNULL_"
											+ (mutColumn.getCvcDatatype()))
									.apply(ConstraintGenerator.genSelectTest2(cvc, mutColumnBQ.getTableName(), ind,
											"k")));
				}
				Expr mutantEq;
				if (!skipMut2)
					mutantEq = ctx
							.mkAnd(ctx.mkEq(aggColi, aggColj), ctx.mkGt(aggColj, ctx.mkAdd(aggColk, ctx.mkInt(1))));
				else
					mutantEq = ctx
							.mkAnd(ctx.mkEq(aggColi, aggColj), ctx.mkNot(ctx.mkEq(aggColk, aggColj)));

				mutantConstrExpr = ctx.mkAnd(cntValidSQ, countMutant, ctx.mkExists(arrForIndex,
						ctx.mkAnd(backGroupByi, backGroupByj, backGroupByk, mutantEq, indexNotEq1, indexNotEq2,
								indexNotEq3, isNotNulli, isNotNullj, isNotNullk),
						1, null, null, null, null));
			}

			// COUNT COLUMN REPLACEMENT mutation-specific constraints (type 29)
			// COUNT(col1) -> COUNT(col2) can produce different results only when one
			// column is NULL and the other is NOT NULL for the same tuple.
			if (cvc.getCurrentMutant() != null && cvc.getCurrentMutant().getMutationTypeNumber() == 29) {
				// Retrieve original and replacement columns
				Node countOrigNode = (Node) cvc.getCurrentMutant().getMutationLoc();
				Column origCol = countOrigNode.getAgg().getAggExp().getColumn();
				Column replCol = (Column) cvc.getCurrentMutant().getMutationNode();

				boolean origNullable = origCol.isNullable();
				boolean replNullable = replCol.isNullable();

				// Case 4: both NOT NULL -> mutation is semantically equivalent, no constraint
				if (!origNullable && !replNullable) {
					// mutantConstrExpr stays ctx.mkTrue() - no extra constraint needed
				} else {
					// Find the base table and locate each column's index in the BQ
					String baseTableName = aggregateDS.baseTableName;
					Table baseTable = cvc.getTableMap().getSQTableByName(baseTableName);
					ArrayList<String> bqColList = aggregateDS.attrNamesOfBQ;

					// Locate column indices in the BQ attribute list
					int origColIdx = -1;
					int replColIdx = -1;
					for (int bi = 0; bi < bqColList.size(); bi++) {
						String attrName = bqColList.get(bi);
						if (attrName != null && attrName.contains(origCol.getColumnName())
								&& attrName.contains(origCol.getTableName())) {
							origColIdx = bi;
						}
						if (attrName != null && attrName.contains(replCol.getColumnName())
								&& attrName.contains(replCol.getTableName())) {
							replColIdx = bi;
						}
					}

					if (origColIdx >= 0 && replColIdx >= 0) {
						// assert EXISTS (i in BQ): BQ[i].xdata_cnt > 0 AND null pattern
						Expr[] arrForIndexSingle = new Expr[] { ctx.mkIntConst("i") };

						// BQ tuple is valid (not a phantom / deleted row)
						Expr bqValid = ctx.mkGt(
								(ArithExpr) smtMap(aggregateDS.arrayNameOfBQInCtx, "i", -1, cntColumnBQIndex),
								ctx.mkInt(0));

						// Get Z3 expressions for each column value at BQ[i]
						Expr origColVal = smtMap(aggregateDS.arrayNameOfBQInCtx, "i", -1, origColIdx);
						Expr replColVal = smtMap(aggregateDS.arrayNameOfBQInCtx, "i", -1, replColIdx);

						// Build IS-NULL expressions for each column
						// Use CHECKALL_NULL for numeric types, ISNULL_ for other types
						String origType = origCol.getCvcDatatype();
						String replType = replCol.getCvcDatatype();

						FuncDecl origIsNullFn = null;
						if (origNullable) {
							if (origType != null
									&& (origType.equalsIgnoreCase("Int") || origType.equalsIgnoreCase("Real"))) {
								origIsNullFn = ctxFuncDecls
										.get("CHECKALL_NULL" + (origType.equalsIgnoreCase("Int") ? "Int" : "Real"));
							} else if (origType != null) {
								origIsNullFn = ctxFuncDecls.get("ISNULL_" + origType);
								if (origIsNullFn == null)
									origIsNullFn = ctxFuncDecls.get("ISNULL_" + origCol.getColumnName());
							}
						}

						FuncDecl replIsNullFn = null;
						if (replNullable) {
							if (replType != null
									&& (replType.equalsIgnoreCase("Int") || replType.equalsIgnoreCase("Real"))) {
								replIsNullFn = ctxFuncDecls
										.get("CHECKALL_NULL" + (replType.equalsIgnoreCase("Int") ? "Int" : "Real"));
							} else if (replType != null) {
								replIsNullFn = ctxFuncDecls.get("ISNULL_" + replType);
								if (replIsNullFn == null)
									replIsNullFn = ctxFuncDecls.get("ISNULL_" + replCol.getColumnName());
							}
						}

						BoolExpr nullPatternExpr = null;

						if (!origNullable && replNullable && replIsNullFn != null) {
							// Case 1: origCol NOT NULL, replCol nullable
							// Need a tuple where replCol IS NULL (origCol is always non-null)
							// -> COUNT(origCol) will count it, COUNT(replCol) will not
							BoolExpr replIsNull = (BoolExpr) replIsNullFn.apply(replColVal);
							nullPatternExpr = replIsNull;
						} else if (origNullable && !replNullable && origIsNullFn != null) {
							// Case 2: origCol nullable, replCol NOT NULL
							// Need a tuple where origCol IS NULL (replCol is always non-null)
							// -> COUNT(replCol) will count it, COUNT(origCol) will not
							BoolExpr origIsNull = (BoolExpr) origIsNullFn.apply(origColVal);
							nullPatternExpr = origIsNull;
						} else if (origNullable && replNullable && origIsNullFn != null && replIsNullFn != null) {
							// Case 3: both nullable
							// Need a tuple where exactly one is NULL
							BoolExpr origIsNull = (BoolExpr) origIsNullFn.apply(origColVal);
							BoolExpr replIsNull = (BoolExpr) replIsNullFn.apply(replColVal);
							// (origIsNull AND NOT replIsNull) OR (NOT origIsNull AND replIsNull)
							nullPatternExpr = ctx.mkOr(
									ctx.mkAnd(origIsNull, ctx.mkNot(replIsNull)),
									ctx.mkAnd(ctx.mkNot(origIsNull), replIsNull));
						}

						if (nullPatternExpr != null) {
							Expr existsExpr = ctx.mkExists(arrForIndexSingle,
									ctx.mkAnd(bqValid, nullPatternExpr),
									1, null, null, null, null);
							mutantConstrExpr = existsExpr;
						}
						// If functions are missing (e.g. non-nullable types resolved to null fn),
						// mutantConstrExpr stays mkTrue() - no spurious constraints.
					}
				}
			}

			constr += "\n\t(assert\n" + mutantConstrExpr.toString() + "\n)\n";

			ConstraintsStr += constr;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return ConstraintsStr;

	}

	private static Expr getConstraintAggregationForMutants(GenerateCVC1 cvc, Column constrColumn, Node n, int index,
			String tupleNo) {
		Expr SQColumnSQi1;
		if (n.getLeft() == null && n.getRight() == null) {
			return ctx.mkTrue();
		} else if (n.getRight() != null && n.getLeft().getType().equalsIgnoreCase("VALUE")) {
			// generate constraints
			// System.out.println(n.getRight().getAgg().getAggExp().getAggFuncFromNode().getFunc());
			String AggColInSQTable = n.getRight().getAgg().getFunc()
					+ n.getLeft().getAgg().getAggExp().getColumn().getColumnName();
			SQColumnSQi1 = ConstraintGenerator.genSelectTest2(cvc, constrColumn.getTableName(), index, tupleNo);

			return getComparisionConstraintsForOperator(n.getOperator(), ctx.mkInt(n.getRight().getStrConst()),
					SQColumnSQi1);

		}

		else if (n.getLeft() != null && n.getRight().getType().equalsIgnoreCase("VALUE")) {
			// generate constraints
			String AggColInSQTable = n.getLeft().getAgg().getFunc()
					+ n.getLeft().getAgg().getAggExp().getColumn().getColumnName();
			String baseTableOfAgg = n.getLeft().getAgg().getAggExp().getColumn().getTableName();
			SQColumnSQi1 = ConstraintGenerator.genSelectTest2(cvc, constrColumn.getTableName(), index, tupleNo);

			return getComparisionConstraintsForOperator(n.getOperator(), SQColumnSQi1,
					ctx.mkInt(n.getRight().getStrConst()));

		}
		return ctx.mkTrue();

	}

	private static HashMap<String, Object> generateBackwardPassConstraints(GenerateCVC1 cvc, QueryBlockDetails qbt,
			AggregateDataStructure aggregateDS, GroupByNodesData groupByNodeDS, ProjectedNodesData projectedNodeDs,
			int cntColumnBQIndex, int numberOfTuples, Expr checkIfBQTupleIsValid, EnumSort currentSort,
			String indexType) {
		HashMap<String, Object> returnData = new HashMap<String, Object>();
		String functionName3 = "SQTABLE_" + qbt.getLevel() + "_BACKWARD";

		FuncDecl sqTableIBackward = ctx.mkFuncDecl(functionName3, ctx.getIntSort(), ctx.mkBoolSort());
		if (Configuration.isEnumInt.equalsIgnoreCase("true")) {
			sqTableIBackward = ctx.mkFuncDecl(functionName3, currentSort, ctx.mkBoolSort());
		}
		ctxFuncDecls.put(functionName3, sqTableIBackward);
		String DefinesqTableIBackward = "(define-fun " + functionName3 + "((k1 " + indexType + "))Bool";

		Expr compareExpr3 = ctx.mkLt((ArithExpr) (IntExpr) ctx.mkInt(0), (ArithExpr) ctx.mkIntConst("k1"));
		Expr compareExpr4 = ctx.mkLe((ArithExpr) ctx.mkIntConst("k1"),
				(ArithExpr) (IntExpr) ctx.mkInt(numberOfTuples));

		Expr andExpr3 = ctx.mkAnd((BoolExpr) compareExpr3, (BoolExpr) compareExpr4,
				ctx.mkEq((ArithExpr) smtMap(aggregateDS.arrayNameOfSQInCtx, "k1", -1,
						aggregateDS.attrColumnsOfSQ.size() - 1), ctx.mkInt(1)));
		andExpr3 = ctx
				.mkAnd(ctx.mkEq((ArithExpr) smtMap(aggregateDS.arrayNameOfSQInCtx, "k1", -1,
						aggregateDS.attrColumnsOfSQ.size() - 1), ctx.mkInt(1)));

		Expr[] colValueBQForBackward = new Expr[groupByNodeDS.noOfGroupByColumns];

		Expr[] colValueSQForBackward = new Expr[groupByNodeDS.noOfGroupByColumns];
		BoolExpr[] eqExprBackward = new BoolExpr[groupByNodeDS.noOfGroupByColumns];
		BoolExpr[] orBackward = new BoolExpr[numberOfTuples];
		BoolExpr[] cntColBQ = new BoolExpr[numberOfTuples];
		int i, j;
		for (j = 0; j < numberOfTuples; j++) {
			for (i = 0; i < groupByNodeDS.noOfGroupByColumns; i++) {
				colValueSQForBackward[i] = smtMap(aggregateDS.arrayNameOfSQInCtx, "k1", -1, i);
				colValueBQForBackward[i] = smtMap(aggregateDS.arrayNameOfBQInCtx, "", j + 1,
						aggregateDS.attrNamesOfBQ.indexOf(groupByNodeDS.groupByColumnsFromJSQ.get(i).getColumnName()));
				if (groupByNodeDS.groupByNodes.get(i).getIsMutant())
					eqExprBackward[i] = (BoolExpr) ctx.mkTrue();
				// eqExprBackward[i]=ctx.mkNot((BoolExpr) ctx.mkEq(colValueSQForBackward[i],
				// colValueBQForBackward[i]));
				else
					eqExprBackward[i] = (BoolExpr) ctx.mkEq(colValueSQForBackward[i], colValueBQForBackward[i]);
			}
			cntColBQ[j] = ctx.mkGt(smtMap(aggregateDS.arrayNameOfBQInCtx, "", j + 1, cntColumnBQIndex), ctx.mkInt(0));
			Expr andExpr4 = ctx.mkAnd(eqExprBackward);
			orBackward[j] = ctx.mkAnd((BoolExpr) andExpr4, cntColBQ[j]);
		}

		BoolExpr orExprBackward = ctx.mkOr(orBackward);
		// Expr exitsExpr2 = ctx.mkExists(arrForIndexL1, andExpr4, 1, null, null, null,
		// null);
		Expr impliesExprBackward = ctx.mkImplies((BoolExpr) andExpr3, orExprBackward);

		returnData.put("DefinesqTableIBackward", DefinesqTableIBackward);
		returnData.put("colValueSQForBackward", colValueSQForBackward);
		returnData.put("eqExprBackward", eqExprBackward);
		returnData.put("sqTableIBackward", sqTableIBackward);
		returnData.put("impliesExprBackward", impliesExprBackward);
		returnData.put("colValueBQForBackward", colValueBQForBackward);
		return returnData;
	}

	private static HashMap<String, Object> generateForwardPassConstraints(GenerateCVC1 cvc, QueryBlockDetails qbt,
			AggregateDataStructure aggregateDS, GroupByNodesData groupByNodeDS,
			ProjectedNodesData projectedNodeDs, int cntColumnBQIndex, int numberOfTuples,
			Expr checkIfBQTupleIsValid, EnumSort currentSort, String indexType, int countValue) {

		Boolean isExist = Configuration.getProperty("existsUnrollFlag").equalsIgnoreCase("true");
		// isExist = false;
		HashMap<String, Object> retunData = new HashMap<String, Object>();

		int i;
		String functionName2 = "SQTABLE_" + qbt.getLevel() + "_FORWARD";
		// for enum_int - Sunanda

		FuncDecl sqTableIForward = ctx.mkFuncDecl(functionName2, ctx.getIntSort(), ctx.mkBoolSort());

		if (Configuration.isEnumInt.equalsIgnoreCase("true")) {
			sqTableIForward = ctx.mkFuncDecl(functionName2, currentSort, ctx.mkBoolSort());
		}
		ctxFuncDecls.put(functionName2, sqTableIForward);

		String DefinesqTableIForward = "(define-fun " + functionName2 + "((i1 " + indexType + "))Bool";

		// selectCntBQ = smtMap(arrNameBQ, "i1", -1, cntColumnBQIndex);

		Expr[] arrForIndexj1 = new Expr[] { ctx.mkIntConst("j1") };
		Expr[] arrForIndexK1 = new Expr[] { ctx.mkIntConst("k1") };
		Expr[] arrForIndexL1 = new Expr[] { ctx.mkIntConst("l1") };

		if (Configuration.isEnumInt.equalsIgnoreCase("true")) {
			arrForIndexj1 = new Expr[] { ctx.mkConst("j1", currentSort) };
			arrForIndexK1 = new Expr[] { ctx.mkConst("k1", currentSort) };
			arrForIndexL1 = new Expr[] { ctx.mkConst("l1", currentSort) };
		}
		Expr compareExpr1 = ctx.mkLt((ArithExpr) (IntExpr) ctx.mkInt(0), (ArithExpr) ctx.mkIntConst("j1"));
		Expr compareExpr2 = ctx.mkLe((ArithExpr) ctx.mkIntConst("j1"),
				(ArithExpr) (IntExpr) ctx.mkInt(numberOfTuples));
		// Expr andExpr1 = ctx.mkAnd((BoolExpr) compareExpr1, (BoolExpr)compareExpr2,
		// (BoolExpr) ctx.mkEq(smtMap(arrNameSQ, "j1", -1, attrNamesSQ.length-1),
		// ctx.mkInt(1)));

		Expr[] colValueBQForForward = new Expr[groupByNodeDS.noOfGroupByColumns];
		Expr[] colValueSQForForward = new Expr[groupByNodeDS.noOfGroupByColumns];
		BoolExpr[] eqExprForward = new BoolExpr[groupByNodeDS.noOfGroupByColumns + 1];
		// System.out.println();

		Expr exitsExpr1;
		if (isExist) {
			Expr[] andExpr2 = new Expr[numberOfTuples];
			for (int j = 1; j <= numberOfTuples; j++) {
				for (i = 0; i < groupByNodeDS.noOfGroupByColumns; i++) {
					colValueSQForForward[i] = smtMap(aggregateDS.arrayNameOfSQInCtx, "", j, i);

					colValueBQForForward[i] = smtMap(aggregateDS.arrayNameOfBQInCtx, "i1", -1,
							aggregateDS.attrNamesOfBQ
									.indexOf(groupByNodeDS.groupByColumnsFromJSQ.get(i).getColumnName()));
					if (groupByNodeDS.groupByNodes.get(i).getIsMutant())
						eqExprForward[i] = (BoolExpr) ctx.mkTrue();

					else
						eqExprForward[i] = (BoolExpr) ctx.mkEq(colValueSQForForward[i], colValueBQForForward[i]);

				}
				if (countValue == 1) {
					eqExprForward[i] = (BoolExpr) ctx.mkEq(
							smtMap(aggregateDS.arrayNameOfSQInCtx, "", j, aggregateDS.attrColumnsOfSQ.size() - 1),
							ctx.mkInt(1));
				} else
					eqExprForward[i] = (BoolExpr) ctx.mkGe(
							smtMap(aggregateDS.arrayNameOfSQInCtx, "", j, aggregateDS.attrColumnsOfSQ.size() - 1),
							ctx.mkInt(2));
				andExpr2[j - 1] = ctx.mkAnd(eqExprForward);
			}
			exitsExpr1 = ctx.mkOr(andExpr2);

		} else {

			for (i = 0; i < groupByNodeDS.noOfGroupByColumns; i++) {
				colValueSQForForward[i] = smtMap(aggregateDS.arrayNameOfSQInCtx, "j1", -1, i);

				colValueBQForForward[i] = smtMap(aggregateDS.arrayNameOfBQInCtx, "i1", -1,
						aggregateDS.attrNamesOfBQ.indexOf(groupByNodeDS.groupByColumnsFromJSQ.get(i).getColumnName()));
				if (groupByNodeDS.groupByNodes.get(i).getIsMutant())
					eqExprForward[i] = (BoolExpr) ctx.mkTrue();

				else
					eqExprForward[i] = (BoolExpr) ctx.mkEq(colValueSQForForward[i], colValueBQForForward[i]);

			}

			eqExprForward[i] = (BoolExpr) ctx.mkEq(
					smtMap(aggregateDS.arrayNameOfSQInCtx, "j1", -1, aggregateDS.attrColumnsOfSQ.size() - 1),
					ctx.mkInt(1));
			Expr andExpr2 = ctx.mkAnd(eqExprForward[i]);

			exitsExpr1 = ctx.mkExists(arrForIndexj1, andExpr2, 1, null, null, null, null);

		}

		retunData.put("exitsExpr1", exitsExpr1);
		retunData.put("DefinesqTableIForward", DefinesqTableIForward);
		retunData.put("sqTableIForward", sqTableIForward);
		return retunData;
	}

	private static HashMap<String, Object> generateAggregateConstraints(GenerateCVC1 cvc, QueryBlockDetails qbt,
			AggregateDataStructure aggregateDS,
			ProjectedNodesData projectedNodeDs, GroupByNodesData groupByNodeDS, Expr[] arrForIndexI, int numberOfTuples,
			int cntColumnBQIndex) {
		// TODO Auto-generated method stub
		HashMap<String, Object> returnData = new HashMap<String, Object>();
		Vector<Expr> assertAggValDef = new Vector<Expr>();
		Vector<Expr> assertAggValCall = new Vector<Expr>();
		Vector<String> functionName = new Vector<String>();
		Vector<FuncDecl> DeclAssertAggVal = new Vector<FuncDecl>(); // Function declaration for asserting agg val
		Vector<String> DefineAssertAggVal = new Vector<String>(); // Function defination for asserting agg val fun

		HashMap<String, Boolean> isPresent = new HashMap<String, Boolean>();
		int i, j;

		if (projectedNodeDs.projectedNodes.size() > 0) {

			for (i = 0; i < projectedNodeDs.projectedNodes.size(); i++) {
				isPresent.put("SUM" + projectedNodeDs.projectedNodes.get(i).getColumn().getTableName() + "_"
						+ projectedNodeDs.projectedNodes.get(i).getColumn().getColumnName(), false);
				isPresent.put("COUNT" + projectedNodeDs.projectedNodes.get(i).getColumn().getTableName() + "_"
						+ projectedNodeDs.projectedNodes.get(i).getColumn(), false);

			}

			for (i = 0; i < projectedNodeDs.projectedNodes.size(); i++) {

				if (projectedNodeDs.projectedNodes.get(i).getAgg().getFunc().equalsIgnoreCase("SUM")) {
					// function definations if it is SUM
					// isPresent.putIfAbsent("SUM"+projectedColumnNodes[i].getColumn().getColumnName(),
					// true);
					if (isPresent.get("SUM" + projectedNodeDs.projectedNodes.get(i).getColumn().getTableName() + "_"
							+ projectedNodeDs.projectedNodes.get(i).getColumn().getColumnName()))
						continue;
					isPresent.put("SUM" + projectedNodeDs.projectedNodes.get(i).getColumn().getTableName() + "_"
							+ projectedNodeDs.projectedNodes.get(i).getColumn().getColumnName(), true);

					putFunDeclAndAssertInStruct(qbt, i, "SUM", projectedNodeDs.projectedNodes, functionName,
							DeclAssertAggVal,
							ctxFuncDecls, DefineAssertAggVal, assertAggValCall, arrForIndexI);

					assertAggValDef.add(getAggConstrintsForSUM(cvc, aggregateDS, groupByNodeDS, projectedNodeDs, i,
							numberOfTuples, cntColumnBQIndex, false));
				}

				else if (projectedNodeDs.projectedNodes.get(i).getAgg().getFunc().equalsIgnoreCase("COUNT")) {
					if (isPresent.get("COUNT" + projectedNodeDs.projectedNodes.get(i).getColumn().getTableName()
							+ "_" + projectedNodeDs.projectedNodes.get(i).getColumn().getColumnName()))
						continue;
					// ifCountPresent = true;
					isPresent.put("COUNT" + projectedNodeDs.projectedNodes.get(i).getColumn().getTableName() + "_"
							+ projectedNodeDs.projectedNodes.get(i).getColumn().getColumnName(), true);
					putFunDeclAndAssertInStruct(qbt, i, "COUNT", projectedNodeDs.projectedNodes, functionName,
							DeclAssertAggVal,
							ctxFuncDecls, DefineAssertAggVal, assertAggValCall, arrForIndexI);

					assertAggValDef.add(getAggConstrintsForCOUNT(cvc, aggregateDS, groupByNodeDS, projectedNodeDs,
							i, numberOfTuples, cntColumnBQIndex, false));
				}

				else if (projectedNodeDs.projectedNodes.get(i).getAgg().getFunc().equalsIgnoreCase("MIN")) {
					putFunDeclAndAssertInStruct(qbt, i, "MIN", projectedNodeDs.projectedNodes, functionName,
							DeclAssertAggVal,
							ctxFuncDecls, DefineAssertAggVal, assertAggValCall, arrForIndexI);

					assertAggValDef.add(getAggConstrintsForMINMAX(cvc, aggregateDS, groupByNodeDS, projectedNodeDs,
							i, numberOfTuples, cntColumnBQIndex,
							projectedNodeDs.projectedNodes.get(i).getAgg().getFunc()));

				}

				else if (projectedNodeDs.projectedNodes.get(i).getAgg().getFunc().equalsIgnoreCase("MAX")) {
					putFunDeclAndAssertInStruct(qbt, i, "MAX", projectedNodeDs.projectedNodes, functionName,
							DeclAssertAggVal,
							ctxFuncDecls, DefineAssertAggVal, assertAggValCall, arrForIndexI);

					assertAggValDef.add(getAggConstrintsForMINMAX(cvc, aggregateDS, groupByNodeDS, projectedNodeDs,
							i, numberOfTuples, cntColumnBQIndex,
							projectedNodeDs.projectedNodes.get(i).getAgg().getFunc()));

				}

				else if (projectedNodeDs.projectedNodes.get(i).getAgg().getFunc().equalsIgnoreCase("AVG")) {

					if (!isPresent.get("SUM" + projectedNodeDs.projectedNodes.get(i).getColumn().getTableName()
							+ "_" + projectedNodeDs.projectedNodes.get(i).getColumn().getColumnName())) {
						putFunDeclAndAssertInStruct(qbt, i, "SUM", projectedNodeDs.projectedNodes, functionName,
								DeclAssertAggVal,
								ctxFuncDecls, DefineAssertAggVal, assertAggValCall, arrForIndexI);

						Expr constraintsForSum = getAggConstrintsForSUM(cvc, aggregateDS, groupByNodeDS,
								projectedNodeDs, i, numberOfTuples, cntColumnBQIndex, true);
						assertAggValDef.add(constraintsForSum);

						isPresent.put("SUM" + projectedNodeDs.projectedNodes.get(i).getColumn().getTableName() + "_"
								+ projectedNodeDs.projectedNodes.get(i).getColumn().getColumnName(), true);
					}

					if (!isPresent.get("COUNT" + projectedNodeDs.projectedNodes.get(i).getColumn().getTableName()
							+ "_" + projectedNodeDs.projectedNodes.get(i).getColumn().getColumnName())) {
						putFunDeclAndAssertInStruct(qbt, i, "COUNT", projectedNodeDs.projectedNodes, functionName,
								DeclAssertAggVal,
								ctxFuncDecls, DefineAssertAggVal, assertAggValCall, arrForIndexI);

						Expr constraintsForCount = getAggConstrintsForCOUNT(cvc, aggregateDS, groupByNodeDS,
								projectedNodeDs, i, numberOfTuples, cntColumnBQIndex, true);

						assertAggValDef.add(constraintsForCount);

						isPresent.put("COUNT" + projectedNodeDs.projectedNodes.get(i).getColumn().getTableName()
								+ "_" + projectedNodeDs.projectedNodes.get(i).getColumn().getColumnName(), true);
					}

					putFunDeclAndAssertInStruct(qbt, i, "AVG", projectedNodeDs.projectedNodes, functionName,
							DeclAssertAggVal,
							ctxFuncDecls, DefineAssertAggVal, assertAggValCall, arrForIndexI);

					assertAggValDef.add(getAggConstrintsForAVG(cvc, aggregateDS, groupByNodeDS, projectedNodeDs, i,
							numberOfTuples, cntColumnBQIndex,
							projectedNodeDs.projectedNodes.get(i).getAgg().getFunc()));

				}

			}
		}

		returnData.put("DefineAssertAggVal", DefineAssertAggVal);
		returnData.put("DeclAssertAggVal", DeclAssertAggVal);
		returnData.put("functionName", functionName);
		returnData.put("assertAggValCall", assertAggValCall);
		returnData.put("assertAggValDef", assertAggValDef);

		return returnData;

	}

	private static String getPrimaryKeyConstraintsForGSQTable(GenerateCVC1 cvc,
			AggregateDataStructure aggregateDS, String indexType, Integer numberOfTuples) {
		Boolean primaryKeyMethod = false;
		Vector<String> primaryKeySQ = aggregateDS.primaryKeyColumnsofSQ;
		Expr cntOfSQColumnSQi1 = ConstraintGenerator.genSelectTest2(cvc, aggregateDS.subqueryTableName,
				aggregateDS.attrColumnsOfSQ.indexOf(aggregateDS.countColOfSQ.getColumnName()), "i1");
		Expr cntOfSQColumnSQj1 = ConstraintGenerator.genSelectTest2(cvc, aggregateDS.subqueryTableName,
				aggregateDS.attrColumnsOfSQ.indexOf(aggregateDS.countColOfSQ.getColumnName()), "j1");

		Expr orExprTempForPK = ConstraintGenerator.ctx.mkOr(
				ConstraintGenerator.ctx.mkEq((ArithExpr) cntOfSQColumnSQi1,
						(ArithExpr) ConstraintGenerator.ctx.mkInt(0)),
				ConstraintGenerator.ctx.mkEq((ArithExpr) cntOfSQColumnSQj1,
						(ArithExpr) ConstraintGenerator.ctx.mkInt(0)));

		BoolExpr[] andexprConstraintsTemp = new BoolExpr[primaryKeySQ.size() + 1];
		int p = 0;
		String primaryKeyConstraintsOfSQ = "";

		primaryKeySQ = aggregateDS.primaryKeyColumnsofSQ;

		if (primaryKeySQ.size() > 0) {
			for (int i = 0; i < primaryKeySQ.size(); i++) {
				Expr selecti1 = ConstraintGenerator.genSelectTest2(cvc, aggregateDS.subqueryTableName,
						aggregateDS.attrColumnsOfSQ.indexOf(primaryKeySQ.get(i)), "i1");
				;
				Expr selectj1 = ConstraintGenerator.genSelectTest2(cvc, aggregateDS.subqueryTableName,
						aggregateDS.attrColumnsOfSQ.indexOf(primaryKeySQ.get(i)), "j1");
				;
				andexprConstraintsTemp[p] = (BoolExpr) ConstraintGenerator.ctx.mkEq(selecti1, selectj1);
				p++;
			}
			for (int k = primaryKeySQ.size(); k < andexprConstraintsTemp.length; k++) {
				andexprConstraintsTemp[k] = ctx.mkTrue();
			}
			andexprConstraintsTemp[p] = ConstraintGenerator.ctx.mkNot(ConstraintGenerator.ctx.mkEq(
					(Expr) ConstraintGenerator.ctx.mkIntConst("i1"),
					(Expr) ConstraintGenerator.ctx.mkIntConst("j1")));

			Expr andExprTempForPK = ConstraintGenerator.ctx.mkAnd(andexprConstraintsTemp);

			String pkconstUsingNeq = "";
			if (primaryKeyMethod == true) {
				ArrayList<Column> primaryKeycols = new ArrayList<>();
				for (String a : primaryKeySQ) {
					primaryKeycols.add(cvc.getTableMap().getSQTableByName(aggregateDS.subqueryTableName).getColumn(a));
				}
				pkconstUsingNeq = AddDataBaseConstraints.getPrimaryKeyConstUsingNonEquiMethod(primaryKeycols,
						numberOfTuples);

			}
			if (pkconstUsingNeq.equalsIgnoreCase("")) {
				primaryKeyConstraintsOfSQ += "\n(assert (forall ((i1 " + indexType + ") (j1 " + indexType
						+ ")) \n\t (=> \n\t"
						+ andExprTempForPK.toString() + "\n\t\t" + orExprTempForPK + ")))\n\n";

			} else {
				if (pkconstUsingNeq.contains("select"))
					primaryKeyConstraintsOfSQ = "\n(assert " + pkconstUsingNeq + ")\n";
				else
					primaryKeyConstraintsOfSQ = "";
			}

		}

		Expr cnt0or1 = ctx.mkOr(ctx.mkEq(cntOfSQColumnSQi1, ctx.mkInt(0)),
				ctx.mkEq(cntOfSQColumnSQi1, ctx.mkInt(1)));
		primaryKeyConstraintsOfSQ += "\n(assert (forall ((i1 " + indexType + ")) \n\t " + cnt0or1.toString()
				+ "))\n\n";

		return primaryKeyConstraintsOfSQ;

	}

	private static void getTransformedAttributesFromRefToJSQTables(GenerateCVC1 cvc, ArrayList attrNamesBQArrayList,
			Vector<String> groupby_column, ArrayList<Node> groupByNodes, Vector<String> agg_column_name,
			ArrayList<Node> projectedNodes, String subqueryType) {
		if (subqueryType.equalsIgnoreCase(subqueryType)) {
			String agg_table = cvc.subqueryConstraintsMap.get(subqueryType).SQTableName.keySet().iterator().next();
			Integer numberOfTuples = cvc.getNoOfTuples()
					.get(cvc.subqueryConstraintsMap.get(subqueryType).SQTableName.keySet().iterator().next());
			attrNamesBQArrayList = cvc.subqueryConstraintsMap.get(subqueryType).SQColumns.get(agg_table);
			for (int i = 0; i < groupByNodes.size(); i++) {
				for (int j = 0; j < attrNamesBQArrayList.size(); j++) {

					if (attrNamesBQArrayList.get(j).toString().contains(groupByNodes.get(i).getColumn().getColumnName())
							&& attrNamesBQArrayList.get(j).toString()
									.contains(groupByNodes.get(i).getColumn().getTableName())) {
						groupby_column.set(i, attrNamesBQArrayList.get(j).toString());
						break;
					}
				}

			}
			for (int i = 0; i < projectedNodes.size(); i++) {
				for (int j = 0; j < attrNamesBQArrayList.size(); j++) {

					if (attrNamesBQArrayList.get(j).toString()
							.contains(projectedNodes.get(i).getColumn().getColumnName())
							&& attrNamesBQArrayList.get(j).toString()
									.contains(projectedNodes.get(i).getColumn().getTableName())) {
						agg_column_name.set(i, attrNamesBQArrayList.get(j).toString());
						break;
					}
				}

			}
		}
	}

	// SqorBq = 1 if is asking for count index in Sq else anything
	private static int getIndexOfMutantColumnCount(Vector<String> attrNamesSQ, MutationStructure currentMutant,
			String checkAggFun,
			int SqorBq) {

		int i = 0;
		int k = 0;

		String aggFun = checkAggFun;
		Column c = (Column) currentMutant.getMutationNode();
		for (int j = 0; j < attrNamesSQ.size(); j++) {
			if (SqorBq == 1 && attrNamesSQ.get(j).contains(aggFun)
					&& attrNamesSQ.get(j).contains(removeAllDigit(c.getColumnName()))) {
				i = j;
				break;
			}
			if (SqorBq != 1 && attrNamesSQ.get(j).contains(removeAllDigit(c.getColumnName()))
					&& attrNamesSQ.get(j).contains(c.getTable().getTableName())) {
				i = j;
				break;
			}
		}
		return i;

	}

	private static void putFunDeclAndAssertInStruct(QueryBlockDetails qbt, int indexOfProjectedNode, String operation,
			ArrayList<Node> projectedColumnNodes, Vector<String> functionName, Vector<FuncDecl> declAssertAggVal,
			HashMap<String, FuncDecl> ctxFuncDecls2, Vector<String> defineAssertAggVal, Vector<Expr> assertAggValCall,
			Expr[] arrForIndexI) {
		String indexType = "Int";
		if (!functionName.contains(
				"GETAGGVAL" + operation + projectedColumnNodes.get(indexOfProjectedNode).getColumn().getColumnName()
						+ qbt.getLevel())) {
			functionName.add(
					"GETAGGVAL" + operation + projectedColumnNodes.get(indexOfProjectedNode).getColumn().getColumnName()
							+ qbt.getLevel()); // function names

			if (Configuration.isEnumInt.equalsIgnoreCase("true")) {
				EnumSort currentSort = (EnumSort) ConstraintGenerator.ctxSorts.get(enumArrayIndex);
				declAssertAggVal
						.add(ctx.mkFuncDecl(functionName.get(functionName.size() - 1), currentSort, ctx.mkBoolSort())); // creating
																														// function
				indexType = enumArrayIndex; // declarations
			} else {
				declAssertAggVal
						.add(ctx.mkFuncDecl(functionName.get(functionName.size() - 1), ctx.getIntSort(),
								ctx.mkBoolSort())); // creating
													// function
													// declarations

			}
			ctxFuncDecls.put(operation, declAssertAggVal.get(declAssertAggVal.size() - 1)); // putting function
			// declaration in context
			defineAssertAggVal
					.add("(define-fun " + functionName.get(functionName.size() - 1) + "((i " + indexType + "))Bool"); // function
			// defination
			// using
			// "define-fun"

			assertAggValCall.add(declAssertAggVal.get(declAssertAggVal.size() - 1).apply(arrForIndexI));
		}

	}

	private static Expr getAggConstrintsForAVG(GenerateCVC1 cvc, AggregateDataStructure aggDs, GroupByNodesData gbDs,
			ProjectedNodesData prDs,
			int i, int numberOfTuples, int cntColumnBQIndex, String func) {

		int numberOfGroupByColumns = gbDs.noOfGroupByColumns;
		String subquery_table_name = aggDs.subqueryTableName;
		String arrNameSQ = aggDs.arrayNameOfSQInCtx;
		String arrNameBQ = aggDs.arrayNameOfBQInCtx;
		Vector<Integer> indexOfProjectedColmnsInSQ = prDs.indexOfProjectedColmnsInSQ;
		Vector<String> attrNamesBQArrayList = aggDs.attrNamesBQ;
		Vector<String> agg_column_name = new Vector<String>();
		for (Column c : prDs.aggregateColumnsFromJSQ) {
			agg_column_name.add(c.getColumnName());
		}
		Vector<Column> agg_columns_reftables = prDs.aggregateColumnsFromRefTables;

		Vector<String> attrNamesSQ = aggDs.attrColumnsOfSQ;
		Vector<String> groupby_column = new Vector<String>();
		Vector<Sort> attrTypesSQ = aggDs.attrTypesOfSQ;
		HashMap<String, Boolean> agg_column_isDictinct = aggDs.isColumnDistinctInSQ;

		ArrayList<Node> groupByNodes = gbDs.groupByNodes;

		for (Column c : gbDs.groupByColumnsFromJSQ) {
			groupby_column.add(c.getColumnName());
		}

		String attrCountAggFun = getColumnNameForGSQ(subquery_table_name, agg_columns_reftables.get(i).getTableName(),
				"COUNT", removeAllDigit(agg_column_name.get(i).split("__")[1]));
		// subquery_table_name + "_COUNT" +
		// agg_columns_reftables.get(i).getTableName()+"__" +
		// removeAllDigit(agg_column_name.get(i).split("__")[1]);
		String attrSumAggFun = getColumnNameForGSQ(subquery_table_name, agg_columns_reftables.get(i).getTableName(),
				"SUM", removeAllDigit(agg_column_name.get(i).split("__")[1]));

		String attrAvgAggFun = getColumnNameForGSQ(subquery_table_name, agg_columns_reftables.get(i).getTableName(),
				"AVG", removeAllDigit(agg_column_name.get(i).split("__")[1]));
		// IntExpr[] iColArray = new IntExpr[] { ctx.mkIntConst("i") };
		// List<String> list = Arrays. asList(attrNamesSQ);
		// Vector<String> attrNamesSQVec = new Vector<String>( list );

		Expr eqExpr = ctx.mkEq(smtMap(arrNameSQ, "i", -1, attrNamesSQ.indexOf(attrAvgAggFun)),
				ctx.mkDiv(smtMap(arrNameSQ, "i", -1, attrNamesSQ.indexOf(attrSumAggFun)),
						smtMap(arrNameSQ, "i", -1, attrNamesSQ.indexOf(attrCountAggFun))));

		Expr iteExpr = ctx.mkITE(ctxFuncDecls.get("ISNULL_" + removeAllDigit(agg_column_name.get(i).split("__")[1]))
				.apply(smtMap(arrNameSQ, "i", -1, attrNamesSQ.indexOf(attrSumAggFun))),
				ctxFuncDecls.get("ISNULL_" + removeAllDigit(agg_column_name.get(i).split("__")[1]))
						.apply(smtMap(arrNameSQ, "i", -1, attrNamesSQ.indexOf(attrAvgAggFun))),
				eqExpr);

		Expr mkInvalid = ctx.mkEq(smtMap(arrNameSQ, "i", -1, attrNamesSQ.size() - 1), ctx.mkInt(0));

		// System.out.println(eqExpr.toString());

		return ctx.mkOr(iteExpr, mkInvalid);
	}

	private static HashMap<String, Object> createTempTableColumnsForAggregates(AggregateDataStructure agDs,
			GroupByNodesData gbDS, ProjectedNodesData prDS, String subqueryType) {
		// String aggTable,
		// ArrayList<Node> groupByNodes, ArrayList<Node> projectedNodes

		HashMap<String, Object> columnNameAndDataTypes = new HashMap<String, Object>();
		Vector<String> columns = new Vector<String>();
		Vector<Sort> columnDataTypes = new Vector<Sort>();
		Vector<String> primaryKey = new Vector<String>();
		HashMap<String, Integer> AggColIndexMap = new HashMap<String, Integer>();
		HashMap<String, Boolean> agg_column_isDictinct = new HashMap<String, Boolean>();
		Vector<String> agg_column_name = new Vector<String>();
		Vector<String> groupby_column = new Vector<String>();
		int count = 0;
		String columnName;

		String subqueryTableName = agDs.getTableNameOfSQ();
		ArrayList<Node> groupByNodes = gbDS.getGroupByNodes();
		ArrayList<Node> projectedNodes = prDS.getProjectedNodes();

		// int[] indexOfProjectedColmnsInSQ = new int[projectedNodes.size()]; // -
		// comment

		Table sqi = new Table(subqueryTableName);
		int flag = 1;
		Map<String, Table> tableMap = new HashMap<String, Table>();
		int i;
		for (i = 0; i < groupByNodes.size(); i++) {
			Node gb = groupByNodes.get(i);

			gbDS.groupByColumnsFromRefTables.add(groupByNodes.get(i).getColumn());

			columnName = getColumnNameForGSQ(subqueryTableName, groupByNodes.get(i).getColumn().getTableName(), "",
					groupByNodes.get(i).getColumn().getColumnName());
			// columnName = subqueryTableName + "_" +
			// groupByNodes.get(i).getColumn().getTableName() + "__"
			// + groupByNodes.get(i).getColumn().getColumnName() + i;

			// chaitra changed for repeated projections
			if (columns.contains(columnName)) {
				columnName += Integer.toString(i);
			}
			// chaitra changed for repeated projections end

			columns.add(columnName);
			String groupby_column_dt = groupByNodes.get(i).getColumn().getCvcDatatype();
			columnDataTypes.add(getColumnSort(groupby_column_dt));

			Column col = new Column(groupByNodes.get(i).getColumn());
			col.setColumnName(columnName);
			col.setTableName(subqueryTableName);
			col.setTable(sqi);
			col.setBaseRelation(groupByNodes.get(i).getColumn().getTable().getTableName());
			sqi.addColumn(col);
			if (!groupByNodes.get(i).getIsMutant()) {
				sqi.addColumnInPrimaryKey(col);
				primaryKey.add(columnName);
			}
		}
		int index = 0;
		for (int j = 0; j < projectedNodes.size(); j++) {

			AggregateFunction aggColumn = projectedNodes.get(j).getAgg();
			if (aggColumn == null)
				continue;
			String agg_function = aggColumn.getFunc().toString();
			String columnNameBase = "";
			if (projectedNodes.get(j).getOrgiColumn() != null) // in case of transformed corr condition
				columnNameBase = projectedNodes.get(j).getOrgiColumn().getColumnName();
			else
				columnNameBase = projectedNodes.get(j).getColumn().getColumnName();
			prDS.aggregateColumnsFromRefTables.add(aggColumn.getAggExp().getColumn());

			String tableName = "";

			if (projectedNodes.get(j).getOrgiColumn() != null) // in case of transformed corr condition
				tableName = projectedNodes.get(j).getOrgiColumn().getTableName();
			else
				tableName = projectedNodes.get(j).getColumn().getTableName();

			columnName = getColumnNameForGSQ(subqueryTableName, tableName,
					agg_function, columnNameBase);
			// columnName = subqueryTableName + "_" + agg_function
			// +projectedNodes.get(j).getColumn().getTableName() + "__"
			// + columnName;
			if (columns.contains(columnName)) {
				index--;
				continue;
			}

			if (agg_function.equalsIgnoreCase("AVG")) {

				String temColumnName = getColumnNameForGSQ(subqueryTableName,
						tableName, "COUNT",
						columnNameBase);
				if (!columns.contains(temColumnName)) {
					columns.add(
							temColumnName);

					agDs.isColumnDistinctInSQ.put(temColumnName, aggColumn.isDistinct());

					index++;

					agDs.columnToIndexMapInSQ.put(temColumnName, columns.indexOf(temColumnName));
					// AggColIndexMap.put(columnName, i + j); // comment
					Column col = new Column(aggColumn.getAggCol());
					col.setColumnName(temColumnName);
					col.setTableName(subqueryTableName);
					col.setTable(sqi);
					col.setBaseRelation(aggColumn.getAggExp().getColumn().getTable().getTableName());
					// if (agg_function.equalsIgnoreCase("COUNT")) {
					columnDataTypes.add(getColumnSort("INT"));
					col.setCvcDatatype("INT");

					sqi.addColumn(col);

					prDS.indexOfProjectedColmnsInSQ.add(columns.indexOf(temColumnName));
				}
				temColumnName = getColumnNameForGSQ(subqueryTableName, tableName,
						"SUM", columnNameBase);

				if (!columns.contains(
						temColumnName)) {
					columns.add(
							temColumnName);

					agDs.isColumnDistinctInSQ.put(
							temColumnName,
							aggColumn.isDistinct());

					agDs.columnToIndexMapInSQ.put(
							temColumnName,
							columns.indexOf(temColumnName));

					index++;
					agDs.columnToIndexMapInSQ.put(temColumnName, columns.indexOf(temColumnName));
					// AggColIndexMap.put(columnName, i + j); // comment
					Column col = new Column(aggColumn.getAggCol());
					col.setColumnName(temColumnName);
					col.setTableName(subqueryTableName);
					col.setTable(sqi);
					col.setBaseRelation(aggColumn.getAggExp().getColumn().getTable().getTableName());
					if (agg_function.equalsIgnoreCase("COUNT")) {
						columnDataTypes.add(getColumnSort("INT"));
						col.setCvcDatatype("INT");

					}

					else {
						columnDataTypes.add(getColumnSort(aggColumn.getAggExp().getColumn().getCvcDatatype()));
						col.setCvcDatatype(aggColumn.getAggExp().getColumn().getCvcDatatype());
					}

					sqi.addColumn(col);

					prDS.indexOfProjectedColmnsInSQ.add(columns.indexOf(temColumnName));
				}
				index++;
			}
			if (i + j + index == 0)
				i++;
			columns.add(columnName);
			agDs.isColumnDistinctInSQ.put(columnName, aggColumn.isDistinct());

			columns.indexOf(columnName);
			agDs.columnToIndexMapInSQ.put(columnName, columns.indexOf(columnName));
			// AggColIndexMap.put(columnName, i + j); // comment
			Column col = new Column(aggColumn.getAggCol());
			col.setColumnName(columnName);
			col.setTableName(subqueryTableName);
			col.setTable(sqi);
			col.setBaseRelation(aggColumn.getAggExp().getColumn().getTable().getTableName());
			// agg_column_dt[j] = aggColumn[j].getAggExp().getColumn().getCvcDatatype();
			// agg_table = aggColumn[j].getAggExp().getTable().getTableName();
			if (agg_function.equalsIgnoreCase("COUNT")) {
				columnDataTypes.add(getColumnSort("INT"));
				col.setCvcDatatype("INT");

			}

			else {
				columnDataTypes.add(getColumnSort(aggColumn.getAggExp().getColumn().getCvcDatatype()));
				col.setCvcDatatype(aggColumn.getAggExp().getColumn().getCvcDatatype());
			}

			sqi.addColumn(col);

			prDS.indexOfProjectedColmnsInSQ.add(columns.indexOf(columnName));

		}

		// chaitra add expression columns at GSQ level
		for (int j = 0; j < projectedNodes.size(); j++) {
			if (projectedNodes.get(j).getType().equalsIgnoreCase("BAO NODE")) {
				projectedNodes.get(j).expDetails
						.add(new Node.ExpNodeWithTable(sqi, projectedNodes.get(j), projectedNodes.get(j)));
				int colId = projectedNodes.get(j).expDetails.size();
				columnName = sqi.getTableName() + "__EXP" + Integer.toString(colId);
				columns.add(columnName);
				columnDataTypes.add(ConstraintGenerator.ctx.getRealSort());
				Column col = new Column(columnName, sqi);
				col.setDataType(2);// REAL
				col.setCvcDatatype("Real");
				col.setColumnSize(0);
				agDs.setCountColumnOfSQ(col);
				sqi.addColumn(col);
			}
		}
		// chaitra add expression columns at GSQ level end

		if (Configuration.getProperty("cntFlag").equalsIgnoreCase("true")) {
			columns.add(subqueryTableName + "_XDATA_CNT");
			columnDataTypes.add(getColumnSort("INT"));
			Column col = new Column(subqueryTableName + "_XDATA_CNT", sqi);
			col.setDataType(4);// INT
			col.setCvcDatatype("INT");
			col.setColumnSize(0);
			agDs.setCountColumnOfSQ(col);

			sqi.addColumn(col);
		}
		sqi.setSQType(subqueryType);
		tableMap.put(subqueryTableName, sqi);
		// If there are no group-by columns, treat the projected aggregate columns as
		// the primary key.
		if (primaryKey.isEmpty()) {
			for (int j = 0; j < projectedNodes.size(); j++) {
				AggregateFunction aggColumn = projectedNodes.get(j).getAgg();
				String agg_function = aggColumn.getFunc().toString();
				String columnNameBase = (projectedNodes.get(j).getOrgiColumn() != null)
						? projectedNodes.get(j).getOrgiColumn().getColumnName()
						: projectedNodes.get(j).getColumn().getColumnName();
				String tableName = (projectedNodes.get(j).getOrgiColumn() != null)
						? projectedNodes.get(j).getOrgiColumn().getTableName()
						: projectedNodes.get(j).getColumn().getTableName();
				String colName = getColumnNameForGSQ(subqueryTableName, tableName, agg_function, columnNameBase);
				primaryKey.add(colName);
			}
		}

		agDs.primaryKeyColumnsofSQ.addAll(primaryKey);
		agDs.attrColumnsOfSQ.addAll(columns);
		agDs.attrTypesOfSQ.addAll(columnDataTypes);
		columnNameAndDataTypes.put("TableMap", tableMap);

		return columnNameAndDataTypes;
	}

	private static Expr getAggConstrintsForSUM(GenerateCVC1 cvc, AggregateDataStructure aggDs, GroupByNodesData gbDs,
			ProjectedNodesData prDs,
			int indexOfProjectedNode, int numberOfTuples, int cntColumnBQIndex, Boolean callForAVG) {
		int numberOfGroupByColumns = gbDs.noOfGroupByColumns;
		String subquery_table_name = aggDs.subqueryTableName;
		String arrNameSQ = aggDs.arrayNameOfSQInCtx;
		String arrNameBQ = aggDs.arrayNameOfBQInCtx;
		Vector<Integer> indexOfProjectedColmnsInSQ = prDs.indexOfProjectedColmnsInSQ;
		Vector<String> attrNamesBQArrayList = aggDs.attrNamesBQ;
		Vector<String> agg_column_name = new Vector<String>();
		for (Column c : prDs.aggregateColumnsFromJSQ) {
			agg_column_name.add(c.getColumnName());
		}
		Vector<Column> agg_columns_reftables = prDs.aggregateColumnsFromRefTables;
		Vector<Column> agg_columns_jsq = prDs.aggregateColumnsFromJSQ;
		Vector<String> attrNamesSQ = aggDs.attrColumnsOfSQ;
		Vector<String> groupby_column = new Vector<String>();
		Vector<Sort> attrTypesSQ = aggDs.attrTypesOfSQ;
		HashMap<String, Boolean> agg_column_isDictinct = aggDs.isColumnDistinctInSQ;

		ArrayList<Node> groupByNodes = gbDs.groupByNodes;

		for (Column c : gbDs.groupByColumnsFromJSQ) {
			groupby_column.add(c.getColumnName());
		}

		Expr selectCntBQ;
		Expr[] colValueSQ = new Expr[numberOfGroupByColumns + 1];
		for (int s = 0; s < numberOfGroupByColumns; s++) {
			colValueSQ[s] = smtMap(arrNameSQ, "i", -1, s);
		}
		Expr colValueSQ1;

		String columnNameFromSQorBQ = "";
		String tempColumnName = "";
		String notNullColForExp = "";

		// chaitra changed here for expression
		if (agg_column_name.get(indexOfProjectedNode).contains("EXP")) {
			columnNameFromSQorBQ = agg_columns_jsq.get(indexOfProjectedNode).getBaseRelation() == null
					? agg_columns_jsq.get(indexOfProjectedNode).getTableName()
					: agg_columns_jsq.get(indexOfProjectedNode).getBaseRelation();
			tempColumnName = getColumnNameForGSQ(subquery_table_name,
					columnNameFromSQorBQ, "SUM",
					agg_column_name.get(indexOfProjectedNode));
		} else {
			columnNameFromSQorBQ = agg_columns_reftables.get(indexOfProjectedNode).getBaseRelation() == null
					? agg_columns_reftables.get(indexOfProjectedNode).getTableName()
					: agg_columns_reftables.get(indexOfProjectedNode).getBaseRelation();
			tempColumnName = getColumnNameForGSQ(subquery_table_name,
					columnNameFromSQorBQ, "SUM",
					removeAllDigit(agg_column_name.get(indexOfProjectedNode).split("__")[1]));
		}
		// chaitra changed here for expression end

		// String columnNameFromSQorBQ =
		// agg_columns_reftables.get(indexOfProjectedNode).getBaseRelation() == null
		// ? agg_columns_reftables.get(indexOfProjectedNode).getTableName()
		// : agg_columns_reftables.get(indexOfProjectedNode).getBaseRelation();
		// String tempColumnName = getColumnNameForGSQ(subquery_table_name,
		// columnNameFromSQorBQ, "SUM",
		// removeAllDigit(agg_column_name.get(indexOfProjectedNode).split("__")[1]));

		if (!callForAVG) {
			// chaitra added check
			if (aggDs.attrColumnsOfSQ.indexOf(tempColumnName) < 0)
				return null;
			colValueSQ1 = smtMap(arrNameSQ, "i", -1, aggDs.attrColumnsOfSQ.indexOf(tempColumnName));
		} else {
			// System.out.println(subquery_table_name + "_SUM" +
			// agg_columns_reftables.get(indexOfProjectedNode).getTableName() + "__"
			// + removeAllDigit(agg_column_name.get(indexOfProjectedNode).split("__")[1]));
			// if(attrNamesSQ.indexOf(tempColumnName)<0){}
			colValueSQ1 = smtMap(arrNameSQ, "i", -1, attrNamesSQ.indexOf(tempColumnName));
		}

		Expr[][] colValueBQ = new Expr[numberOfGroupByColumns + 1][numberOfTuples];
		BoolExpr[][] calculateAggregate = new BoolExpr[numberOfTuples][numberOfGroupByColumns];
		Expr[] ifthenelseExpr = new Expr[numberOfTuples];
		ArithExpr[][] multieExpr = new ArithExpr[numberOfTuples][2];
		Expr[] multiplyexpr = new Expr[numberOfTuples];
		ArithExpr[] addExpr = new ArithExpr[numberOfTuples];
		Expr[] andGroupByAttr = new Expr[numberOfTuples];
		Expr[] andForIfthenelse = new Expr[numberOfTuples];
		Expr[] isNullExprs = new Expr[numberOfTuples];

		String temp = "";
		String functionName = "";
		for (int p = 0; p < numberOfTuples; p++) {
			int s;
			for (s = 0; s < numberOfGroupByColumns; s++) {
				colValueBQ[s][p] = smtMap(arrNameBQ, "i", p + 1, attrNamesBQArrayList.indexOf(groupby_column.get(s)));
				if (groupByNodes.get(s).getIsMutant())
					calculateAggregate[p][s] = (BoolExpr) ctx.mkTrue();
				// calculateAggregate[p][s] = ctx.mkNot((BoolExpr) ctx.mkEq(colValueSQ[s],
				// colValueBQ[s][p]));
				else
					calculateAggregate[p][s] = (BoolExpr) ctx.mkEq(colValueSQ[s], colValueBQ[s][p]);
				// if (calculateAggregate[p].length == 0) {
				// calculateAggregate[p][0] = ctx.mkTrue();
				// }
			}
			colValueBQ[s][p] = smtMap(arrNameBQ, "i", p + 1,
					attrNamesBQArrayList.indexOf(agg_column_name.get(indexOfProjectedNode)));

			// System.out.println("ISNULL_" +
			// removeAllDigit(agg_column_name.get(indexOfProjectedNode).split("__")[0]));
			String dataType = cvc.getTableMap().getSQTableByName(arrNameBQ.split("_")[1])
					.getColumn(agg_column_name.get(indexOfProjectedNode)).getCvcDatatype();
			functionName = dataType;

			// removeAllDigit(agg_column_name.get(indexOfProjectedNode).split("__")[1]);
			if (dataType.equalsIgnoreCase("int") || dataType.equalsIgnoreCase("real"))
				functionName = removeAllDigit(agg_column_name.get(indexOfProjectedNode).split("__")[1]);

			// chaitra changed here for exp
			if (agg_column_name.get(indexOfProjectedNode).contains("EXP")) {
				functionName = agg_columns_reftables.get(indexOfProjectedNode).getColumnName();
			}
			// chaitra changed here for exp end

			isNullExprs[p] = ctx.mkNot(
					ctxFuncDecls
							.get("ISNULL_" + functionName)
							.apply(colValueBQ[s][p]));

			selectCntBQ = smtMap(arrNameBQ, "i1", p + 1, cntColumnBQIndex);

			andGroupByAttr[p] = ctx.mkAnd(calculateAggregate[p]);
			andForIfthenelse[p] = ctx.mkAnd(andGroupByAttr[p], isNullExprs[p]);
			String refTableName = removeAllDigit(agg_column_name.get(indexOfProjectedNode).split("_")[1]);

			String aggAttr = tempColumnName;
			if (agg_column_isDictinct.get(aggAttr))
				ifthenelseExpr[p] = ctx.mkITE((BoolExpr) andForIfthenelse[p], ctx.mkInt(1), ctx.mkInt(0));
			else
				ifthenelseExpr[p] = ctx.mkITE((BoolExpr) andForIfthenelse[p], selectCntBQ, ctx.mkInt(0));

			multieExpr[p][1] = (ArithExpr) colValueBQ[numberOfGroupByColumns][p];
			multieExpr[p][0] = (ArithExpr) ifthenelseExpr[p];
			multiplyexpr[p] = ctx.mkMul(multieExpr[p]);
			addExpr[p] = (ArithExpr) multiplyexpr[p];

		}
		Expr additionexpr1 = ctx.mkAdd(addExpr);
		Expr eqexpr2 = ctx.mkEq(colValueSQ1, additionexpr1);
		Expr eqexprNull = ctxFuncDecls
				.get("ISNULL_" + functionName)
				.apply(colValueSQ1);

		Expr orForFirstIfthenelse = ctx.mkOr(andForIfthenelse);

		Expr orExprGetAggValFinal = ctx.mkOr((BoolExpr) ctx.mkITE(orForFirstIfthenelse, eqexpr2, eqexprNull),
				(BoolExpr) ctx.mkEq((ArithExpr) smtMap(arrNameSQ, "i", -1, attrNamesSQ.size() - 1), ctx.mkInt(0)));

		// @shalini:Add constraint: if COUNT == 0, then SUM must be NULL
		// Find COUNT column in SQ (it's the last attribute before the special count
		// column)
		String countColumnName = getColumnNameForGSQ(subquery_table_name,
				columnNameFromSQorBQ, "COUNT",
				removeAllDigit(agg_column_name.get(indexOfProjectedNode).split("__")[1]));

		int countColIndex = attrNamesSQ.indexOf(countColumnName);
		if (countColIndex >= 0) {
			Expr countExprSQ = smtMap(arrNameSQ, "i", -1, countColIndex);

			// Create: (= count 0) => (= sum null)
			Expr countIsZero = ctx.mkEq((ArithExpr) countExprSQ, ctx.mkInt(0));
			Expr sumIsNull = ctxFuncDecls.get("ISNULL_" + functionName).apply(colValueSQ1);
			Expr countZeroImpliesSumNull = ctx.mkImplies((BoolExpr) countIsZero, (BoolExpr) sumIsNull);

			// Combine: (original_constraint) AND (count_0_implies_sum_null)
			orExprGetAggValFinal = ctx.mkAnd((BoolExpr) orExprGetAggValFinal, (BoolExpr) countZeroImpliesSumNull);
		}

		return orExprGetAggValFinal;

	}

	// inegrated with clause - map columns from original to WITH table
	public static Boolean checkColumn(String ZcolumnName, String withColumnName, String withTableName,
			GenerateCVC1 cvc) {
		if (cvc.getqStructure().withClauseMap.get(withTableName.toUpperCase()) == null) {
			return false;
		}
		if (ZcolumnName.contains(withColumnName)) {
			return true;
		}
		if (cvc.withColumnMappings.size() == 0) {
			return false;
		}
		List<AbstractMap.SimpleEntry<String, String>> withColumnMappings = cvc.withColumnMappings.get(withTableName);
		if (withColumnMappings == null) {
			return false;
		}
		for (AbstractMap.SimpleEntry<String, String> entry : withColumnMappings) {
			// System.out.println(entry.getKey().equalsIgnoreCase(withColumnName));
			// System.out.println(ZcolumnName.contains(entry.getValue().toUpperCase()));
			if (entry.getKey().equalsIgnoreCase(withColumnName)
					&& ZcolumnName.contains(entry.getValue().toUpperCase())) {
				return true;
			}
		}
		return false;
	}
	// inegrated with clause - map columns from original to WITH table end

	// integrated with clause -find correct column for WITH table
	public static String findCorrectColumn(GenerateCVC1 cvc, String withTableName, String columnName) {
		String[] parts = columnName.split("__");
		String column = parts[parts.length - 1];
		String withColumn = "";
		List<AbstractMap.SimpleEntry<String, String>> columnList = cvc.withColumnMappings.get(withTableName);
		if (columnList == null) {
			return columnName;
		}
		for (AbstractMap.SimpleEntry<String, String> entry : columnList) {
			if (entry.getValue().equals(column.toLowerCase())) {
				withColumn = entry.getKey().toUpperCase();
				break;
			}
		}
		parts[parts.length - 1] = withColumn;
		String modified = "";
		for (String str : parts) {
			modified += str + "__";
		}
		modified = modified.substring(0, modified.length() - 2);
		return modified;
	}
	// integrated with clause -find correct column for WITH table end

	private static Expr getAggConstrintsForCOUNT(GenerateCVC1 cvc, AggregateDataStructure aggDs, GroupByNodesData gbDs,
			ProjectedNodesData prDs,
			int indexOfProjectedNode, int numberOfTuples, int cntColumnBQIndex, Boolean callForAVG) {

		int numberOfGroupByColumns = gbDs.noOfGroupByColumns;
		String subquery_table_name = aggDs.subqueryTableName;
		String arrNameSQ = aggDs.arrayNameOfSQInCtx;
		String arrNameBQ = aggDs.arrayNameOfBQInCtx;
		Vector<Integer> indexOfProjectedColmnsInSQ = prDs.indexOfProjectedColmnsInSQ;
		Vector<String> attrNamesBQArrayList = aggDs.attrNamesBQ;
		Vector<String> agg_column_name = new Vector<String>();
		for (Column c : prDs.aggregateColumnsFromJSQ) {
			agg_column_name.add(c.getColumnName());
		}
		Vector<String> attrNamesSQ = aggDs.attrColumnsOfSQ;
		Vector<String> groupby_column = new Vector<String>();
		Vector<Sort> attrTypesSQ = aggDs.attrTypesOfSQ;
		HashMap<String, Boolean> agg_column_isDictinct = aggDs.isColumnDistinctInSQ;

		ArrayList<Node> groupByNodes = gbDs.groupByNodes;

		for (Column c : gbDs.groupByColumnsFromJSQ) {
			groupby_column.add(c.getColumnName());
		}
		Vector<Column> agg_columns_reftables = prDs.aggregateColumnsFromRefTables;

		Expr selectCntBQ;
		Expr[] colValueSQ = new Expr[numberOfGroupByColumns + 1];

		for (int s = 0; s < numberOfGroupByColumns; s++) {
			colValueSQ[s] = smtMap(arrNameSQ, "i", -1, s);
		}
		Expr colValueSQ1;
		String columnNameFromSQorBQ = agg_columns_reftables.get(indexOfProjectedNode).getBaseRelation() == null
				? agg_columns_reftables.get(indexOfProjectedNode).getTableName()
				: agg_columns_reftables.get(indexOfProjectedNode).getBaseRelation();

		// chaitra changed for expression count
		String tempColumnName = getColumnNameForGSQ(subquery_table_name,
				columnNameFromSQorBQ, "COUNT",
				agg_column_name.get(indexOfProjectedNode));
		if (!agg_column_name.get(indexOfProjectedNode).contains("EXP"))
			tempColumnName = getColumnNameForGSQ(subquery_table_name,
					columnNameFromSQorBQ, "COUNT",
					removeAllDigit(agg_column_name.get(indexOfProjectedNode).split("__")[1]));
		// chaitra changed for expression count end

		// integrated with clause - call to function findCorrectColumn
		if (cvc.getqStructure().withTableName != null && !aggDs.attrColumnsOfSQ.contains(tempColumnName)) {
			if (cvc.withColumnMappings != null) {
				if (cvc.withColumnMappings.get(columnNameFromSQorBQ) != null) {
					tempColumnName = findCorrectColumn(cvc, columnNameFromSQorBQ, tempColumnName);
				}
			}
		}
		// integrated with clause - call to function findCorrectColumn end

		if (!callForAVG)
			colValueSQ1 = smtMap(arrNameSQ, "i", -1, aggDs.attrColumnsOfSQ.indexOf(tempColumnName));
		else {
			colValueSQ1 = smtMap(arrNameSQ, "i", -1, attrNamesSQ.indexOf(tempColumnName));

		}

		Expr[][] colValueBQ = new Expr[numberOfGroupByColumns + 1][numberOfTuples];
		BoolExpr[][] calculateAggregate = new BoolExpr[numberOfTuples][numberOfGroupByColumns];
		Expr[] ifthenelseExpr = new Expr[numberOfTuples];
		ArithExpr[][] multieExpr = new ArithExpr[numberOfTuples][2];
		Expr[] multiplyexpr = new Expr[numberOfTuples];
		ArithExpr[] addExpr = new ArithExpr[numberOfTuples];
		Expr[] andGroupByAttr = new Expr[numberOfTuples];
		Expr[] andForIfthenelse = new Expr[numberOfTuples];
		Expr[] isNullExprs = new Expr[numberOfTuples];
		Expr[] isRowValidExprs = new Expr[numberOfTuples];
		for (int i = 0; i < numberOfTuples; i++) {
			isRowValidExprs[i] = selectCol(cvc, arrNameBQ, attrNamesBQArrayList.size() - 1, i + 1);
			isRowValidExprs[i] = ctx.mkGt(isRowValidExprs[i], ctx.mkInt(0));
		}
		for (int p = 0; p < numberOfTuples; p++) {
			int s;

			for (s = 0; s < numberOfGroupByColumns; s++) {
				colValueBQ[s][p] = smtMap(arrNameBQ, "i", p + 1, attrNamesBQArrayList.indexOf(groupby_column.get(s)));
				if (groupByNodes.get(s).getIsMutant())
					calculateAggregate[p][s] = (BoolExpr) ctx.mkTrue();
				// calculateAggregate[p][s] = ctx.mkNot((BoolExpr) ctx.mkEq(colValueSQ[s],
				// colValueBQ[s][p]));
				else
					calculateAggregate[p][s] = (BoolExpr) ctx.mkEq(colValueSQ[s], colValueBQ[s][p]);
			}

			colValueBQ[s][p] = smtMap(arrNameBQ, "i", p + 1,
					attrNamesBQArrayList.indexOf(agg_column_name.get(indexOfProjectedNode)));
			String dataType = cvc.getTableMap().getSQTableByName(arrNameBQ.split("_")[1])
					.getColumn(agg_column_name.get(indexOfProjectedNode)).getCvcDatatype();
			String functionName = dataType;

			Vector<Column> aggColumns = prDs.getProjectedNodes().get(indexOfProjectedNode).getAgg().getAggColumns();

			if (aggColumns.size() <= 1) {
				if (dataType.equalsIgnoreCase("int") || dataType.equalsIgnoreCase("real")) {
					isNullExprs[p] = ctx.mkNot(
							ctxFuncDecls
									.get("CHECKALL_NULL" + (dataType.equalsIgnoreCase("Int") ? "Int" : "Real"))
									.apply(colValueBQ[s][p]));
				} else {
					isNullExprs[p] = ctx.mkNot(
							ctxFuncDecls
									.get("ISNULL_" + functionName)
									.apply(colValueBQ[s][p]));
				}
			} else {
				isNullExprs[p] = ctx.mkTrue();
			}

			andGroupByAttr[p] = ctx.mkAnd(calculateAggregate[p]);
			andForIfthenelse[p] = ctx.mkAnd(andGroupByAttr[p], isNullExprs[p], isRowValidExprs[p]);

			selectCntBQ = smtMap(arrNameBQ, "i1", p + 1, cntColumnBQIndex);
			// ctxFuncDecls.get("ISNULL_" + )
			String aggAttr = tempColumnName;

			if (agg_column_isDictinct.get(aggAttr))
				ifthenelseExpr[p] = ctx.mkITE((BoolExpr) andForIfthenelse[p], ctx.mkInt(1), ctx.mkInt(0));
			else
				ifthenelseExpr[p] = ctx.mkITE((BoolExpr) andForIfthenelse[p], selectCntBQ, ctx.mkInt(0));
			multieExpr[p][0] = (ArithExpr) ifthenelseExpr[p];
			addExpr[p] = (ArithExpr) ifthenelseExpr[p];
		}
		Expr additionexpr1;
		if (agg_column_isDictinct.get(tempColumnName) && numberOfGroupByColumns > 0) {
			additionexpr1 = ctx.mkITE(ctx.mkOr(andForIfthenelse), ctx.mkInt(1), ctx.mkInt(0));
		} else {
			additionexpr1 = ctx.mkAdd(addExpr);
		}
		Expr eqexpr2 = ctx.mkEq((IntExpr) colValueSQ1, additionexpr1);
		Expr orExprGetAggValFinal = ctx.mkOr((BoolExpr) eqexpr2,
				(BoolExpr) ctx.mkEq((ArithExpr) smtMap(arrNameSQ, "i", -1, attrNamesSQ.size() - 1), ctx.mkInt(0)));

		return orExprGetAggValFinal;
	}

	private static Expr getAggConstrintsForMINMAX(GenerateCVC1 cvc, AggregateDataStructure aggDs, GroupByNodesData gbDs,
			ProjectedNodesData prDs, int indexOfProjectedNode,
			int numberOfTuples, int cntColumnBQIndex, String minOrMax) {

		int numberOfGroupByColumns = gbDs.noOfGroupByColumns;
		String subquery_table_name = aggDs.subqueryTableName;
		String arrNameSQ = aggDs.arrayNameOfSQInCtx;
		String arrNameBQ = aggDs.arrayNameOfBQInCtx;
		Vector<Integer> indexOfProjectedColmnsInSQ = prDs.indexOfProjectedColmnsInSQ;
		Vector<String> attrNamesBQArrayList = aggDs.attrNamesBQ;
		Vector<String> agg_column_name = new Vector<String>();
		for (Column c : prDs.aggregateColumnsFromJSQ) {
			agg_column_name.add(c.getColumnName());
		}
		Vector<String> attrNamesSQ = aggDs.attrColumnsOfSQ;
		Vector<String> groupby_column = new Vector<String>();
		Vector<Sort> attrTypesSQ = aggDs.attrTypesOfSQ;
		HashMap<String, Boolean> agg_column_isDictinct = aggDs.isColumnDistinctInSQ;

		ArrayList<Node> groupByNodes = gbDs.groupByNodes;

		for (Column c : gbDs.groupByColumnsFromJSQ) {
			groupby_column.add(c.getColumnName());
		}

		Expr selectCntBQ;
		Expr[] colValueSQ = new Expr[numberOfGroupByColumns + 1];

		for (int s = 0; s < numberOfGroupByColumns; s++) {
			colValueSQ[s] = smtMap(arrNameSQ, "i", -1, s);
		}

		Expr colValueSQ1 = smtMap(arrNameSQ, "i", -1, indexOfProjectedColmnsInSQ.get(indexOfProjectedNode));
		Expr[][] colValueBQ = new Expr[numberOfGroupByColumns + 1][numberOfTuples];
		BoolExpr[][] calculateAggregate = new BoolExpr[numberOfTuples][numberOfGroupByColumns];
		Expr[] andEqualsConditions = new Expr[numberOfTuples];
		Expr[] andGTEqualsConditions = new Expr[numberOfTuples];
		Expr[] andIsNullExprs = new Expr[numberOfTuples];
		Expr[] isNullExprs = new Expr[numberOfTuples];

		ArithExpr[] addExpr = new ArithExpr[numberOfTuples];
		Expr[] andOfGBAttrs = new Expr[numberOfTuples];
		Expr[] impliesExprForEquals = new Expr[numberOfTuples];
		String functionName = "", dataType = "";

		for (int p = 0; p < numberOfTuples; p++) {
			int s;
			for (s = 0; s < numberOfGroupByColumns; s++) {
				colValueBQ[s][p] = smtMap(arrNameBQ, "i", p + 1, attrNamesBQArrayList.indexOf(groupby_column.get(s)));
				if (groupByNodes.get(s).getIsMutant())
					calculateAggregate[p][s] = (BoolExpr) ctx.mkTrue();
				else
					calculateAggregate[p][s] = (BoolExpr) ctx.mkEq(colValueSQ[s], colValueBQ[s][p]);
			}
			colValueBQ[s][p] = smtMap(arrNameBQ, "i", p + 1,
					attrNamesBQArrayList.indexOf(agg_column_name.get(indexOfProjectedNode)));
			dataType = cvc.getTableMap().getSQTableByName(arrNameBQ.split("_")[1])
					.getColumn(agg_column_name.get(indexOfProjectedNode)).getCvcDatatype();
			functionName = dataType;
			// chaitra changed here for date - if datatype is date, function name is by the
			// column name
			if (dataType.equalsIgnoreCase("DATE"))
				functionName = cvc.getTableMap()
						.getSQTableByName(arrNameBQ.split("_")[1])
						.getColumn(agg_column_name
								.get(indexOfProjectedNode))
						.getColumnName()
						.replaceAll(".*__", "").replaceAll("\\d+$", "");

			if (dataType.equalsIgnoreCase("int") || dataType.equalsIgnoreCase("real")) {
				isNullExprs[p] = ctx.mkNot(
						ctxFuncDecls
								.get("CHECKALL_NULL" + (dataType.equalsIgnoreCase("Int") ? "Int" : "Real"))
								.apply(colValueBQ[s][p]));
			} else {
				isNullExprs[p] = ctx.mkNot(ctxFuncDecls
						.get("ISNULL_" + functionName)
						.apply(colValueBQ[s][p]));
			}

			andOfGBAttrs[p] = ctx.mkAnd(calculateAggregate[p]);
			impliesExprForEquals[p] = ctx.mkImplies(andOfGBAttrs[p], isNullExprs[p]);

			selectCntBQ = smtMap(arrNameBQ, "i1", p + 1, cntColumnBQIndex);

			// FIXED: Changed ctx.mkNot(isNullExprs[p]) to isNullExprs[p]
			andEqualsConditions[p] = ctx.mkAnd(ctx.mkAnd(isNullExprs[p], andOfGBAttrs[p],
					ctx.mkGe(selectCntBQ, ctx.mkInt(1))),
					ctx.mkAnd(ctx.mkEq(colValueSQ1, colValueBQ[numberOfGroupByColumns][p])));

			// FIXED: Changed ctx.mkNot(isNullExprs[p]) to isNullExprs[p]
			if (minOrMax.equalsIgnoreCase("MIN")) {
				if (dataType.equalsIgnoreCase("int") || dataType.equalsIgnoreCase("real"))
					andGTEqualsConditions[p] = ctx.mkImplies(ctx.mkAnd(andOfGBAttrs[p], isNullExprs[p]),
							ctx.mkLe(colValueSQ1, colValueBQ[numberOfGroupByColumns][p]));
				else if (dataType.equalsIgnoreCase("date"))
					andGTEqualsConditions[p] = ctx.mkImplies(ctx.mkAnd(andOfGBAttrs[p], isNullExprs[p]),
							ctx.mkOr(
									ctx.mkApp(ctxFuncDecls.get("eqDATE"), colValueSQ1,
											colValueBQ[numberOfGroupByColumns][p]),
									ctx.mkApp(ctxFuncDecls.get("ltDATE"), colValueSQ1,
											colValueBQ[numberOfGroupByColumns][p])));
				else
					andGTEqualsConditions[p] = ctx.mkImplies(ctx.mkAnd(andOfGBAttrs[p], isNullExprs[p]),
							ctx.mkOr(
									ctx.mkApp(ctxFuncDecls.get("eq" + dataType), colValueSQ1,
											colValueBQ[numberOfGroupByColumns][p]),
									ctx.mkApp(ctxFuncDecls.get("lt" + dataType), colValueSQ1,
											colValueBQ[numberOfGroupByColumns][p])));
			} else {
				andGTEqualsConditions[p] = ctx.mkImplies(ctx.mkAnd(andOfGBAttrs[p], isNullExprs[p]),
						ctx.mkGe(colValueSQ1, colValueBQ[numberOfGroupByColumns][p]));
			}
		}

		Expr thenExpr;

		if (dataType.equalsIgnoreCase("int") || dataType.equalsIgnoreCase("real")) {
			thenExpr = ctx.mkNot(
					ctxFuncDecls
							.get("CHECKALL_NULL" + (dataType.equalsIgnoreCase("Int") ? "Int" : "Real"))
							.apply(colValueSQ1));
		} else {
			thenExpr = ctx.mkNot(
					ctxFuncDecls
							.get("ISNULL_" + functionName)
							.apply(colValueSQ1));
		}

		Expr andOfImplies = ctx.mkAnd(impliesExprForEquals);

		Expr firstAnd = ctx.mkAnd(ctx.mkOr(andEqualsConditions), ctx.mkAnd(andGTEqualsConditions));
		Expr elseExpr = ctx.mkOr(firstAnd,
				ctx.mkEq((ArithExpr) smtMap(arrNameSQ, "i", -1, attrNamesSQ.size() - 1), ctx.mkInt(0)));

		// FIXED: Changed from mkITE to mkAnd
		return ctx.mkAnd(elseExpr, ctx.mkImplies(andOfImplies, thenExpr));
	}

	private static String getAggregateConstraintsWithCount(GenerateCVC1 cvc, Node n, String SQTableName,
			Vector<String> attrNamesSQ, Vector<Sort> attrTypesSQ, HashMap<String, Integer> AggColIndexMap, int i) {
		Expr SQColumnSQi1;
		if (n.getLeft() == null && n.getRight() == null) {
			return "";
		}

		else if (n.getRight() != null && n.getLeft().getType().equalsIgnoreCase("VALUE")) {
			// generate constraints
			// System.out.println(n.getRight().getAgg().getAggExp().getAggFuncFromNode().getFunc());
			String columnName = n.getRight().getAgg().getAggExp().getColumn().getColumnName();
			String AggColInSQTable = n.getRight().getAgg().getFunc()
					+ n.getRight().getAgg().getAggExp().getColumn().getColumnName();

			String aggFun = n.getRight().getAgg().getFunc();
			String columnNameFromBaseTable = n.getRight().getAgg().getAggExp().getColumn().getColumnName();
			String baseTableOfAgg = n.getRight().getAgg().getAggExp().getColumn().getTableName();

			String colN = getColumnNameForGSQ(SQTableName, baseTableOfAgg, aggFun, columnNameFromBaseTable);

			int index = AggColIndexMap.get(colN);
			SQColumnSQi1 = ConstraintGenerator.genSelectTest(cvc, SQTableName, index, i);
			String datatype = cvc.getTableMap().getSQTableByName(SQTableName).getColumn(colN).getCvcDatatype();
			Expr isNotNulli;
			if (datatype.equalsIgnoreCase("int") || datatype.equalsIgnoreCase("real")) {
				isNotNulli = ctx.mkNot(
						ctxFuncDecls
								.get("CHECKALL_NULL" + (datatype.equalsIgnoreCase("Int") ? "Int" : "Real"))
								.apply(SQColumnSQi1));
			} else {
				isNotNulli = ctx.mkNot(
						ctxFuncDecls
								.get("ISNULL_" + datatype)
								.apply(SQColumnSQi1));
			}

			return ctx.mkAnd(getComparisionConstraintsForOperator(n.getOperator(),
					ctx.mkInt(n.getRight().getStrConst()), SQColumnSQi1), isNotNulli).toString();

		}

		else if (n.getLeft() != null && n.getRight().getType().equalsIgnoreCase("VALUE")) {
			// generate constraints
			String columnName = n.getLeft().getAgg().getAggExp().getColumn().getColumnName();
			String AggColInSQTable = "";

			String aggFun = n.getLeft().getAgg().getFunc();
			String columnNameFromBaseTable = n.getLeft().getAgg().getAggExp().getColumn().getColumnName();
			String baseTableOfAgg = n.getLeft().getAgg().getAggExp().getColumn().getTableName();
			String colN = getColumnNameForGSQ(SQTableName, baseTableOfAgg, aggFun, columnNameFromBaseTable);

			int index = AggColIndexMap.get(colN);
			SQColumnSQi1 = ConstraintGenerator.genSelectTest(cvc, SQTableName, index, i);

			String datatype = cvc.getTableMap().getSQTableByName(SQTableName).getColumn(colN).getCvcDatatype();
			// n.getLeft().getAgg().getAggExp().getColumn().getCvcDatatype();
			Expr isNotNulli;
			if (datatype.equalsIgnoreCase("int") || datatype.equalsIgnoreCase("real")) {
				isNotNulli = ctx.mkNot(
						ctxFuncDecls
								.get("CHECKALL_NULL" + (datatype.equalsIgnoreCase("Int") ? "Int" : "Real"))
								.apply(SQColumnSQi1));
			} else {
				isNotNulli = ctx.mkNot(
						ctxFuncDecls
								.get("ISNULL_" + datatype)
								.apply(SQColumnSQi1));
			}

			return ctx.mkAnd(getComparisionConstraintsForOperator(n.getOperator(), SQColumnSQi1,
					ctx.mkInt(n.getRight().getStrConst())), isNotNulli).toString();

		}

		else if (n.getRight() != null && n.getLeft() != null && n.getType().equalsIgnoreCase("AGGREGATE NODE")) {
			// generate constraints
			Column columnName1 = n.getLeft().getAgg().getAggExp().getColumn();
			Column columnName2 = n.getRight().getAgg().getAggExp().getColumn();
			String AggFun1 = n.getLeft().getAgg().getFunc();
			String AggFun2 = n.getRight().getAgg().getFunc();

			String colN1 = getColumnNameForGSQ(SQTableName, columnName1.getTableName(), AggFun1,
					columnName1.getColumnName());
			String colN2 = getColumnNameForGSQ(SQTableName, columnName2.getTableName(), AggFun2,
					columnName2.getColumnName());

			int index1 = AggColIndexMap.get(colN1);

			int index2 = AggColIndexMap.get(colN2);

			SQColumnSQi1 = ConstraintGenerator.genSelectTest2(cvc, SQTableName, index1, "i1");
			Expr SQColumnSQi2 = ConstraintGenerator.genSelectTest2(cvc, SQTableName, index2, "i1");

			String datatype1 = cvc.getTableMap().getSQTableByName(SQTableName).getColumn(colN1).getCvcDatatype();
			String datatype2 = cvc.getTableMap().getSQTableByName(SQTableName).getColumn(colN2).getCvcDatatype();

			Expr isNotNulli1;
			Expr isNotNulli2;

			if (datatype1.equalsIgnoreCase("int") || datatype1.equalsIgnoreCase("real")) {
				isNotNulli1 = ctx.mkNot(
						ctxFuncDecls
								.get("CHECKALL_NULL" + (datatype1.equalsIgnoreCase("Int") ? "Int" : "Real"))
								.apply(SQColumnSQi1));
			} else {
				isNotNulli1 = ctx.mkNot(
						ctxFuncDecls
								.get("ISNULL_" + datatype1)
								.apply(SQColumnSQi1));
			}
			if (datatype2.equalsIgnoreCase("int") || datatype2.equalsIgnoreCase("real")) {
				isNotNulli2 = ctx.mkNot(
						ctxFuncDecls
								.get("CHECKALL_NULL" + (datatype2.equalsIgnoreCase("Int") ? "Int" : "Real"))
								.apply(SQColumnSQi2));
			} else {
				isNotNulli2 = ctx.mkNot(
						ctxFuncDecls
								.get("ISNULL_" + datatype2)
								.apply(SQColumnSQi2));
			}

			return ctx.mkAnd(getComparisionConstraintsForOperator(n.getOperator(), SQColumnSQi1, SQColumnSQi2),
					isNotNulli1, isNotNulli2).toString();

		} else {
			getAggregateConstraintsWithCount(cvc, n.getLeft(), SQTableName, attrNamesSQ, attrTypesSQ, AggColIndexMap,
					i);
			getAggregateConstraintsWithCount(cvc, n.getRight(), SQTableName, attrNamesSQ, attrTypesSQ, AggColIndexMap,
					i);
		}
		return "";

	}
	private static String getAggregateConstraintsWithCount(GenerateCVC1 cvc, Node n, String SQTableName,
			Vector<String> attrNamesSQ, Vector<Sort> attrTypesSQ, HashMap<String, Integer> AggColIndexMap, String i) {
		Expr SQColumnSQi1;
		if (n.getLeft() == null && n.getRight() == null) {
			return "";
		}
		else if(n.getLeft() != null && n.getRight().getType().equalsIgnoreCase("VALUE") && n.getLeft().getAgg()==null){
			String columnName = n.getLeft().getColumn().getColumnName(),tableName=n.getLeft().getTable().toString(),colN="";
			int index=-1;
			for(int k=0;k<attrNamesSQ.size();k++){
				if(attrNamesSQ.get(k).contains(columnName) && attrNamesSQ.get(k).contains(tableName)){
					colN=attrNamesSQ.get(k);
					index=k;
					break;
				}
			}
			SQColumnSQi1 = ConstraintGenerator.genSelectTest2(cvc, SQTableName, index, i);

			String datatype = cvc.getTableMap().getSQTableByName(SQTableName).getColumn(colN).getCvcDatatype();
			// n.getLeft().getAgg().getAggExp().getColumn().getCvcDatatype();
			Expr isNotNulli;
			if (datatype.equalsIgnoreCase("int") || datatype.equalsIgnoreCase("real")) {
				isNotNulli = ctx.mkNot(
						ctxFuncDecls
								.get("CHECKALL_NULL" + (datatype.equalsIgnoreCase("Int") ? "Int" : "Real"))
								.apply(SQColumnSQi1));
			} else {
				isNotNulli = ctx.mkNot(
						ctxFuncDecls
								.get("ISNULL_" + datatype)
								.apply(SQColumnSQi1));
			}

			return ctx.mkAnd(getComparisionConstraintsForOperator(n.getOperator(), SQColumnSQi1,
					ctx.mkInt(n.getRight().getStrConst())), isNotNulli).toString();

			
		}
		else if (n.getRight() != null && n.getLeft().getType().equalsIgnoreCase("VALUE")) {
			// generate constraints
			// System.out.println(n.getRight().getAgg().getAggExp().getAggFuncFromNode().getFunc());
			String columnName = n.getRight().getAgg().getAggExp().getColumn().getColumnName();
			String AggColInSQTable = n.getRight().getAgg().getFunc()
					+ n.getRight().getAgg().getAggExp().getColumn().getColumnName();

			String aggFun = n.getRight().getAgg().getFunc();
			String columnNameFromBaseTable = n.getRight().getAgg().getAggExp().getColumn().getColumnName();
			String baseTableOfAgg = n.getRight().getAgg().getAggExp().getColumn().getTableName();

			String colN = getColumnNameForGSQ(SQTableName, baseTableOfAgg, aggFun, columnNameFromBaseTable);

			int index = AggColIndexMap.get(colN);
			SQColumnSQi1 = ConstraintGenerator.genSelectTest2(cvc, SQTableName, index, i);
			String datatype = cvc.getTableMap().getSQTableByName(SQTableName).getColumn(colN).getCvcDatatype();
			Expr isNotNulli;
			if (datatype.equalsIgnoreCase("int") || datatype.equalsIgnoreCase("real")) {
				isNotNulli = ctx.mkNot(
						ctxFuncDecls
								.get("CHECKALL_NULL" + (datatype.equalsIgnoreCase("Int") ? "Int" : "Real"))
								.apply(SQColumnSQi1));
			} else {
				isNotNulli = ctx.mkNot(
						ctxFuncDecls
								.get("ISNULL_" + datatype)
								.apply(SQColumnSQi1));
			}

			return ctx.mkAnd(getComparisionConstraintsForOperator(n.getOperator(),
					ctx.mkInt(n.getRight().getStrConst()), SQColumnSQi1), isNotNulli).toString();

		}

		else if (n.getLeft() != null && n.getRight().getType().equalsIgnoreCase("VALUE")) {
			// generate constraints
			String columnName = n.getLeft().getAgg().getAggExp().getColumn().getColumnName();
			String AggColInSQTable = "";

			String aggFun = n.getLeft().getAgg().getFunc();
			String columnNameFromBaseTable = n.getLeft().getAgg().getAggExp().getColumn().getColumnName();
			String baseTableOfAgg = n.getLeft().getAgg().getAggExp().getColumn().getTableName();
			String colN = getColumnNameForGSQ(SQTableName, baseTableOfAgg, aggFun, columnNameFromBaseTable);

			int index = AggColIndexMap.get(colN);
			SQColumnSQi1 = ConstraintGenerator.genSelectTest2(cvc, SQTableName, index, i);

			String datatype = cvc.getTableMap().getSQTableByName(SQTableName).getColumn(colN).getCvcDatatype();
			// n.getLeft().getAgg().getAggExp().getColumn().getCvcDatatype();
			Expr isNotNulli;
			if (datatype.equalsIgnoreCase("int") || datatype.equalsIgnoreCase("real")) {
				isNotNulli = ctx.mkNot(
						ctxFuncDecls
								.get("CHECKALL_NULL" + (datatype.equalsIgnoreCase("Int") ? "Int" : "Real"))
								.apply(SQColumnSQi1));
			} else {
				isNotNulli = ctx.mkNot(
						ctxFuncDecls
								.get("ISNULL_" + datatype)
								.apply(SQColumnSQi1));
			}

			return ctx.mkAnd(getComparisionConstraintsForOperator(n.getOperator(), SQColumnSQi1,
					ctx.mkInt(n.getRight().getStrConst())), isNotNulli).toString();

		}

		else if (n.getRight() != null && n.getLeft() != null && n.getType().equalsIgnoreCase("AGGREGATE NODE")) {
			// generate constraints
			Column columnName1 = n.getLeft().getAgg().getAggExp().getColumn();
			Column columnName2 = n.getRight().getAgg().getAggExp().getColumn();
			String AggFun1 = n.getLeft().getAgg().getFunc();
			String AggFun2 = n.getRight().getAgg().getFunc();

			String colN1 = getColumnNameForGSQ(SQTableName, columnName1.getTableName(), AggFun1,
					columnName1.getColumnName());
			String colN2 = getColumnNameForGSQ(SQTableName, columnName2.getTableName(), AggFun2,
					columnName2.getColumnName());

			int index1 = AggColIndexMap.get(colN1);

			int index2 = AggColIndexMap.get(colN2);

			SQColumnSQi1 = ConstraintGenerator.genSelectTest2(cvc, SQTableName, index1, "i1");
			Expr SQColumnSQi2 = ConstraintGenerator.genSelectTest2(cvc, SQTableName, index2, "i1");

			String datatype1 = cvc.getTableMap().getSQTableByName(SQTableName).getColumn(colN1).getCvcDatatype();
			String datatype2 = cvc.getTableMap().getSQTableByName(SQTableName).getColumn(colN2).getCvcDatatype();

			Expr isNotNulli1;
			Expr isNotNulli2;

			if (datatype1.equalsIgnoreCase("int") || datatype1.equalsIgnoreCase("real")) {
				isNotNulli1 = ctx.mkNot(
						ctxFuncDecls
								.get("CHECKALL_NULL" + (datatype1.equalsIgnoreCase("Int") ? "Int" : "Real"))
								.apply(SQColumnSQi1));
			} else {
				isNotNulli1 = ctx.mkNot(
						ctxFuncDecls
								.get("ISNULL_" + datatype1)
								.apply(SQColumnSQi1));
			}
			if (datatype2.equalsIgnoreCase("int") || datatype2.equalsIgnoreCase("real")) {
				isNotNulli2 = ctx.mkNot(
						ctxFuncDecls
								.get("CHECKALL_NULL" + (datatype2.equalsIgnoreCase("Int") ? "Int" : "Real"))
								.apply(SQColumnSQi2));
			} else {
				isNotNulli2 = ctx.mkNot(
						ctxFuncDecls
								.get("ISNULL_" + datatype2)
								.apply(SQColumnSQi2));
			}

			return ctx.mkAnd(getComparisionConstraintsForOperator(n.getOperator(), SQColumnSQi1, SQColumnSQi2),
					isNotNulli1, isNotNulli2).toString();

		} else {
			getAggregateConstraintsWithCount(cvc, n.getLeft(), SQTableName, attrNamesSQ, attrTypesSQ, AggColIndexMap,
					i);
			getAggregateConstraintsWithCount(cvc, n.getRight(), SQTableName, attrNamesSQ, attrTypesSQ, AggColIndexMap,
					i);
		}
		return "";

	}

	public static String getColumnNameForGSQ(String sQTableName, String baseTableOfAgg, String aggFun,
			String columnNameFromBaseTable) {
		// TODO Auto-generated method stub
		return sQTableName + "_" + aggFun + baseTableOfAgg + "__" + columnNameFromBaseTable;

	}

	// chaitra added function to get column name for JSQ
	public static String getColumnNameForJSQ(GenerateCVC1 cvc, String joinTableName, String baseTableName,
			String baseTableColumn) {
		Table joinTable = cvc.getTableMap().getSQTableByName(joinTableName);
		Table baseTable = cvc.getTableMap().getTable(baseTableName.toUpperCase());
		int baseTableColIndex = baseTable.getColumnIndex(baseTableColumn);
		String baseTableAndColName = baseTableName + "__" + baseTableColumn + Integer.toString(baseTableColIndex);

		for (String colname : joinTable.getColumns().keySet()) {
			if (colname.contains(baseTableAndColName))
				return colname;
		}
		return "";
	}
	// chaitra added function to get column name for JSQ

	// chaitra changed this function to public

	public static Expr getComparisionConstraintsForOperator(String operator, Expr left, Expr right) {
		Sort leftSort = left.getSort();
		String sortName = leftSort.getName().toString();
		boolean isCustomSort = !(sortName.equalsIgnoreCase("Int") || sortName.equalsIgnoreCase("Real"));

		if (operator.equalsIgnoreCase("="))
			return ctx.mkEq(left, right);
		if (operator.equalsIgnoreCase("/="))
			return ctx.mkNot(ctx.mkEq(left, right));

		if (isCustomSort) {
			if (operator.equalsIgnoreCase(">")) {
				String funcName = "gt" + sortName;
				FuncDecl gtFunc = ctxFuncDecls.get(funcName);
				if (gtFunc == null) {
					gtFunc = ctx.mkFuncDecl(funcName, new Sort[] { leftSort, leftSort }, ctx.mkBoolSort());
					ctxFuncDecls.put(funcName, gtFunc);
				}
				return gtFunc.apply(left, right);
			}
			if (operator.equalsIgnoreCase("<")) {
				String funcName = "lt" + sortName;
				FuncDecl ltFunc = ctxFuncDecls.get(funcName);
				if (ltFunc == null) {
					ltFunc = ctx.mkFuncDecl(funcName, new Sort[] { leftSort, leftSort }, ctx.mkBoolSort());
					ctxFuncDecls.put(funcName, ltFunc);
				}
				return ltFunc.apply(left, right);
			}
			if (operator.equalsIgnoreCase(">=")) {
				String funcName = "gt" + sortName;
				FuncDecl gtFunc = ctxFuncDecls.get(funcName);
				if (gtFunc == null) {
					gtFunc = ctx.mkFuncDecl(funcName, new Sort[] { leftSort, leftSort }, ctx.mkBoolSort());
					ctxFuncDecls.put(funcName, gtFunc);
				}
				return ctx.mkOr((BoolExpr) gtFunc.apply(left, right), ctx.mkEq(left, right));
			}
			if (operator.equalsIgnoreCase("<=")) {
				String funcName = "lt" + sortName;
				FuncDecl ltFunc = ctxFuncDecls.get(funcName);
				if (ltFunc == null) {
					ltFunc = ctx.mkFuncDecl(funcName, new Sort[] { leftSort, leftSort }, ctx.mkBoolSort());
					ctxFuncDecls.put(funcName, ltFunc);
				}
				return ctx.mkOr((BoolExpr) ltFunc.apply(left, right), ctx.mkEq(left, right));
			}
			return null;
		}

		if (operator.equalsIgnoreCase("<"))
			return ctx.mkLt((ArithExpr) left, (ArithExpr) right);
		if (operator.equalsIgnoreCase(">"))
			return ctx.mkGt((ArithExpr) left, (ArithExpr) right);
		if (operator.equalsIgnoreCase(">="))
			return ctx.mkGe((ArithExpr) left, (ArithExpr) right);
		if (operator.equalsIgnoreCase("<="))
			return ctx.mkLe((ArithExpr) left, (ArithExpr) right);

		return null;
		// throw new UnsupportedOperationException("Unimplemented method
		// 'getComparisionConstraintsForOperator'");
	}

	// chaitra added function to get enum type comparisons
	public static Expr getComparisionConstraintsForOperatorEnum(String enumType, String operator, Expr left,
			Expr right) {
		EnumSort colSort = (EnumSort) ctxSorts.get(enumType);
		String op = "";
		if (operator.equalsIgnoreCase(">") || operator.equalsIgnoreCase("gt"))
			op = "gt";
		else if (operator.equalsIgnoreCase("<") || operator.equalsIgnoreCase("lt"))
			op = "lt";
		String compFuncName = op + enumType;
		Expr compExpr = ctx.mkApp(ctxFuncDecls.get(compFuncName), left, right);
		return compExpr;
	}
	// chaitra added function to get enum type comparisons end

	// chaitra added function to make arithmetic expressions
	public static Expr getArithmeticConstraintsForOperator(String operator, Expr left, Expr right) {
		if (operator.equalsIgnoreCase("+")) {
			if (left instanceof IntExpr && right instanceof RealExpr) {
				left = ctx.mkInt2Real((IntExpr) left);
			} else if (left instanceof RealExpr && right instanceof IntExpr) {
				right = ctx.mkInt2Real((IntExpr) right);
			}
			return ctx.mkAdd((ArithExpr) left, (ArithExpr) right);
		}
		if (operator.equalsIgnoreCase("-"))
			return ctx.mkSub((ArithExpr) left, (ArithExpr) right);
		if (operator.equalsIgnoreCase("*"))
			return ctx.mkMul((ArithExpr) left, (ArithExpr) right);
		if (operator.equalsIgnoreCase("/"))
			return ctx.mkDiv((ArithExpr) left, (ArithExpr) right);
		return null;
		// throw new UnsupportedOperationException("Unimplemented method
		// 'getComparisionConstraintsForOperator'");
	}
	// chaitra added function to make arithmetic expressions

	/**
	 * Handle CAST expressions with type conversion
	 * Supports: CAST(INT AS REAL), CAST(REAL AS INT)
	 * 
	 * @param castType - Target data type (INT or REAL)
	 * @param expr     - Expression to cast
	 * @return Converted Z3 expression
	 */
	public static Expr handleCastExpression(String castType, Expr expr) {
		if (castType == null || expr == null)
			return expr;

		castType = castType.toUpperCase().trim();

		// INT -> REAL conversion
		if ((castType.contains("REAL") || castType.contains("NUMERIC") || castType.contains("DECIMAL"))
				&& expr instanceof IntExpr) {
			return ctx.mkInt2Real((IntExpr) expr);
		}

		// REAL -> INT conversion (truncation)
		if ((castType.contains("INT") || castType.contains("INTEGER")) && expr instanceof RealExpr) {
			return ctx.mkReal2Int((RealExpr) expr);
		}

		// No conversion needed or unsupported cast -> return original
		return expr;
	}

	// chaitra add function to make a constant
	public static Object mkConstOfType(String constStr, Column col) {
		Expr result = null;

		try {
			Integer.parseInt(constStr);
			result = ctx.mkInt(constStr);
			return result;
		} catch (NumberFormatException ignored) {
		}

		try {
			String[] parts = constStr.split("/");
			double num = Double.parseDouble(parts[0]);
			double den = Double.parseDouble(parts[1]);
			double temp = num / den;
			result = ctx.mkReal(Double.toString(temp));
			return result;
		} catch (NumberFormatException ignored) {
		}

		// result = ctx.mkConst(constStr, ctxSorts.get(colName));
		if (col.getCvcDatatype().equalsIgnoreCase("STRING")) {
			result = ctx.mkString(constStr);
		} else {
			result = ctx.mkConst(constStr, ctxSorts.get(col.getColumnName()));
		}

		return result;
	}
	// chaitra add function to make a constant end

	/**
	 * 
	 * @param str
	 * @return
	 */
	public StringConstraint getStringConstraint(String str) {

		StringConstraint s = null;
		if (isCVC3) {
			s = new StringConstraint(str.substring(str.indexOf("(") + 1, str.lastIndexOf(")"))); // removing brackets
		} else {
			s = new StringConstraint(str.substring(str.indexOf(" (") + 1, str.lastIndexOf(")"))); // removing brackets
			s = new StringConstraint(str.substring(str.indexOf(" (") + 1, str.lastIndexOf(")")));
		}
		return s;
	}

	/**
	 * 
	 * @param var
	 * @return
	 */
	public String getTableName(String var) {

		String table = "";
		String tableName = "";

		if (isCVC3) {
			table = (var.split("\\["))[0];
			tableName = table.split("O_")[1];

		} else {
			tableName = var.substring(0, var.indexOf("_"));
		}
		return tableName;
	}

	/**
	 * 
	 * @param var
	 * @return
	 */
	public int getColumnIndex(String var) {

		int columnIndex = 0;
		if (isCVC3) {
			columnIndex = Integer.parseInt((var.split("\\."))[1]);
		} else {
			String newStr = var.substring(0, var.indexOf(" (select "));
			columnIndex = Integer.parseInt(newStr.substring(newStr.length() - 1, newStr.length()));

		}
		return columnIndex;
	}

	/**
	 * 
	 * @param commentLine
	 * @return
	 */
	public static String addCommentLine(String commentLine) {
		return "\n\n" + solverSpecificCommentCharacter
				+ "------------------------------------------------------------\n"
				+ solverSpecificCommentCharacter + commentLine +
				"\n" + solverSpecificCommentCharacter
				+ "------------------------------------------------------------\n";
	}

	public String getConstraintSolver() {
		return constraintSolver;
	}

	public void setConstraintSolver(String constraintSolver) {
		this.constraintSolver = constraintSolver;
	}

	/**
	 * 
	 * @param queryBlock
	 * @param vn
	 * @param c
	 * @param countVal
	 * @return
	 */
	public static String generateCVCForCNTForPositiveINT(QueryBlockDetails queryBlock, ArrayList<Node> vn, Column c,
			int countVal) {
		String CVCStr = "";

		int min = 0, min1 = 0, max = 0, max1 = 0;
		CVCStr += "(set-option:produce-models true)\n (set-option :smt.macro_finder true) \n";
		CVCStr += "(declare-const SUM Int) \n (declare-const MIN Int) \n (declare-const MAX Int) \n (declare-const AVG Real) \n (declare-const COUNT Int) \n";
		CVCStr += "(declare-const CNT Real) \n (declare-const MIN1 Int) \n (declare-const MAX1 Int) \n\n";

		if (countVal == 0) {
			CVCStr += "(assert (< COUNT 32))\n";// 30 because CNT is always CNT+2 = 32 (max in CVC)
		} else {
			CVCStr += "(assert (= COUNT " + countVal + "))\n";
		}

		CVCStr += "\n\n(assert (<= MIN1 MIN)) \n ";
		CVCStr += "(assert (>= MAX1 MAX))\n";
		CVCStr += "(assert (> COUNT 0))\n";
		CVCStr += "(assert (<= MIN MAX))\n";
		CVCStr += "(assert (>= MAX1 AVG))\n";
		CVCStr += "(assert (>= AVG MIN1))\n";

		CVCStr += "(assert (>= SUM  (* MIN COUNT)))\n " +
				" (assert (<= SUM (* MAX COUNT)))\n";
		CVCStr += "(assert (= SUM (* AVG COUNT)))\n";

		DataType dt = new DataType();

		if ((dt.getDataType(c.getDataType()) == 1 || dt.getDataType(c.getDataType()) == 2) && c.getMinVal() != -1) {
			Vector<Node> selectionConds = new Vector<Node>();
			for (ConjunctQueryStructure conjunct : queryBlock.getConjunctsQs())
				selectionConds.addAll(conjunct.getSelectionConds());

			/** if there is a selection condition on c that limits the min val of c */
			min = (UtilsRelatedToNode.getMaxMinForIntCol(c, selectionConds))[1];
			CVCStr += "\n(assert (= MIN1 " + min + "))\n";
		}
		if ((dt.getDataType(c.getDataType()) == 1 || dt.getDataType(c.getDataType()) == 2) && c.getMaxVal() != -1) {

			Vector<Node> selectionConds = new Vector<Node>();
			for (ConjunctQueryStructure conjunct : queryBlock.getConjunctsQs())
				selectionConds.addAll(conjunct.getSelectionConds());

			/** if there is a selection condition on c that limits the max val of c */
			max = (UtilsRelatedToNode.getMaxMinForIntCol(c, selectionConds))[0];
			CVCStr += "\n(assert (= MAX1 " + max + "))\n";
		}
		for (String s : queryBlock.getParamMap().values()) {
			s = s.trim();
			if (s.contains("PARAM")) {
				CVCStr += "\n (declare-const " + s + " (_ BitVec 32))";
			}
		}

		for (Node n : vn) {
			if (n.getType().equalsIgnoreCase(Node.getAggrNodeType())
					|| n.getLeft().getType().equalsIgnoreCase(Node.getAggrNodeType())
					|| n.getRight().getNodeType().equalsIgnoreCase(Node.getAggrNodeType())) {
				AggregateFunction agg = null;
				if (n.getLeft().getType().equalsIgnoreCase(Node.getAggrNodeType()))
					agg = n.getLeft().getAgg();
				else
					agg = n.getRight().getAgg();

				if (agg.getAggExp().getLeft() != null
						&& agg.getAggExp().getLeft().getType().equalsIgnoreCase(Node.getBaoNodeType())) {

					if ((dt.getDataType(c.getDataType()) == 1 || dt.getDataType(c.getDataType()) == 2)
							&& c.getMinVal() != -1) {
						min1 = min + ((UtilsRelatedToNode.getMaxMinForHaving(c, agg.getAggExp()))[1]);
						CVCStr = CVCStr.replace("\n(assert (= MIN1 " + min + ")) \n",
								"\n (assert (= MIN1 " + min1 + "))\n");
					}
					if ((dt.getDataType(c.getDataType()) == 1 || dt.getDataType(c.getDataType()) == 2)
							&& c.getMaxVal() != -1) {
						max1 = max + ((UtilsRelatedToNode.getMaxMinForHaving(c, agg.getAggExp()))[0]);

						CVCStr = CVCStr.replace("\n(assert (= MAX1 " + max + "))\n",
								"\n(assert (= MAX1 " + max1 + "))\n");
					}

				} else if (agg.getAggExp().getRight() != null
						&& agg.getAggExp().getRight().getType().equalsIgnoreCase(Node.getBaoNodeType())) {
					// int constValue = this.getConstantVal(n);
					if ((dt.getDataType(c.getDataType()) == 1 || dt.getDataType(c.getDataType()) == 2)
							&& c.getMinVal() != -1) {
						min1 = min + ((UtilsRelatedToNode.getMaxMinForHaving(c, agg.getAggExp()))[1]);
						CVCStr = CVCStr.replace("\n(assert (= MIN1 " + min + "))\n",
								"\n(assert (= MIN1 " + min1 + "))\n");
					}
					if ((dt.getDataType(c.getDataType()) == 1 || dt.getDataType(c.getDataType()) == 2)
							&& c.getMaxVal() != -1) {

						max1 = max + ((UtilsRelatedToNode.getMaxMinForHaving(c, agg.getAggExp()))[0]);
						CVCStr = CVCStr.replace("\nassert (= MAX1 " + max + "))\n",
								"\n(assert (= MAX1 " + max1 + "))\n");
					}

				}
			}
			CVCStr += "\n(assert (" + n.toSMTString(10, queryBlock.getParamMap()) + "))";
		}

		CVCStr += "\n (check-sat) \n (get-value (SUM)) \n (get-value (MIN)) \n (get-value (MAX)) \n (get-value (AVG)) \n (get-value (COUNT))  \n (get-value (CNT))"
				+ "\n (get-value (MIN1)) \n (get-value (MAX1)) \n \n";
		return CVCStr;

	}

	/**
	 * 
	 * @param filePath
	 * @param cmdString
	 * @param cvc
	 */
	public static void getCountExeFile(String filePath, String cmdString, GenerateCVC1 cvc) {
		Runtime r = Runtime.getRuntime();
		cmdString = "";
		cmdString = "#!/bin/bash\n";

		if (isCVC3) {
			cmdString += Configuration.smtsolver + " " + Configuration.homeDir + "/temp_smt" + filePath
					+ "/getCount.cvc > " + Configuration.homeDir + "/temp_smt" + filePath + "/COUNTCVC \n";
			cmdString += Configuration.smtsolver + " " + Configuration.homeDir + "/temp_smt" + filePath
					+ "/getCount.cvc | grep -e 'Valid' > isNotValid \n";
			cmdString += "grep -e 'COUNT = ' " + Configuration.homeDir + "/temp_smt" + filePath + "/COUNTCVC"
					+ " | awk -F \" \" '{print $4}' | awk -F \")\" '{print $1}' > " + Configuration.homeDir
					+ "/temp_smt" + filePath + "/COUNT\n";
		} else {

			cmdString += Configuration.smtsolver + " " + Configuration.homeDir + "/temp_smt" + filePath
					+ "/getCount.smt > " + Configuration.homeDir + "/temp_smt" + filePath + "/COUNTCVC \n";
			cmdString += Configuration.smtsolver + " " + Configuration.homeDir + "/temp_smt" + filePath
					+ "/getCount.smt | grep -e 'unsat' > isNotValid \n";

			cmdString += "grep -e '((COUNT' " + Configuration.homeDir + "/temp_smt" + filePath + "/COUNTCVC"
					+ " | awk -F \" \" '{print $2}' | awk -F \")\" '{print $1}' > " + Configuration.homeDir
					+ "/temp_smt" + filePath + "/COUNT\n";
		}

		Utilities.writeFile(Configuration.homeDir + "/temp_smt" + cvc.getFilePath() + "/execCOUNT", cmdString);
	}

	/**
	 * 
	 * @param filePath
	 * @param cvc
	 */
	public static void getAggConstraintExeFile(String filePath, GenerateCVC1 cvc) {

		String cmdString = "";
		cmdString = "#!/bin/bash\n";
		if (isCVC3) {
			cmdString += Configuration.smtsolver + " " + Configuration.homeDir + "/temp_smt" + filePath
					+ "/checkAggConstraints.cvc | grep -e 'Invalid' > isValid \n";
		} else {
			cmdString += Configuration.smtsolver + " " + Configuration.homeDir + "/temp_smt" + filePath
					+ "/checkAggConstraints.smt | grep -e 'sat' > isValid \n";
			// cmdString += Configuration.smtsolver+" --lang smtlib "+
			// Configuration.homeDir+"/temp_smt" +filePath+ "/checkAggConstraints.cvc | grep
			// -e 'true' > isValid \n";
		}
		Utilities.writeFile(Configuration.homeDir + "/temp_smt" + cvc.getFilePath() + "/checkAggConstraints",
				cmdString);
	}

	public String getStrConstWithScale(String strConstant, Integer epsilon, String operator) {
		String strConst = "";

		strConst = "(" + operator + " " + strConstant + " (/ 1 " + epsilon + " )" + ")";

		return strConst;

	}

	public Vector<Quantifier> getDomainConstraintsforZ3(GenerateCVC1 cvc) {

		Vector<Quantifier> domainConstraints = new Vector<Quantifier>();

		int turn = 0;

		for (int i = 0; i < cvc.getResultsetTables().size(); i++) {
			turn = 0;

			Table table = cvc.getResultsetTables().get(i);

			String tableName = table.getTableName();

			for (String col : table.getColumns().keySet()) {
				if ((table.getColumn(col).getCvcDatatype()).equalsIgnoreCase("INT")
						|| (table.getColumn(col).getCvcDatatype()).equalsIgnoreCase("REAL")
						|| (table.getColumn(col).getCvcDatatype()).equalsIgnoreCase("BOOLEAN")
						|| table.getColumn(col).getCheckValues().size() > 0) {
					if (col.equalsIgnoreCase("XDATA_CNT")) // added by sunanda for count
					{
						continue;
					}
					// if (turn++ == 0) {
					Expr[] qVarArray = new Expr[1];

					Expr qVar = ctx.mkIntConst("i"); // i should not conflict with any global i
					qVar = ctx.mkConst("i", ctx.getIntSort());
					// Expr <Sort> currentSort = ctx.mkConst("i",ctx.getIntSort());

					if (Configuration.isEnumInt.equalsIgnoreCase("true")) {
						EnumSort currentSort = (EnumSort) ctxSorts.get(cvc.enumArrayIndex);
						qVar = ctx.mkConst("i", currentSort);
					}
					BoolExpr antecedant;
					if (Configuration.isEnumInt.equalsIgnoreCase("true"))
						antecedant = ctx.mkTrue();
					else {
						BoolExpr ac1 = ctx.mkLe(ctx.mkInt("1"), qVar);
						// BoolExpr ac2 = ctx.mkLe(qVar,
						// ctx.mkInt(Integer.toString(cvc.getNoOfOutputTuples(tableName))));
						// added by rambabu for temporary fix
						BoolExpr ac2;
						try {
							ac2 = ctx.mkLe(qVar, ctx.mkInt(Integer.toString(cvc.getNoOfOutputTuples(tableName))));
						} catch (Exception e) {
							ac2 = ctx.mkLe(qVar,
									ctx.mkInt(Integer.toString(cvc.getNoOfOutputTuples(tableName.toUpperCase()))));
						}
						// added by rambabu ended here
						antecedant = ctx.mkAnd(ac1, ac2);

					}

					FuncDecl getFuncDecl = ctxFuncDecls.get("check" + col);
					FuncDecl isNullFuncDecl = ctxFuncDecls.get("ISNULL_" + col);

					Expr selectExpr = ConstraintGenerator.smtMap(table.getColumn(col), qVar);

					BoolExpr tempExpr = ctx.mkTrue();
					if (getFuncDecl != null) {
						tempExpr = (BoolExpr) getFuncDecl.apply(selectExpr);
					}

					BoolExpr con1 = ctx.mkOr(tempExpr,
							(BoolExpr) isNullFuncDecl.apply(selectExpr));

					BoolExpr consequent = ctx.mkAnd(con1); // if count is false

					// if(Configuration.getProperty("cntFlag").equalsIgnoreCase("true")) {
					// Column cntCol =
					// cvc.getTableMap().getTable(tableName.toUpperCase()).getColumn(cvc.getTableMap().getTable(tableName.toUpperCase()).getNoOfColumn()-1);
					// // added by sunanda for count
					// BoolExpr andWithCount =
					// ConstraintGenerator.ctx.mkGt((ArithExpr)ConstraintGenerator.smtMap(cntCol,
					// qVar), ConstraintGenerator.ctx.mkInt(0)); // added by sunanda for count
					// consequent = ctx.mkAnd(con1, andWithCount); // added by sunanda for count
					//
					// }
					Expr body = ctx.mkImplies(antecedant, consequent);

					qVarArray[0] = qVar;
					Quantifier funcQuantifier = ctx.mkForall(qVarArray, body, 1, null, null, null, null);
					domainConstraints.add(funcQuantifier);
					// }
				}
			}
		}

		return domainConstraints;
	}

	public static Expr putTableInCtx(GenerateCVC1 cvc, String[] attrNames, Sort[] attrTypes, String table_name) {
		String tupleTypeName = table_name + "_TupleType";
		Constructor[] cons = new Constructor[] {
				ctx.mkConstructor(tupleTypeName, "is_" + tupleTypeName, attrNames, attrTypes, null) };
		// fatal error due to below statement
		DatatypeSort tupleType = ctx.mkDatatypeSort(tupleTypeName, cons);
		ctxSorts.put(tupleTypeName, tupleType);
		ArraySort asort = ctx.mkArraySort(ctx.getIntSort(), tupleType);
		if (Configuration.isEnumInt.equalsIgnoreCase("true") && ctxSorts.containsKey(cvc.enumArrayIndex)) {
			asort = ctx.mkArraySort(getColumnSort(cvc.enumArrayIndex), tupleType);
		}
		String arrName = "O_" + table_name;
		Expr aex = ctx.mkConst(arrName, asort);
		ctxSorts.put(arrName, asort);
		ctxConsts.put(arrName, aex);
		// ctxConsts.remove(arrName,aex);
		return aex;
	}

	// If we have order by c1,c2,c3 and if c1 is pk than no constraints are
	// generated if c1 has not null constraint than all tuples of c1 will have same
	// value and if there is no constraint on c1 than constraints are generated such
	// that c1 has atleast 1 NULL tuple and atleast 1 NON-NULL Tuple and same thing
	// is done for c2 and c3.While traversing whenever pk of any attribute is
	// encountered we stop generating tuples.
	public static String addOrderByConstraints(GenerateCVC1 cvc) {
		try {
			if (cvc.getCurrentMutant() != null && cvc.getCurrentMutant().getMutationTypeNumber() == 27)
				return "";
			String constraints = "";
			boolean isNonEmptyDataset = cvc.getTypeOfMutation() != null
					&& cvc.getTypeOfMutation().trim().equalsIgnoreCase("DATASET FOR GENERATING NON EMPTY RESULT");

			for (int i = 0; i < cvc.getqStructure().getOrderByNodes().size(); i++) {
				Node orderByNode = cvc.getqStructure().getOrderByNodes().get(i);
				Column col = orderByNode.getColumn();
				if (orderByNode.getColumn().isUnique())
					return constraints;
				if (orderByNode.getColumn().getTable().toString().length() == 0) {
					return "";
				}
				int tuplecount = cvc.getNoOfOutputTuples(orderByNode.getColumn().getTable().getTableName());
				FuncDecl isNullFuncDecl = ctxFuncDecls.get("ISNULL_" + col.getColumnName());
				Vector<BoolExpr> eqConstraints = new Vector<BoolExpr>();
				Vector<BoolExpr> anyNull = new Vector<BoolExpr>();
				Vector<BoolExpr> anyNotNull = new Vector<BoolExpr>();

				if (!orderByNode.getColumn().isNullable()) {
					for (int j = 1; j < tuplecount; j++) {
						Expr t1 = ctx.mkInt(j);
						Expr t2 = ctx.mkInt(j + 1);
						Expr v1 = ConstraintGenerator.smtMap(col, t1);
						Expr v2 = ConstraintGenerator.smtMap(col, t2);
						eqConstraints.add(ctx.mkEq(v1, v2));
					}
				} else {
					for (int j = 1; j <= tuplecount; j++) {
						Expr t = ctx.mkInt(j);
						Expr v = ConstraintGenerator.smtMap(col, t);
						BoolExpr isNull = (BoolExpr) isNullFuncDecl.apply(v);
						anyNull.add(isNull);
						anyNotNull.add(ctx.mkNot(isNull));
					}
				}
				Vector<BoolExpr> finalCons = new Vector<BoolExpr>();
				if (!col.isNullable()) {
					finalCons.addAll(eqConstraints);
				} else {
					if (!isNonEmptyDataset) {
						finalCons.add(ctx.mkOr(anyNull.toArray(new BoolExpr[0])));
					}
					finalCons.add(ctx.mkOr(anyNotNull.toArray(new BoolExpr[0])));
				}
				BoolExpr finalExpr = ctx.mkAnd(finalCons.toArray(new BoolExpr[0]));
				constraints += "(assert \n" + finalExpr.toString() + "\n)\n";
			}
			return constraints;
		} catch (Exception e) {
			return "";
		}
	}

	public static String generateConstraintsForUniqueKeysNullable(GenerateCVC1 cvc) throws Exception {
		StringBuilder uniqueConstraintStr = new StringBuilder();
		try {
			Context ctx = ConstraintGenerator.ctx;

			for (Table table : cvc.getResultsetTables()) {
				String tableName = table.getTableName();
				List<Column> uniqueCols = table.getUniqueKeyCols();
				if (uniqueCols.isEmpty())
					continue;

				int noOfTuples = cvc.getNoOfOutputTuples(tableName);
				if (noOfTuples <= 1)
					continue;

				Column cntCol = table.getColumn("XDATA_CNT");

				// ISNULL function mapping
				Map<Column, FuncDecl> isNullFuncs = new HashMap<>();
				for (Column col : uniqueCols) {
					isNullFuncs.put(col, ConstraintGenerator.ctxFuncDecls.get("ISNULL_" + col.getColumnName()));
				}

				Vector<BoolExpr> constraints = new Vector<>();

				for (int i = 1; i <= noOfTuples; i++) {
					for (int j = i + 1; j <= noOfTuples; j++) {

						Expr ti = ctx.mkInt(i);
						Expr tj = ctx.mkInt(j);

						BoolExpr validI = ctx
								.mkNot(ctx.mkEq((ArithExpr) ConstraintGenerator.smtMap(cntCol, ti), ctx.mkInt(0)));
						BoolExpr validJ = ctx
								.mkNot(ctx.mkEq((ArithExpr) ConstraintGenerator.smtMap(cntCol, tj), ctx.mkInt(0)));

						Vector<BoolExpr> nonNullChecks = new Vector<>();
						Vector<BoolExpr> diffChecks = new Vector<>();

						for (Column col : uniqueCols) {
							FuncDecl isNull = isNullFuncs.get(col);
							Expr valI = ConstraintGenerator.smtMap(col, ti);
							Expr valJ = ConstraintGenerator.smtMap(col, tj);

							nonNullChecks.add(ctx.mkNot((BoolExpr) isNull.apply(valI)));
							nonNullChecks.add(ctx.mkNot((BoolExpr) isNull.apply(valJ)));

							diffChecks.add(ctx.mkDistinct(valI, valJ));
						}

						BoolExpr allNonNull = ctx.mkAnd(nonNullChecks.toArray(new BoolExpr[0]));
						BoolExpr atLeastOneDiff = ctx.mkOr(diffChecks.toArray(new BoolExpr[0]));
						BoolExpr implication = ctx.mkImplies(ctx.mkAnd(validI, validJ, allNonNull), atLeastOneDiff);

						constraints.add(implication);
					}
				}

				if (!constraints.isEmpty()) {
					uniqueConstraintStr.append("(assert\n")
							.append(ctx.mkAnd(constraints.toArray(new BoolExpr[0])))
							.append("\n)\n");
				}
			}
		} catch (Exception e) {
			logger.log(Level.SEVERE, "Exception in generateConstraintsForUniqueKeysNullable", e);
			throw e;
		}
		return uniqueConstraintStr.toString();
	}

	public static void putEnumSortInContext(String enumArrayIndex, Vector<String> enumArrayIndexData) {
		// TODO Auto-generated method stub
		if (ctxConsts.containsKey(enumArrayIndex)) {
			ctxConsts.remove(enumArrayIndex);
		}
		EnumSort colSort = ctx.mkEnumSort(enumArrayIndex,
				enumArrayIndexData.toArray(new String[enumArrayIndexData.size()]));
		ctxSorts.put(enumArrayIndex, colSort);

	}

	private static String getPrimaryKeyConstraintsForGSQTable(GenerateCVC1 cvc,
			AggregateDataStructure aggregateDS, String indexType, Integer numberOfTuples, boolean isDistinct) {
		Boolean primaryKeyMethod = false;
		Vector<String> primaryKeySQ = aggregateDS.primaryKeyColumnsofSQ;
		Expr cntOfSQColumnSQi1 = ConstraintGenerator.genSelectTest2(cvc, aggregateDS.subqueryTableName,
				aggregateDS.attrColumnsOfSQ.indexOf(aggregateDS.countColOfSQ.getColumnName()), "i1");
		Expr cntOfSQColumnSQj1 = ConstraintGenerator.genSelectTest2(cvc, aggregateDS.subqueryTableName,
				aggregateDS.attrColumnsOfSQ.indexOf(aggregateDS.countColOfSQ.getColumnName()), "j1");

		Expr orExprTempForPK = ConstraintGenerator.ctx.mkOr(
				ConstraintGenerator.ctx.mkEq((ArithExpr) cntOfSQColumnSQi1,
						(ArithExpr) ConstraintGenerator.ctx.mkInt(0)),
				ConstraintGenerator.ctx.mkEq((ArithExpr) cntOfSQColumnSQj1,
						(ArithExpr) ConstraintGenerator.ctx.mkInt(0)));

		BoolExpr[] andexprConstraintsTemp = new BoolExpr[primaryKeySQ.size() + 1];
		int p = 0;
		String primaryKeyConstraintsOfSQ = "";

		primaryKeySQ = aggregateDS.primaryKeyColumnsofSQ;

		if (primaryKeySQ.size() > 0) {
			for (int i = 0; i < primaryKeySQ.size(); i++) {
				Expr selecti1 = ConstraintGenerator.genSelectTest2(cvc, aggregateDS.subqueryTableName,
						aggregateDS.attrColumnsOfSQ.indexOf(primaryKeySQ.get(i)), "i1");
				;
				Expr selectj1 = ConstraintGenerator.genSelectTest2(cvc, aggregateDS.subqueryTableName,
						aggregateDS.attrColumnsOfSQ.indexOf(primaryKeySQ.get(i)), "j1");
				;
				andexprConstraintsTemp[p] = (BoolExpr) ConstraintGenerator.ctx.mkEq(selecti1, selectj1);
				p++;
			}
			for (int k = primaryKeySQ.size(); k < andexprConstraintsTemp.length; k++) {
				andexprConstraintsTemp[k] = ctx.mkTrue();
			}
			andexprConstraintsTemp[p] = ConstraintGenerator.ctx.mkNot(ConstraintGenerator.ctx.mkEq(
					(Expr) ConstraintGenerator.ctx.mkIntConst("i1"),
					(Expr) ConstraintGenerator.ctx.mkIntConst("j1")));

			Expr andExprTempForPK = ConstraintGenerator.ctx.mkAnd(andexprConstraintsTemp);

			String pkconstUsingNeq = "";
			if (primaryKeyMethod == true) {
				ArrayList<Column> primaryKeycols = new ArrayList<>();
				for (String a : primaryKeySQ) {
					primaryKeycols.add(cvc.getTableMap().getSQTableByName(aggregateDS.subqueryTableName).getColumn(a));
				}
				pkconstUsingNeq = AddDataBaseConstraints.getPrimaryKeyConstUsingNonEquiMethod(primaryKeycols,
						numberOfTuples);

			}
			if (pkconstUsingNeq.equalsIgnoreCase("")) {
				primaryKeyConstraintsOfSQ += "\n(assert (forall ((i1 " + indexType + ") (j1 " + indexType
						+ ")) \n\t (=> \n\t"
						+ andExprTempForPK.toString() + "\n\t\t" + orExprTempForPK + ")))\n\n";

			} else {
				if (pkconstUsingNeq.contains("select"))
					primaryKeyConstraintsOfSQ = "\n(assert " + pkconstUsingNeq + ")\n";
				else
					primaryKeyConstraintsOfSQ = "";
			}

		}

		Expr cnt0or1 = ctx.mkOr(ctx.mkEq(cntOfSQColumnSQi1, ctx.mkInt(0)),
				ctx.mkEq(cntOfSQColumnSQi1, ctx.mkInt(1)));
		if (isDistinct)
			primaryKeyConstraintsOfSQ += "\n(assert (forall ((i1 " + indexType + ")) \n\t " + cnt0or1.toString()
					+ "))\n\n";

		return primaryKeyConstraintsOfSQ;
	}

	private static HashMap<String, Object> generateForwardPassConstraints(GenerateCVC1 cvc, QueryBlockDetails qbt,
			AggregateDataStructure aggregateDS, GroupByNodesData groupByNodeDS,
			ProjectedNodesData projectedNodeDs, int cntColumnBQIndex, int numberOfTuples,
			Expr checkIfBQTupleIsValid, EnumSort currentSort, String indexType, int countValue, int isProjected) {

		Boolean isExist = Configuration.getProperty("existsUnrollFlag").equalsIgnoreCase("true");
		// isExist = false;
		HashMap<String, Object> retunData = new HashMap<String, Object>();

		int i;
		String functionName2 = "SQTABLE_" + qbt.getLevel() + "_FORWARD";
		// for enum_int - Sunanda

		FuncDecl sqTableIForward = ctx.mkFuncDecl(functionName2, ctx.getIntSort(), ctx.mkBoolSort());

		if (Configuration.isEnumInt.equalsIgnoreCase("true")) {
			sqTableIForward = ctx.mkFuncDecl(functionName2, currentSort, ctx.mkBoolSort());
		}
		ctxFuncDecls.put(functionName2, sqTableIForward);

		String DefinesqTableIForward = "(define-fun " + functionName2 + "((i1 " + indexType + "))Bool";

		// selectCntBQ = smtMap(arrNameBQ, "i1", -1, cntColumnBQIndex);

		Expr[] arrForIndexj1 = new Expr[] { ctx.mkIntConst("j1") };
		Expr[] arrForIndexK1 = new Expr[] { ctx.mkIntConst("k1") };
		Expr[] arrForIndexL1 = new Expr[] { ctx.mkIntConst("l1") };

		if (Configuration.isEnumInt.equalsIgnoreCase("true")) {
			arrForIndexj1 = new Expr[] { ctx.mkConst("j1", currentSort) };
			arrForIndexK1 = new Expr[] { ctx.mkConst("k1", currentSort) };
			arrForIndexL1 = new Expr[] { ctx.mkConst("l1", currentSort) };
		}
		Expr compareExpr1 = ctx.mkLt((ArithExpr) (IntExpr) ctx.mkInt(0), (ArithExpr) ctx.mkIntConst("j1"));
		Expr compareExpr2 = ctx.mkLe((ArithExpr) ctx.mkIntConst("j1"),
				(ArithExpr) (IntExpr) ctx.mkInt(numberOfTuples));
		// Expr andExpr1 = ctx.mkAnd((BoolExpr) compareExpr1, (BoolExpr)compareExpr2,
		// (BoolExpr) ctx.mkEq(smtMap(arrNameSQ, "j1", -1, attrNamesSQ.length-1),
		// ctx.mkInt(1)));

		Expr[] colValueBQForForward = new Expr[groupByNodeDS.noOfGroupByColumns];
		Expr[] colValueSQForForward = new Expr[groupByNodeDS.noOfGroupByColumns];
		BoolExpr[] eqExprForward = new BoolExpr[groupByNodeDS.noOfGroupByColumns + 1];
		// System.out.println();

		Expr exitsExpr1;
		if (isExist) {
			Expr[] andExpr2 = new Expr[numberOfTuples];
			for (int j = 1; j <= numberOfTuples; j++) {
				for (i = 0; i < groupByNodeDS.noOfGroupByColumns; i++) {
					colValueSQForForward[i] = smtMap(aggregateDS.arrayNameOfSQInCtx, "", j, i);

					colValueBQForForward[i] = smtMap(aggregateDS.arrayNameOfBQInCtx, "i1", -1,
							aggregateDS.attrNamesOfBQ
									.indexOf(groupByNodeDS.groupByColumnsFromJSQ.get(i).getColumnName()));
					if (groupByNodeDS.groupByNodes.get(i).getIsMutant())
						eqExprForward[i] = (BoolExpr) ctx.mkTrue();

					else
						eqExprForward[i] = (BoolExpr) ctx.mkEq(colValueSQForForward[i], colValueBQForForward[i]);

				}
				if (countValue == 1 && isProjected == 0) {
					eqExprForward[i] = (BoolExpr) ctx.mkEq(
							smtMap(aggregateDS.arrayNameOfSQInCtx, "", j, aggregateDS.attrColumnsOfSQ.size() - 1),
							ctx.mkInt(1));
				} else if (countValue == 1 && isProjected != 0) {
					eqExprForward[i] = (BoolExpr) ctx.mkGt(
							smtMap(aggregateDS.arrayNameOfSQInCtx, "", j, aggregateDS.attrColumnsOfSQ.size() - 1),
							ctx.mkInt(0));

				} else
					eqExprForward[i] = (BoolExpr) ctx.mkGe(
							smtMap(aggregateDS.arrayNameOfSQInCtx, "", j, aggregateDS.attrColumnsOfSQ.size() - 1),
							ctx.mkInt(2));
				andExpr2[j - 1] = ctx.mkAnd(eqExprForward);
			}
			exitsExpr1 = ctx.mkOr(andExpr2);

		} else {

			for (i = 0; i < groupByNodeDS.noOfGroupByColumns; i++) {
				colValueSQForForward[i] = smtMap(aggregateDS.arrayNameOfSQInCtx, "j1", -1, i);

				colValueBQForForward[i] = smtMap(aggregateDS.arrayNameOfBQInCtx, "i1", -1,
						aggregateDS.attrNamesOfBQ.indexOf(groupByNodeDS.groupByColumnsFromJSQ.get(i).getColumnName()));
				if (groupByNodeDS.groupByNodes.get(i).getIsMutant())
					eqExprForward[i] = (BoolExpr) ctx.mkTrue();

				else
					eqExprForward[i] = (BoolExpr) ctx.mkEq(colValueSQForForward[i], colValueBQForForward[i]);

			}

			eqExprForward[i] = (BoolExpr) ctx.mkEq(
					smtMap(aggregateDS.arrayNameOfSQInCtx, "j1", -1, aggregateDS.attrColumnsOfSQ.size() - 1),
					ctx.mkInt(1));

			Expr andExpr2 = ctx.mkAnd(eqExprForward[i]);

			exitsExpr1 = ctx.mkExists(arrForIndexj1, andExpr2, 1, null, null, null, null);

		}

		retunData.put("exitsExpr1", exitsExpr1);
		retunData.put("DefinesqTableIForward", DefinesqTableIForward);
		retunData.put("sqTableIForward", sqTableIForward);
		return retunData;
	}

	// added for with clause
	public static Boolean checkContainsInFromClause(QueryBlockDetails qb, String supeString) {
		for (QueryBlockDetails qbd : qb.getFromClauseSubQueries()) {
			for (String str : qbd.getBaseRelations()) {
				if (supeString.contains(str.toLowerCase())) {
					return true;
				} else {
					if (checkContainsInFromClause(qbd, supeString)) {
						return true;
					}
				}
			}
		}
		return false;
	}

	public static Boolean checkContains(GenerateCVC1 cvc, QueryBlockDetails qb, String superString) {
		for (String str : qb.getBaseRelations()) {
			str = str.replaceAll("\\d", "");
			if (superString.contains(str)) {
				return true;
			} else if (cvc.outerBlock.withClauseMapBlockDetails.get(str) != null) {
				QueryBlockDetails qbtemp = cvc.outerBlock.withClauseMapBlockDetails.get(str);
				for (String s : qbtemp.getBaseRelations()) {
					if (superString.contains(s.toLowerCase())) {
						return true;
					}
					if (checkContainsInFromClause(qbtemp, superString)) {
						return true;
					}

				}
			}
		}

		return false;
	}

	public static String GetDistinctClauseConstraintsForSubqueryTableWithCount(GenerateCVC1 cvc, QueryBlockDetails qbt,
			String subqueryType, String SQtableName, int isProjected) {
		String indexType = "Int";
		if (Configuration.getProperty("isEnumInt").equalsIgnoreCase("true"))
			indexType = cvc.enumArrayIndex;
		// write api code here to generate string

		String ConstraintsStr = "";

		try {
			// number of tuples
			int numberOfTuples = 0; // get the number of tuples in base table from cvc
			int numberOfGroups = 0;

			MutationStructure currentMutant = cvc.getCurrentMutant();
			// A DISTINCT mutation applies only to the query block that owns the mutation. 
			boolean isDistinctMutationTarget = currentMutant != null
					&& currentMutant.getMutationTypeNumber() == 5
					&& currentMutant.getQueryBlock() == qbt;
			AggregateDataStructure aggregateDS = new AggregateDataStructure(
					SQtableName == "" ? "GSQ" : SQtableName + qbt.getLevel());
			ProjectedNodesData projectedNodeDs = new ProjectedNodesData();

			// ArrayList<Node> groupByNodes; // comment
			ArrayList<Node> projectedNodes = new ArrayList<>();

			int i, j;

			for (i = 0; i < qbt.getProjectedCols().size(); i++) {
				if (qbt.getProjectedCols().get(i).getAgg() != null) {
					projectedNodes.add(qbt.getProjectedCols().get(i));

				}
			}
			GroupByNodesData groupByNodeDS = new GroupByNodesData(qbt.getGroupByNodes());
			groupByNodeDS.noOfGroupByColumns = groupByNodeDS.getGroupByNodes().size();

			projectedNodeDs.putProjectedNodes(projectedNodes);
			projectedNodeDs.noOfProjectedColumns = projectedNodes.size();

			// to handle extra group by column mutations
			GenConstraints.HandleExtraGroupByMutations(groupByNodeDS.getGroupByNodes(), cvc.getCurrentMutant());

			// checking if join subquery table created
			boolean isJoin = true;
			// uncomment later

			Vector<String> primaryKeySQ = new Vector<String>(); // comment

			String cntColumnName = aggregateDS.subqueryTableName + "_XDATA_CNT";

			Solver dummySol = ctx.mkSolver(); // for getting string form of z3 context declarations

			// int[] indexOfProjectedColmnsInSQ = new int[projectedNodes.size()]; // comment

			HashMap<String, Object> aggTableDetails = createTempTableColumnsForAggregates(aggregateDS, groupByNodeDS,
					projectedNodeDs, subqueryType);

			cvc.getTableMap().putSQTables((Map<String, Table>) aggTableDetails.get("TableMap"));

			Expr aex = putTableInCtx(cvc, aggregateDS.attrColumnsOfSQ,
					aggregateDS.attrTypesOfSQ, aggregateDS.subqueryTableName); // uncomment

			ArrayList attrNamesBQArrayList = cvc.getDatatypeColumns();

			String agg_table = "";
			if (isJoin) {
				if (subqueryType.equalsIgnoreCase(subqueryType)) {
					aggregateDS.baseTableName = cvc.subqueryConstraintsMap.get(subqueryType).SQTableName.keySet()
							.iterator().next();
					agg_table = cvc.subqueryConstraintsMap.get(subqueryType).SQTableName.keySet().iterator().next();
					numberOfTuples = cvc.getNoOfTuples()
							.get(cvc.subqueryConstraintsMap.get(subqueryType).SQTableName.keySet().iterator().next());
					attrNamesBQArrayList = cvc.subqueryConstraintsMap.get(subqueryType).SQColumns.get(agg_table);
					Table baseTable = cvc.getTableMap().getSQTableByName(agg_table);
					for (i = 0; i < groupByNodeDS.groupByColumnsFromRefTables.size(); i++) {
						for (j = 0; j < attrNamesBQArrayList.size(); j++) {

							if (attrNamesBQArrayList.get(j).toString()
									.contains(groupByNodeDS.groupByColumnsFromRefTables.get(i).getColumnName())
									&& attrNamesBQArrayList.get(j).toString().contains(
											groupByNodeDS.groupByColumnsFromRefTables.get(i).getTableName())) {
								groupByNodeDS.groupByColumnsFromJSQ.add(i,
										baseTable.getColumn(attrNamesBQArrayList.get(j).toString()));
								break;
							} // added for with clause
							else if (cvc.getqStructure().withTableName != null) {
								if (checkColumn(attrNamesBQArrayList.get(j).toString(),
										groupByNodeDS.groupByColumnsFromRefTables.get(i).getColumnName(),
										groupByNodeDS.groupByColumnsFromRefTables.get(i).getTableName(), cvc)
										&& checkContains(cvc, qbt, attrNamesBQArrayList.get(j).toString())) {
									// System.out.println(baseTable.getColumn(attrNamesBQArrayList.get(j).toString()));
									groupByNodeDS.groupByColumnsFromJSQ.add(i,
											baseTable.getColumn(attrNamesBQArrayList.get(j).toString()));
									break;
								}
							}
						}

					}
					for (i = 0; i < projectedNodes.size(); i++) {
						for (j = 0; j < attrNamesBQArrayList.size(); j++) {

							if (attrNamesBQArrayList.get(j).toString()
									.contains(projectedNodes.get(i).getColumn().getColumnName())
									&& attrNamesBQArrayList.get(j).toString()
											.contains(projectedNodes.get(i).getColumn().getTableName())) {
								projectedNodeDs.aggregateColumnsFromJSQ.add(i,
										baseTable.getColumn(attrNamesBQArrayList.get(j).toString()));
								break;
							} // added for with clause
							else if (cvc.getqStructure().withTableName != null) {
								if (checkColumn(attrNamesBQArrayList.get(j).toString(),
										projectedNodes.get(i).getColumn().getColumnName(),
										projectedNodes.get(i).getColumn().getTableName(), cvc)
										&& checkContains(cvc, qbt, attrNamesBQArrayList.get(j).toString())) {
									projectedNodeDs.aggregateColumnsFromJSQ.add(i,
											baseTable.getColumn(attrNamesBQArrayList.get(j).toString()));
									break;
								}
							}
						}

					}
				}
			}

			Table sqi = cvc.getTableMap().getSQTableByName(aggregateDS.subqueryTableName);
			boolean isExits = cvc.getTableMap().getSQTableByName(agg_table).getIsExist();
			sqi.setIsExist(isExits);

			Vector<String> attrNamesBQ = new Vector<String>();
			Vector<Sort> attrTypesBQ = new Vector<Sort>();

			// creating context for base_table_name

			// String arrNameBQ = "O_" + agg_table; // comment
			aggregateDS.arrayNameOfBQInCtx = "O_" + agg_table;
			if (isJoin) {
				// attrNamesBQ = new String[attrNamesBQArrayList.size()];
				// attrTypesBQ = new Sort[attrNamesBQArrayList.size()];
				for (int k = 0; k < attrNamesBQArrayList.size(); k++) {
					// Column column = cvc.getResultsetColumns().get(k);

					if (subqueryType.equalsIgnoreCase(subqueryType)) {

						aggregateDS.arrayNameOfBQInCtx = "O_"
								+ cvc.subqueryConstraintsMap.get(subqueryType).SQTableName.keySet().iterator().next();
						aggregateDS.attrNamesBQ.add("" + attrNamesBQArrayList.get(k));
						aggregateDS.attrTypesBQ.add(getColumnSort(
								cvc.subqueryConstraintsMap.get(subqueryType).SQColumnsDataTypes.get(agg_table).get(k)));

					}

				}
			}

			// putting base table in context
			// Expr aexBQ = putTableInCtx(cvc, attrNamesBQ, attrTypesBQ, agg_table); //
			// comment
			Expr aexBQ = putTableInCtx(cvc, aggregateDS.attrNamesBQ,
					aggregateDS.attrTypesBQ, aggregateDS.baseTableName); // uncomment

			// end putting base table in context

			cvc.getNoOfTuples().put(aggregateDS.subqueryTableName, numberOfTuples);
			cvc.putNoOfOutputTuples(aggregateDS.subqueryTableName, numberOfTuples);

			// cvc.getNoOfTuples().put(subquery_table_name, numberOfTuples);
			// cvc.putNoOfOutputTuples(subquery_table_name, numberOfTuples);
			// adding dummy asserts so that solver has relevant declarations in string
			// returned by toString()
			BoolExpr dummyAssert = ctx.mkDistinct(aex);

			dummySol.add(dummyAssert);

			String[] constraints = dummySol.toString().split("\n");

			String tempStr = "";

			Vector<String> includedStatements = new Vector<String>();

			for (String statement : constraints) {
				if (statement.contains("_TupleType ") || statement.contains("declare-fun O_")) {
					includedStatements.add(statement);
				}
				if (statement.contains("(assert")) {
					break;
				}
			}
			tempStr += String.join("\n\n", includedStatements);

			// Tuple type declaration constraints of Subquery table

			// ***************************************************************************************************
			// primary key constraints for SQ table using COUNT

			Expr cntOfSQColumnSQi1 = ConstraintGenerator.genSelectTest2(cvc, aggregateDS.subqueryTableName,
					aggregateDS.attrColumnsOfSQ.indexOf(aggregateDS.countColOfSQ.getColumnName()), "i1");
			Expr cntOfSQColumnSQj1 = null;
			if (isDistinctMutationTarget || !qbt.isDistinct())
				cntOfSQColumnSQj1 = ConstraintGenerator.genSelectTest2(cvc, aggregateDS.subqueryTableName,
						projectedNodeDs.indexOfProjectedColmnsInSQ.get(0), "i1");

			// ***************************************************************************************************

			// }
			String primaryKeyConstraintsOfSQ = "";

			if (isDistinctMutationTarget || !qbt.isDistinct()) {
				primaryKeyConstraintsOfSQ = "\n\t(assert (forall ((i1 Int))"
						+ ctx.mkEq(cntOfSQColumnSQi1, cntOfSQColumnSQj1).toString() + "))\n";

				Expr[] eqExprForward = new Expr[numberOfTuples];

				for (i = 1; i <= numberOfTuples; i++) {
					eqExprForward[i - 1] = (BoolExpr) ctx.mkGe(
							smtMap(aggregateDS.arrayNameOfSQInCtx, "j1", i, aggregateDS.attrColumnsOfSQ.size() - 1),
							ctx.mkInt(2));
				}
				if (isDistinctMutationTarget)
					primaryKeyConstraintsOfSQ += "\n\t(assert " + ctx.mkOr(eqExprForward).toString() + ")\n";

			} else {
				primaryKeyConstraintsOfSQ += getPrimaryKeyConstraintsForGSQTable(cvc,
						aggregateDS, indexType, numberOfTuples, qbt.isDistinct());

			}
			if (!qbt.isDistinct()) {
				primaryKeyConstraintsOfSQ += getPrimaryKeyConstraintsForGSQTable(cvc,
						aggregateDS, indexType, numberOfTuples, qbt.isDistinct());
			}
			// Aggregate functions

			Expr[] arrForIndexI = new Expr[] { ctx.mkIntConst("i") };

			int cntColumnBQIndex = aggregateDS.attrNamesOfBQ.size() - 1;
			Expr[] arrForIntIndex = new Expr[numberOfTuples + 1];
			// Boolean ifSumPresent = false;
			// Boolean ifCountPresent = false;
			int p;
			for (p = 0; p < numberOfTuples; p++) {
				arrForIntIndex[p + 1] = (IntExpr) ctx.mkInt(p + 1);
			}
			arrForIntIndex[0] = (IntExpr) ctx.mkInt(0);

			if (Configuration.isEnumInt.equalsIgnoreCase("true")) {
				EnumSort currentSort = (EnumSort) ConstraintGenerator.ctxSorts.get(cvc.enumArrayIndex);
				arrForIndexI = new Expr[] { ctx.mkConst("i", currentSort) };
				arrForIntIndex[0] = ctx.mkConst(cvc.enumIndexVar + 0, currentSort);
				for (p = 0; p < numberOfTuples; p++) {
					arrForIntIndex[p] = ctx.mkConst(cvc.enumIndexVar + (p + 1), currentSort);
				}
			}
			if (isJoin) {
				cntColumnBQIndex = attrNamesBQArrayList.size() - 1;
				// selectCntBQ = smtMap(arrNameBQ, "i1", p, cntColumnBQIndex);

			}

			HashMap<String, Object> aggCalls = generateAggregateConstraints(cvc, qbt, aggregateDS, projectedNodeDs,
					groupByNodeDS, arrForIndexI, numberOfTuples, cntColumnBQIndex);

			Vector<Expr> assertAggValDef = (Vector<Expr>) aggCalls.get("assertAggValDef");
			Vector<Expr> assertAggValCall = (Vector<Expr>) aggCalls.get("assertAggValCall");
			Vector<String> functionName = (Vector<String>) aggCalls.get("functionName");
			Vector<FuncDecl> DeclAssertAggVal = (Vector<FuncDecl>) aggCalls.get("DeclAssertAggVal"); // Function
																										// declaration
																										// for asserting
																										// agg val
			Vector<String> DefineAssertAggVal = (Vector<String>) aggCalls.get("DefineAssertAggVal"); // Function
																										// defination
																										// for asserting
																										// agg val fun

			Expr selectCntBQ;
			selectCntBQ = genSelectTest2(cvc, aggregateDS.arrayNameOfBQInCtx, cntColumnBQIndex, "i1");
			Expr checkIfBQTupleIsValid = ctx.mkGt((ArithExpr) selectCntBQ, ctx.mkInt(0));

			// Function 2 SQ Forward function
			EnumSort currentSort = (EnumSort) ConstraintGenerator.ctxSorts.get(cvc.enumArrayIndex);

			aggregateDS.attrNamesOfBQ = attrNamesBQArrayList;
			HashMap<String, Object> forwardPassData = generateForwardPassConstraints(cvc, qbt, aggregateDS,
					groupByNodeDS, projectedNodeDs, cntColumnBQIndex,
					numberOfTuples, checkIfBQTupleIsValid, currentSort, indexType,
					isDistinctMutationTarget ? 2 : 1, isProjected);

			FuncDecl sqTableIForward = (FuncDecl) forwardPassData.get("sqTableIForward");
			String DefinesqTableIForward = (String) forwardPassData.get("DefinesqTableIForward");
			Expr exitsExpr1 = (Expr) forwardPassData.get("exitsExpr1");

			// Function 3 SQ Backward function

			HashMap<String, Object> backwardPassData = generateBackwardPassConstraints(cvc, qbt, aggregateDS,
					groupByNodeDS, projectedNodeDs, cntColumnBQIndex,
					numberOfTuples, checkIfBQTupleIsValid, currentSort, indexType);

			FuncDecl sqTableIBackward = (FuncDecl) backwardPassData.get("sqTableIBackward");
			String DefinesqTableIBackward = (String) backwardPassData.get("DefinesqTableIBackward");
			Expr impliesExprBackward = (Expr) backwardPassData.get("impliesExprBackward");
			Expr[] eqExprBackward = (Expr[]) backwardPassData.get("eqExprBackward");
			Expr[] colValueBQForBackward = (Expr[]) backwardPassData.get("colValueBQForBackward");
			Expr[] colValueSQForBackward = (Expr[]) backwardPassData.get("colValueSQForBackward");

			// // end of backward function

			ConstraintsStr += "\n\n" + tempStr;
			ConstraintsStr += primaryKeyConstraintsOfSQ;
			ConstraintsStr += "\n\n" + DefinesqTableIForward.toString() + "\n\n " + "(and \n\t (=> \n\t\t"
					+ checkIfBQTupleIsValid + "\n\n\t" + exitsExpr1.toString() + ")))" + "\n\n";
			ConstraintsStr += "\n\n" + DefinesqTableIBackward.toString() + "\n\n " + impliesExprBackward.toString()
					+ ")" + "\n\n";

			BoolExpr[] assertSqTableIForward1 = new BoolExpr[numberOfTuples];
			Vector<BoolExpr> assertAggValFunsCall = new Vector<BoolExpr>();

			for (int s = 0; s < numberOfTuples; s++) {
				assertSqTableIForward1[s] = (BoolExpr) sqTableIForward.apply(arrForIntIndex[s + 1]);
			}

			BoolExpr andAssertsForward = ctx.mkAnd(assertSqTableIForward1);

			Expr assertSqTableIBackward1;

			if (Configuration.isEnumInt.equalsIgnoreCase("true")) {
				assertSqTableIBackward1 = sqTableIBackward.apply(ctx.mkConst("i1", currentSort));
			} else
				assertSqTableIBackward1 = sqTableIBackward.apply(ctx.mkIntConst("i1"));

			// function asserts for number of tuples
			Expr backwardExprAnd = ctx.mkAnd((BoolExpr) assertSqTableIBackward1);
			i = 0;

			for (i = 0; i < assertAggValDef.size(); i++) {
				if (assertAggValDef.get(i) != null) {
					ConstraintsStr += "\n\n" + DefineAssertAggVal.get(i) + "\n\n " + assertAggValDef.get(i).toString()
							+ ")" + "\n\n";
					if (Configuration.isEnumInt.equalsIgnoreCase("true")) {
						assertAggValFunsCall
								.add((BoolExpr) DeclAssertAggVal.get(i).apply(ctx.mkConst("i1", currentSort)));
					} else
						// assertSqTableIBackward1 = sqTableIBackward.apply(ctx.mkIntConst("i1"));
						assertAggValFunsCall.add((BoolExpr) DeclAssertAggVal.get(i).apply(ctx.mkIntConst("i1")));
				} else {
					assertAggValFunsCall.add(ctx.mkTrue());
					System.out.println(
							"************ Not supported for this Aggregate Function Name: " + functionName.get(i));
				}
			}

			assertAggValFunsCall.add((BoolExpr) assertSqTableIBackward1);

			Object[] temp = assertAggValFunsCall.toArray();
			Expr[] array = Arrays.copyOf(
					temp, temp.length, Expr[].class);

			BoolExpr andAssertBackwardAndAggValFunsCall = ctx.mkAnd(array); // work from here
			Expr[] iColArray = new IntExpr[] { ctx.mkIntConst("i1") };

			if (Configuration.isEnumInt.equalsIgnoreCase("true")) {
				iColArray = new Expr[] { ctx.mkConst("i1", currentSort) };
			}

			Expr backwardAsssertsFinal = ctx.mkForall((Expr[]) iColArray, (Expr) andAssertBackwardAndAggValFunsCall, 1,
					null, null, null, null);

			ConstraintsStr += "\n\n (assert " + andAssertsForward.toString() + ")" + "\n\n";
			ConstraintsStr += "\n\n (assert " + backwardAsssertsFinal.toString() + ")" + "\n\n";

		} catch (Exception e) {
			e.printStackTrace();
		}
		return ConstraintsStr;
	}

	public String getUserDefinedComparisionOperator(String operator, Column col, String lC, String rC) {
		String constr = "";

		if (lC.equalsIgnoreCase("") && rC.equalsIgnoreCase(""))
			return "";
		if (col == null || col.getCvcDatatype().equalsIgnoreCase("INT")
				|| col.getCvcDatatype().equalsIgnoreCase("REAL")) {
			if (operator.equalsIgnoreCase("/="))
				constr += "(not (= " + lC + " " + rC + "))";
			else
				constr += "(" + operator + " " + lC + " " + rC + " " + ")";
			return constr;
		}
		if (operator.equalsIgnoreCase(">")) {
			// chaitra comes here for date also
			constr += "(gt" + col.getCvcDatatype() + " " + lC + " " + rC + " " + ")";
			return constr;
		} else if (operator.equalsIgnoreCase("<")) {
			constr += "(lt" + col.getCvcDatatype() + " " + lC + " " + rC + " " + ")";
			return constr;
		}
		if ((operator.equalsIgnoreCase(">=") || operator.equalsIgnoreCase("<="))
				&& (!lC.equalsIgnoreCase("") && !rC.equalsIgnoreCase(""))) {
			String op = operator.equalsIgnoreCase(">=") ? "gt" : "lt";
			String cmp = "(" + op + col.getCvcDatatype() + " " + lC + " " + rC + " " + ")";
			String equal = "(= " + lC + " " + rC + ")";
			constr += "(or\n" +
					"\t" + cmp + "\n" +
					"\t" + equal + "\n" +
					")";
			return constr;

		}
		if (operator.equalsIgnoreCase("=") && !lC.equalsIgnoreCase("") && !rC.equalsIgnoreCase("")) {
			constr += "(= " + lC + " " + rC + ")";
			return constr;
		}

		if ((operator.equalsIgnoreCase("/=") || operator.equalsIgnoreCase("!=") || operator.equalsIgnoreCase("<>")) && !lC.equalsIgnoreCase("") && !rC.equalsIgnoreCase("")) {
			constr += "(not (= " + lC + " " + rC + "))";
			return constr;
		}

		return "";

	}

	/**
	 * This method returns the null integer values for CVC data type.
	 * 
	 * @param cvc
	 * @param col
	 * @return
	 */
	public String getNullMembers(Column col) {
		String isNullMembers = "";

		if (isCVC3) {
			for (int k = -99996; k >= -99999; k--) {
				isNullMembers += "ASSERT ISNULL_" + col + "(" + k + ");\n";
			}
		} else {
			isNullMembers = "";
		}
		return isNullMembers;
	}

	/**
	 * This method returns a constraint for null value in the query depending on
	 * solver.
	 * 
	 * @param cvc
	 * @param c
	 * @param index
	 * @param nullVal
	 * @return
	 */
	public String getAssertNullValue(Column c, String index, String nullVal) {

		return "\n (assert (= " + smtMap(c, (IntExpr) ctx.mkInt(index)) + " " + nullVal + "  )) \n";

	}

	public String getAssertNotNullValue(Column c, String index, String nullVal) {

		return "\n (assert (not (= " + smtMap(c, (IntExpr) ctx.mkInt(index)) + " " + nullVal + "  ))) \n";

	}

	/**
	 * 
	 * @param col
	 * @param index
	 * @param constraint
	 * @return
	 */
	public String getAndSetNotNullValuesBeforeFooter(Column col, Integer index) {

		String constraint;

		if (col != null && col.getCvcDatatype() != null
				&& (col.getCvcDatatype().equalsIgnoreCase("INT") || col.getCvcDatatype().equalsIgnoreCase("REAL")
						|| col.getCvcDatatype().equalsIgnoreCase("TIME")
						|| col.getCvcDatatype().equalsIgnoreCase("TIMESTAMP")
						|| col.getCvcDatatype().equalsIgnoreCase("DATE"))) {

			// constraint += "\n (assert NOTISNULL_"+col.getColumnName()+"
			// "+smtMap(col,Integer.toString(index))+")";
			// constraint = "\n (assert (get"+col.getColumnName()+" "+smtMap(col, (IntExpr)
			// ctx.mkInt(index)).toString()+"))";
			constraint = "\n (assert (not (ISNULL_" + col.getColumnName() + " "
					+ smtMap(col, (IntExpr) ctx.mkInt(index)).toString() + ")))";

		} else {

			// constraint = "\n (assert (NOTISNULL_"+col.getCvcDatatype()+" " + smtMap(col,
			// (IntExpr) ctx.mkInt(index)).toString()+"))";
			constraint = "\n (assert (not ( ISNULL_" + col.getCvcDatatype() + " "
					+ smtMap(col, (IntExpr) ctx.mkInt(index)).toString() + ")))";

		}
		return constraint;
	}

	public String getAssertNotNullCondition(GenerateCVC1 cvc, Node n, String index) {

		// chaitra chenged here for extract type node - e.g. extract(year from date)
		if (n.getType().equalsIgnoreCase(Node.getExtractFuncType()))
			n = n.getLeft();

		if (n.getType().equalsIgnoreCase(Node.getColRefType())) {
			String dataType = n.getColumn().getCvcDatatype();
			Expr isNullExprs = null;

			// --- NEW LOGIC TO SUPPORT i1 ---
			Expr indexExpr;
			// Check if index is a number). If not, treat as symbolic variable.
			if (index.matches("-?\\d+")) {
				indexExpr = ctx.mkInt(index);
			} else {
				indexExpr = ctx.mkIntConst(index);
			}

			if (dataType.equalsIgnoreCase("int") || dataType.equalsIgnoreCase("real")) {
				String suffix = dataType.equalsIgnoreCase("Int") ? "Int" : "Real";
				if (ctxFuncDecls.containsKey("CHECKALL_NULL" + suffix)) {
					isNullExprs = ctx.mkNot(
							ctxFuncDecls.get("CHECKALL_NULL" + suffix)
									.apply(smtMap(n.getColumn(), indexExpr)));
				}
			} else if (dataType.equalsIgnoreCase("date") || dataType.equalsIgnoreCase("time")
					|| dataType.equalsIgnoreCase("timestamp")) {

				String colName = n.getOrgiColumn().getColumnName();
				// chaitra add valid date function
				if (ctxFuncDecls.containsKey("ISNULL_" + colName)) {
					{
						isNullExprs = ctx.mkNot(
								ctxFuncDecls.get("ISNULL_" + colName)
										.apply(smtMap(n.getColumn(), indexExpr)));
					}
				} else {
					if (ctxFuncDecls.containsKey("ISNULL_" + dataType)) {
						isNullExprs = ctx.mkNot(
								ctxFuncDecls.get("ISNULL_" + dataType)
										.apply(smtMap(n.getColumn(), indexExpr)));
					}
				}
			}

			return (isNullExprs != null) ? isNullExprs.toString() : "";
		}

		// @shalini : making this function recursive.
		if (n.getType().equalsIgnoreCase(Node.getBroNodeType())
				|| n.getType().equalsIgnoreCase(Node.getBaoNodeType())
				|| n.getType().equalsIgnoreCase(Node.getLikeNodeType())
				|| n.getType().equalsIgnoreCase(Node.getAndNodeType())
				|| n.getType().equalsIgnoreCase(Node.getOrNodeType())) {
			if (n.getOperator() != null && n.getLeft() != null && n.getRight() != null) {
				String leftNotNull = getAssertNotNullCondition(cvc, n.getLeft(), index);
				String rightNotNull = getAssertNotNullCondition(cvc, n.getRight(), index);
				// Combine both constraints
				String combined = "";
				if (!leftNotNull.equalsIgnoreCase("") && !rightNotNull.equalsIgnoreCase(""))
					combined = "(and " + leftNotNull + " " + rightNotNull + " )";
				else if (!leftNotNull.equalsIgnoreCase(""))
					combined = leftNotNull;
				else if (!rightNotNull.equalsIgnoreCase(""))
					combined = rightNotNull;
				return combined;
			} else
				return "";

		}

		return "";
	}

	public String getAssertNotNullConditionForSQTable(GenerateCVC1 cvc, Node n, String index, Table sqTable,
			int colIndex) {

		if (n.getType().equalsIgnoreCase(Node.getColRefType())) {
			String dataType = n.getColumn().getCvcDatatype();
			Expr isNullExprs = null;
			Expr column = genSelectTest2(cvc, sqTable.getTableName(), colIndex, "i1");

			if (dataType.equalsIgnoreCase("int") || dataType.equalsIgnoreCase("real")) {
				isNullExprs = ctx.mkNot(
						ctxFuncDecls
								.get("CHECKALL_NULL" + (dataType.equalsIgnoreCase("Int") ? "Int" : "Real"))
								.apply(column));
			} else if (dataType.equalsIgnoreCase("date") || dataType.equalsIgnoreCase("time")
					|| dataType.equalsIgnoreCase("timestamp")) {
				if (ctxFuncDecls.containsKey("ISNULL_" + n.getColumn().getColumnName()))
					isNullExprs = ctx.mkNot(
							ctxFuncDecls
									.get("ISNULL_" + n.getColumn().getColumnName())
									.apply(column));
				else if (ctxFuncDecls.containsKey("ISNULL_" + n.getColumn().getColumnName()))
					isNullExprs = ctx.mkNot(
							ctxFuncDecls
									.get("ISNULL_" + n.getColumn().getColumnName())
									.apply(column));
				else if (ctxFuncDecls.containsKey("ISNULL_" + n.getOriginalCol().getColumnName()))
					isNullExprs = ctx.mkNot(
							ctxFuncDecls
									.get("ISNULL_" + n.getOriginalCol().getColumnName())
									.apply(column));

			} else {
				isNullExprs = ctx.mkNot(
						ctxFuncDecls
								.get("ISNULL_" + dataType)
								.apply(column));
			}
			return isNullExprs.toString();

		}
		return "";
	}

	public String getAssertNotNullConditionForSQTable(GenerateCVC1 cvc, Node n, String index, Table sqTable,
			ArrayList<String> jtColumns, Vector<Table> tables,
			int colIndex) {

		// chaitra changed here for extract type - e.g. extract(year from date)
		if (n.getType().equalsIgnoreCase(Node.getExtractFuncType()))
			n = n.getLeft();

		if (n.getType().equalsIgnoreCase(Node.getColRefType())) {
			String dataType = n.getColumn().getCvcDatatype();
			Expr isNullExprs = null;
			Expr column = genSelectTest2(cvc, sqTable.getTableName(), colIndex, "i1");

			if (dataType.equalsIgnoreCase("int") || dataType.equalsIgnoreCase("real")) {
				isNullExprs = ctx.mkNot(
						ctxFuncDecls
								.get("CHECKALL_NULL" + (dataType.equalsIgnoreCase("Int") ? "Int" : "Real"))
								.apply(column));
			} else if (dataType.equalsIgnoreCase("date") || dataType.equalsIgnoreCase("time")
					|| dataType.equalsIgnoreCase("timestamp")) {
				if (ctxFuncDecls.containsKey("ISNULL_" + n.getColumn().getColumnName()))
					isNullExprs = ctx.mkNot(
							ctxFuncDecls
									.get("ISNULL_" + n.getColumn().getColumnName())
									.apply(column));
				else if (ctxFuncDecls.containsKey("ISNULL_" + n.getColumn().getColumnName()))
					isNullExprs = ctx.mkNot(
							ctxFuncDecls
									.get("ISNULL_" + n.getColumn().getColumnName())
									.apply(column));
				else if (ctxFuncDecls.containsKey("ISNULL_" + n.getOriginalCol().getColumnName()))
					isNullExprs = ctx.mkNot(
							ctxFuncDecls
									.get("ISNULL_" + n.getOriginalCol().getColumnName())
									.apply(column));
				// chaitra check valid for date

				Expr validExpr = null;
				if (dataType.equalsIgnoreCase("date"))
					validExpr = ctx.mkApp(ctxFuncDecls.get("isValidDATE"), column);
				else if (dataType.equalsIgnoreCase("time"))
					validExpr = ctx.mkApp(ctxFuncDecls.get("isValidTIME"), column);

				Expr checkExpr = null;
				if (n.getColumn().limitDefined())
					checkExpr = ctx.mkApp(ctxFuncDecls.get("check" + n.getColumn().getColumnName()), column);

				if (validExpr != null && checkExpr != null)
					isNullExprs = ctx.mkAnd(isNullExprs, validExpr, checkExpr);
				else if (validExpr != null)
					isNullExprs = ctx.mkAnd(isNullExprs, validExpr);
				else
					isNullExprs = ctx.mkAnd(isNullExprs);

				// Expr validExpr = ctx.mkApp(ctxFuncDecls.get("isValidDATE"), column);
				// Expr checkExpr =
				// ctx.mkApp(ctxFuncDecls.get("check"+n.getOriginalCol().getColumnName()),
				// column);
				// isNullExprs = ctx.mkAnd(isNullExprs, validExpr, checkExpr);

			} else {
				FuncDecl isNullDecl = null;
				if (n.getColumn() != null && ctxFuncDecls.containsKey("ISNULL_" + n.getColumn().getColumnName())) {
					isNullDecl = ctxFuncDecls.get("ISNULL_" + n.getColumn().getColumnName());
				} else if (n.getOriginalCol() != null
						&& ctxFuncDecls.containsKey("ISNULL_" + n.getOriginalCol().getColumnName())) {
					isNullDecl = ctxFuncDecls.get("ISNULL_" + n.getOriginalCol().getColumnName());
				} else if (ctxFuncDecls.containsKey("ISNULL_" + dataType)) {
					isNullDecl = ctxFuncDecls.get("ISNULL_" + dataType);
				}
				if (isNullDecl == null) {
					return "";
				}
				isNullExprs = ctx.mkNot(isNullDecl.apply(column));
			}
			return isNullExprs.toString();

		} else if (n.getType().equalsIgnoreCase(Node.getBroNodeType())
				|| n.getType().equalsIgnoreCase(Node.getBaoNodeType())
				|| n.getType().equalsIgnoreCase(Node.getLikeNodeType())
				|| n.getType().equalsIgnoreCase(Node.getAndNodeType())
				|| n.getType().equalsIgnoreCase(Node.getOrNodeType())) {
			if (n.getOperator() != null && n.getLeft() != null && n.getRight() != null) {
				// @shalini: finding column index for left node and right node and making the
				// function recursive.
				int leftIndex = -1;
				if (n.getLeft() != null && n.getLeft().getType() != null
						&& n.getLeft().getType().equalsIgnoreCase(Node.getColRefType())) {
					String leftTableName = n.getLeft().getTableNameNo() != null
							? n.getLeft().getTableNameNo().replaceAll("\\d", "").toLowerCase()
							: null;
					int colIndex1 = 0;
					for (Table table : tables) {
						if (table == null)
							continue;
						if (table.getTableName().equals(leftTableName)) {
							for (int i = colIndex1; i < colIndex1 + table.getNoOfColumn(); i++) {
								if (jtColumns.get(i).split("__")[1].replaceAll("\\d", "")
										.equalsIgnoreCase(
												n.getLeft().getColumn().getColumnName().replaceAll("\\d", ""))) {
									leftIndex = i;
									break;
								}
							}
							break;
						} else {
							colIndex1 += table.getNoOfColumn();
						}
					}
				}
				String leftNotNull = getAssertNotNullConditionForSQTable(cvc, n.getLeft(), index, sqTable, jtColumns,
						tables, leftIndex);
				int rightIndex = -1;
				if (n.getRight() != null && n.getRight().getType() != null
						&& n.getRight().getType().equalsIgnoreCase(Node.getColRefType())) {
					String rightTableName = n.getRight().getTableNameNo() != null
							? n.getRight().getTableNameNo().replaceAll("\\d", "").toLowerCase()
							: null;
					int colIndex2 = 0;
					for (Table table : tables) {
						if (table == null)
							continue;
						if (table.getTableName().equals(rightTableName)) {
							for (int i = colIndex2; i < colIndex2 + table.getNoOfColumn(); i++) {
								if (jtColumns.get(i).split("__")[1].replaceAll("\\d", "")
										.equalsIgnoreCase(
												n.getRight().getColumn().getColumnName().replaceAll("\\d", ""))) {
									rightIndex = i;
									break;
								}
							}
							break;
						} else {
							colIndex2 += table.getNoOfColumn();
						}
					}
				}
				String rightNotNull = getAssertNotNullConditionForSQTable(cvc, n.getRight(), index, sqTable, jtColumns,
						tables, rightIndex);
				// Combine both constraints
				String combined = "";
				if (!leftNotNull.equalsIgnoreCase("") && !rightNotNull.equalsIgnoreCase(""))
					combined = "(and " + leftNotNull + " " + rightNotNull + " )";
				else if (!leftNotNull.equalsIgnoreCase(""))
					combined = leftNotNull;
				else if (!rightNotNull.equalsIgnoreCase(""))
					combined = rightNotNull;
				return combined;
			}

		}
		return "";
	}

	public String getAssertNullConditionForSQTable(String dataType, Expr column, String idx, String columnName) {
		Expr nullExpr = null;

		if (dataType.equalsIgnoreCase("int") || dataType.equalsIgnoreCase("real") || dataType.equalsIgnoreCase("boolean")) {

			String funcName = dataType.equalsIgnoreCase("boolean")? "IS_NULL": "IS_NULL" + (dataType.equalsIgnoreCase("int") ? "Int" : "Real");
			if (ctxFuncDecls.containsKey(funcName))
				nullExpr = ctxFuncDecls.get(funcName).apply(column);
			if (ctxFuncDecls.containsKey("ISNULL_" + columnName))
				nullExpr = ctxFuncDecls.get("ISNULL_" + columnName).apply(column);
			else if (dataType.equalsIgnoreCase("INT"))
				return "(CHECKALL_NULLInt" + column.toString() + ")";
			else if (dataType.equalsIgnoreCase("REAL"))
				return "(CHECKALL_NULLReal" + column.toString() + ")";
			else if(columnName.contains("__") && ctxFuncDecls.containsKey("ISNULL_"+columnName.split("__")[1].replaceAll("\\d+$", ""))){
				nullExpr = ctxFuncDecls.get("ISNULL_"+columnName.split("__")[1].replaceAll("\\d+$", "")).apply(column);
			}

		} else if (dataType.equalsIgnoreCase("date") || dataType.equalsIgnoreCase("time")
				|| dataType.equalsIgnoreCase("timestamp")) {

			// Cleaned up the duplicate logic here
			if (ctxFuncDecls.containsKey("ISNULL_" + columnName)) {

				nullExpr = ctxFuncDecls.get("ISNULL_" + columnName).apply(column);
			}
			if(columnName.contains("__") && ctxFuncDecls.containsKey("ISNULL_"+columnName.split("__")[1].replaceAll("\\d+$", ""))){
				nullExpr = ctxFuncDecls.get("ISNULL_"+columnName.split("__")[1].replaceAll("\\d+$", "")).apply(column);
			}

		} else {

			if (ctxFuncDecls.containsKey("ISNULL_" + dataType)) {
				nullExpr = ctxFuncDecls.get("ISNULL_" + dataType).apply(column);
			}
		}

		return (nullExpr != null) ? nullExpr.toString() : "";
	}

	public String getMaxConstraint(GenerateCVC1 cvc, QueryBlockDetails queryBlock, Node n, Boolean isLeftConstraint) {
		String returnStr = "";
		if (isLeftConstraint) {

			String dataType = n.getLeft().getColumn().getCvcDatatype();

			if (dataType != null) {

				returnStr = "(declare-const MAX_" + n.getLeft().getColumn() + " " + dataType + ")\n";
				returnStr += "(assert (" + (n.getOperator().equals("/=") ? "not (= " : n.getOperator()) + " MAX_"
						+ n.getLeft().getColumn() + " " + n.getRight().toCVCString(10, queryBlock.getParamMap())
						+ ")) " + (n.getOperator().equals("/=") ? ")\n " : "\n");

				if (n.getOperator().equalsIgnoreCase("<") || n.getOperator().equalsIgnoreCase("<=")) {
					returnStr += "(assert (> MAX_" + n.getLeft().getColumn() + " 0))\n";
				} else if (n.getOperator().equalsIgnoreCase(">") || n.getOperator().equalsIgnoreCase(">=")) {
					returnStr += "(assert (< MAX_" + n.getLeft().getColumn() + " 10000000))\n";
				} else {
					returnStr += "\n"; // changes made by sunanda removed ")"
					// }
				}

			}

		} else {

			String dataType = n.getRight().getColumn().getCvcDatatype();
			if (dataType != null) {

				returnStr = "(declare-const MAX_" + n.getRight().getColumn() + " " + dataType + ")\n";
				returnStr = "(assert (" + n.getOperator() + " "
						+ n.getLeft().toCVCString(10, queryBlock.getParamMap()) + " MAX_" + n.getRight().getColumn()
						+ "))\n ";

				if (n.getOperator().equalsIgnoreCase("<") || n.getOperator().equalsIgnoreCase("<=")) {
					returnStr += "< x 10000000 )";
				} else if (n.getOperator().equalsIgnoreCase(">") || n.getOperator().equalsIgnoreCase(">=")) {
					returnStr += " > x  0)";
				} else {
					returnStr += "\n"; // changes made by sunanda removed ")"
				}
				// }

				returnStr += ")";
			}

		}
		return returnStr;
	}

	/**
	 * This method defines the solver function for getting MAX value constraint in
	 * CVC/SMT format.
	 * 
	 * @param cvc
	 * @param queryBlock
	 * @param n
	 * @return
	 */
	public String getMinConstraint(GenerateCVC1 cvc, QueryBlockDetails queryBlock, Node n, Boolean isLeftConstraint) {
		String returnStr = "";

		if (isLeftConstraint) {

			String dataType = n.getLeft().getColumn().getCvcDatatype();

			if (dataType != null) {

				returnStr = "(declare-const MIN_" + n.getLeft().getColumn() + " " + dataType + ")\n";

				returnStr += "(assert (" + (n.getOperator().equals("/=") ? "not (= " : n.getOperator()) + " MIN_"
						+ n.getLeft().getColumn() + " " + n.getRight().toCVCString(10, queryBlock.getParamMap())
						+ ")) " + (n.getOperator().equals("/=") ? ")\n " : "\n");
				if (n.getOperator().equalsIgnoreCase("<") || n.getOperator().equalsIgnoreCase("<=")) {
					returnStr += "(assert (> MIN_" + n.getLeft().getColumn() + " 0))\n";
				} else if (n.getOperator().equalsIgnoreCase(">") || n.getOperator().equalsIgnoreCase(">=")) {
					returnStr += "(assert (< MIN_" + n.getLeft().getColumn() + " 10000000))\n";
				} else {
					returnStr += "\n"; // changes made by sunanda removed ")"
				}
				// }

			}

		} else {

			String dataType = n.getRight().getColumn().getCvcDatatype();
			if (dataType != null) {

				//
				returnStr = "(declare-const MIN_" + n.getRight().getColumn() + " " + dataType + ")\n";
				returnStr += "(assert (" + n.getOperator() + " "
						+ n.getLeft().toCVCString(10, queryBlock.getParamMap()) + " MIN_" + n.getRight().getColumn()
						+ "))\n ";

				if (n.getOperator().equalsIgnoreCase(">") || n.getOperator().equalsIgnoreCase(">=")) {
					returnStr += "(assert (> MIN_" + n.getRight().getColumn() + " 0))\n";
				} else if (n.getOperator().equalsIgnoreCase("<") || n.getOperator().equalsIgnoreCase("<=")) {
					returnStr += "(assert (< MIN_" + n.getRight().getColumn() + " 10000000))\n";
				} else {
					returnStr += "\n"; // changes made by sunanda removed ")"
				}
				// }
			}

		}
		return returnStr;
	}

	/**
	 * This method is used to get the SMT / CVC constraints for aggregation function
	 * : AVG
	 * 
	 * @param cvc
	 * @param myCount
	 * @param groupNumber
	 * @param multiples
	 * @param totalRows
	 * @param agg
	 * @param offset
	 * @return
	 */
	public String getAVGConstraint(Integer myCount, Integer groupNumber, Integer multiples, Integer totalRows, Node agg,
			Integer offset) {

		String returnStr = "";
		int extras = totalRows % myCount;

		// Check if it is correct -
		// returnStr += " (/ (";
		String str = "";

		for (int i = 1, j = 0; i <= myCount; i++, j++) {

			String str1 = str;
			int tuplePos = (groupNumber) * myCount + i;

			if (i <= myCount && str1 != null && !str1.isEmpty()) {
				returnStr += "(+ " + str + " ";
			}
			String function = "SUM_REPLACE_NULL_" + agg.getColumn().getCvcDatatype();

			if (j < extras)
				str = "\n \t (* " + (multiples + 1) + " (" + function
						+ getMapNode(agg, (tuplePos + offset - 1) + "") + "))";
			else
				str = "\n \t (* " + (multiples) + " (" + function + getMapNode(agg, (tuplePos + offset - 1) + "")
						+ "))";

			if (i <= myCount && str1 != null && !str1.isEmpty()) {
				returnStr += str + ") ";
			}
			if (returnStr != null && !returnStr.isEmpty()) {
				str = returnStr;
				if (i != myCount) {
					returnStr = "";
				}
			}

			if (myCount == 1 && i == myCount) {
				returnStr = str;
			}

		}
		return "(/  \n " + returnStr + " \n" + myCount + ")";

	}

	/**
	 * 
	 * @param cvc
	 * @param myCount
	 * @param groupNumber
	 * @param multiples
	 * @param totalRows
	 * @param agg
	 * @param offset
	 * @return
	 */
	public String getSUMConstraint(Integer myCount, Integer groupNumber, Integer multiples, Integer totalRows, Node agg,
			Integer offset) {

		String returnStr = "";
		int extras = totalRows % myCount;

		// returnStr += "(assert ";
		String str = "";
		for (int i = 1, j = 0; i <= myCount; i++, j++) {

			String str1 = str;
			int tuplePos = (groupNumber) * myCount + i;

			if (i <= myCount && str1 != null && !str1.isEmpty()) {
				returnStr += "(+ " + str + " ";
			}
			String function = "SUM_REPLACE_NULL_" + agg.getColumn().getCvcDatatype();

			if (j < extras)
				str = "\n \t (* " + (multiples + 1) + " (" + function
						+ getMapNode(agg, (tuplePos + offset - 1) + "") + "))";
			else
				str = "\n \t (* " + (multiples) + " (" + function + getMapNode(agg, (tuplePos + offset - 1) + "")
						+ "))";

			if (i <= myCount && str1 != null && !str1.isEmpty()) {
				returnStr += str + ") ";
			}
			if (returnStr != null && !returnStr.isEmpty()) {
				str = returnStr;
				if (i != myCount) {
					returnStr = "";
				}
			}

			if (myCount == 1 && i == myCount) {
				returnStr = str;
			}

		}
		return returnStr + "\n";
	}

	/**
	 * This method is used to get the SMT / CVC constraints for aggregation function
	 * : MIN
	 * 
	 * @param innerTableNo
	 * @param groupNumber
	 * @param totalRows
	 * @param cvc
	 * @param af
	 * @return
	 */
	public String getMaxAssertConstraint(String innerTableNo, Integer groupNumber, int totalRows, GenerateCVC1 cvc,
			AggregateFunction af) {

		String returnStr = "";

		int myCount = cvc.getNoOfTuples().get(innerTableNo);
		int offset = cvc.getRepeatedRelNextTuplePos().get(innerTableNo)[1];

		String tableName = af.getAggExp().getColumn().getTable().getTableName();
		String columnName = af.getAggExp().getColumn().getColumnName();
		int index = af.getAggExp().getColumn().getTable().getColumnIndex(columnName);

		myCount = cvc.getNoOfTuples().get(innerTableNo);
		offset = cvc.getRepeatedRelNextTuplePos().get(innerTableNo)[1];
		String function = "MAX_REPLACE_NULL_" + af.getAggExp().getColumn().getCvcDatatype();
		String Nullfunction = "CHECKALL_NULL" + af.getAggExp().getColumn().getCvcDatatype(); // changes made by
																								// sunanda ("_"
																								// removed)

		returnStr += "\n(assert ";
		if (totalRows > 1)
			returnStr += "(and";
		for (int i = 1; i <= totalRows; i++) {
			int tuplePos = (groupNumber) * myCount + i;
			int row = tuplePos + offset - 1;
			returnStr += "\n ( >= MAX_" + columnName + " (" + function + "(" + tableName + "_" + columnName + index
					+ "(select O_" + tableName + " " + row + ")) ))";
		}
		if (totalRows > 1)
			returnStr += ")";
		returnStr += ")\n";

		returnStr += "\n(assert ";
		if (totalRows > 1)
			returnStr += "(or";
		for (int i = 1; i <= totalRows; i++) {
			int tuplePos = (groupNumber) * myCount + i;
			int row = tuplePos + offset - 1;
			returnStr += "\n ( = MAX_" + columnName + " (" + function + "(" + tableName + "_" + columnName + index
					+ "(select O_" + tableName + " " + row + ") )))";
		}
		if (totalRows > 1)
			returnStr += ")";
		returnStr += ")\n";

		returnStr += "\n(assert ";
		if (totalRows > 1)
			returnStr += "(and";
		for (int i = 1; i <= totalRows; i++) {
			int tuplePos = (groupNumber) * myCount + i;
			int row = tuplePos + offset - 1;
			if (totalRows > 1)
				returnStr += "\n (not (" + Nullfunction + "(" + tableName + "_" + columnName + index + " (select O_"
						+ tableName + " " + row + ")))) "; // changes made by sunanda "not" added
			else
				returnStr += "\n (not (" + Nullfunction + "(" + tableName + "_" + columnName + index + " (select O_"
						+ tableName + " " + row + "))) "; // changes made by sunanda "not" added
		}
		if (totalRows > 1)
			returnStr += "\n";
		returnStr += "))";

		return returnStr;

	}

	/**
	 * This method is used to get the SMT / CVC constraints for aggregation function
	 * : MIN
	 * 
	 * @param innerTableNo
	 * @param groupNumber
	 * @param totalRows
	 * @param cvc
	 * @param af
	 * @return
	 */
	public String getMinAssertConstraint(String innerTableNo, Integer groupNumber, int totalRows, GenerateCVC1 cvc,
			AggregateFunction af) {

		String returnStr = "";

		int myCount = cvc.getNoOfTuples().get(innerTableNo);
		int offset = cvc.getRepeatedRelNextTuplePos().get(innerTableNo)[1];

		String tableName = af.getAggExp().getColumn().getTable().getTableName();
		String columnName = af.getAggExp().getColumn().getColumnName();
		int index = af.getAggExp().getColumn().getTable().getColumnIndex(columnName);

		myCount = cvc.getNoOfTuples().get(innerTableNo);
		offset = cvc.getRepeatedRelNextTuplePos().get(innerTableNo)[1];
		String function = "MIN_REPLACE_NULL_" + af.getAggExp().getColumn().getCvcDatatype();
		String Nullfunction = "CHECKALL_NULL" + af.getAggExp().getColumn().getCvcDatatype(); // changes made by
																								// sunanda ("_"
																								// removed)

		returnStr += "\n(assert ";
		if (totalRows > 1)
			returnStr += "(and";
		for (int i = 1; i <= totalRows; i++) {
			int tuplePos = (groupNumber) * myCount + i;
			int row = tuplePos + offset - 1;
			returnStr += "\n ( >= MIN_" + columnName + " (" + function + "(" + tableName + "_" + columnName + index
					+ "(select O_" + tableName + " " + row + ")) ))";
		}
		if (totalRows > 1)
			returnStr += ")";
		returnStr += ")\n";

		returnStr += "\n(assert ";
		if (totalRows > 1)
			returnStr += "(or";
		for (int i = 1; i <= totalRows; i++) {
			int tuplePos = (groupNumber) * myCount + i;
			int row = tuplePos + offset - 1;
			returnStr += "\n ( = MIN_" + columnName + " (" + function + "(" + tableName + "_" + columnName + index
					+ "(select O_" + tableName + " " + row + ") )))";
		}
		if (totalRows > 1)
			returnStr += ")";
		returnStr += ")\n";

		returnStr += "\n(assert ";
		if (totalRows > 1)
			returnStr += "(and";
		for (int i = 1; i <= totalRows; i++) {
			int tuplePos = (groupNumber) * myCount + i;
			int row = tuplePos + offset - 1;
			if (totalRows > 1)
				returnStr += "\n (not (" + Nullfunction + "(" + tableName + "_" + columnName + index + " (select O_"
						+ tableName + " " + row + ")))) "; // changes made by sunanda "not" added
			else
				returnStr += "\n (not (" + Nullfunction + "(" + tableName + "_" + columnName + index + " (select O_"
						+ tableName + " " + row + "))) "; // changes made by sunanda "not" added
		}
		if (totalRows > 1)
			returnStr += "\n";
		returnStr += "))";

		return returnStr;

	}

	private static Expr getNotNullExpression(GenerateCVC1 cvc, Table currTable, Node caseNode, String w) {
		int baseTableColIndex = caseNode.getColumn().getTable().getColumnIndex(caseNode.getColumn().getColumnName());
		String colName = currTable.getTableName() + "_" + caseNode.getColumn().getTableName() + "__"
				+ caseNode.getColumn().getColumnName() + Integer.toString(baseTableColIndex);
		int joinTableColIndex = currTable.getColumnIndex(colName);

		Expr left = ConstraintGenerator.genSelectTest2(cvc, currTable.getTableName(), joinTableColIndex, w);

		String dataType = caseNode.getColumn().getCvcDatatype();
		Expr isNullExpr = null;

		if (dataType.equalsIgnoreCase("int") || dataType.equalsIgnoreCase("real")) {
			String suffix = dataType.equalsIgnoreCase("Int") ? "Int" : "Real";
			if (ConstraintGenerator.ctxFuncDecls.containsKey("CHECKALL_NULL" + suffix)) {
				isNullExpr = ConstraintGenerator.ctxFuncDecls.get("CHECKALL_NULL" + suffix).apply(left);
			}
		} else if (dataType.equalsIgnoreCase("date") || dataType.equalsIgnoreCase("time")
				|| dataType.equalsIgnoreCase("timestamp")) {
			String colName2 = caseNode.getOrgiColumn().getColumnName();
			if (ConstraintGenerator.ctxFuncDecls.containsKey("ISNULL_" + colName2)) {
				isNullExpr = ConstraintGenerator.ctxFuncDecls.get("ISNULL_" + colName2).apply(left);
			}
		} else {
			if (ConstraintGenerator.ctxFuncDecls.containsKey("ISNULL_" + dataType)) {
				isNullExpr = ConstraintGenerator.ctxFuncDecls.get("ISNULL_" + dataType).apply(left);
			}
		}

		return ConstraintGenerator.ctx.mkNot(isNullExpr);
	}

	// chaitra solve case conditions
	public static Expr processCaseNodeConstraints(GenerateCVC1 cvc, Table currTable, Node caseNode, String w) {
		if (caseNode == null) {
			return null;
		}
		if (caseNode.getType().equalsIgnoreCase("BRO NODE")) {
			int baseTableColIndex = caseNode.getLeft().getColumn().getTable()
					.getColumnIndex(caseNode.getLeft().getColumn().getColumnName());
			String colName = currTable.getTableName() + "_" + caseNode.getLeft().getColumn().getTableName() + "__"
					+ caseNode.getLeft().getColumn().getColumnName() + Integer.toString(baseTableColIndex);
			// String baseTableName =
			// caseNode.getLeft().getColumn().getTable().getTableName();
			// String colName = getColumnNameForJSQ(cvc, currTable.getTableName(),
			// baseTableName, caseNode.getLeft().getColumn().getColumnName());
			int joinTableColIndex = currTable.getColumnIndex(colName);

			String operator = caseNode.getOperator();

			Expr left = ConstraintGenerator.genSelectTest2(cvc, currTable.getTableName(), joinTableColIndex, w);

			Expr right = null;
			try {
				Integer.parseInt(caseNode.getRight().getStrConst());
				Double.parseDouble(caseNode.getRight().getStrConst());
				right = (Expr) ConstraintGenerator.mkConstOfType(caseNode.getRight().getStrConst(),
						caseNode.getLeft().getColumn());
			} catch (NumberFormatException e) {
				String paramVal = caseNode.getRight().getStrConst();
				paramVal = paramVal.replace("'", "");
				paramVal = paramVal.replace("%", "_p");
				paramVal = paramVal.replace("+", "_s");
				paramVal = paramVal.replace("-", "_m");
				paramVal = paramVal.replace("*", "_s");
				paramVal = paramVal.replace("_", "_u");
				paramVal = paramVal.replace(".", "_d");
				paramVal = paramVal.replace(" ", "_ub");
				right = (Expr) ConstraintGenerator.mkConstOfType(
						"_" + caseNode.getLeft().getColumn().getColumnName().replace("_", "_u") + "__" + paramVal,
						caseNode.getLeft().getColumn());

			}
			Expr notNullLeft = null;
			if (caseNode.getLeft().getType().equals(Node.getColRefType())) {

				notNullLeft = getNotNullExpression(cvc, currTable, caseNode.getLeft(), w);
				if (caseNode.getRight().getType().equals(Node.getColRefType()))
					return ConstraintGenerator.ctx.mkAnd(
							ConstraintGenerator.getComparisionConstraintsForOperator(operator, left, right),
							notNullLeft, getNotNullExpression(cvc, currTable, caseNode.getRight(), w));
				return ConstraintGenerator.ctx.mkAnd(
						ConstraintGenerator.getComparisionConstraintsForOperator(operator, left, right), notNullLeft);

			}
			return ConstraintGenerator.getComparisionConstraintsForOperator(operator, left, right);
		}

		Expr left = processCaseNodeConstraints(cvc, currTable, caseNode.getLeft(), w);
		Expr right = processCaseNodeConstraints(cvc, currTable, caseNode.getRight(), w);
		String operator = caseNode.getOperator();

		if (operator == "=" || operator == ">" || operator == "<") {
			return ConstraintGenerator.getComparisionConstraintsForOperator(operator, left, right);
		} else if (operator == "OR") {
			return ConstraintGenerator.ctx.mkOr(left, right);
		} else if (operator == "AND") {
			return ConstraintGenerator.ctx.mkAnd(left, right);
		} else {
			return null;
		}
	}

	public static Expr solveCaseContraints(GenerateCVC1 cvc, Node projectedNode, Table baseTable, int whenCol,
			int thenCol, CaseCondition elseCondition, int no_of_whens, int curr_when) {

		String operator;
		Expr left, right;

		if (curr_when == no_of_whens) {
			if (elseCondition == null)
				return null;
			operator = "=";
			left = ConstraintGenerator.genSelectTest2(cvc, baseTable.getTableName(), thenCol, "x!0");
			right = (Expr) ConstraintGenerator.mkConstOfType(elseCondition.getThenNode().getStrConst(),
					baseTable.getColumn(thenCol));
			Expr elseCond = ConstraintGenerator.getComparisionConstraintsForOperator(operator, left, right);
			return elseCond;
		}

		Expr elsecond = solveCaseContraints(cvc, projectedNode, baseTable, whenCol, thenCol, elseCondition, no_of_whens,
				curr_when + 1);

		CaseCondition whenCondition = projectedNode.getCaseExpression().getWhenConditionals().get(curr_when);

		Expr ifcond = processCaseNodeConstraints(cvc, baseTable, whenCondition.getWhenNode(), "x!0");

		operator = "=";
		left = ConstraintGenerator.genSelectTest2(cvc, baseTable.getTableName(), thenCol, "x!0");
		right = (Expr) ConstraintGenerator.mkConstOfType(whenCondition.getThenNode().getStrConst(),
				baseTable.getColumn(thenCol));
		Expr thencond = ConstraintGenerator.getComparisionConstraintsForOperator(operator, left, right);

		Expr itefull = ConstraintGenerator.ctx.mkITE(ifcond, thencond, elsecond);

		return itefull;
	}

	// chaitra solve case conditions end

	// chaitra solve arithmetic constraints

	public static Expr solveArithmeticConstraints(GenerateCVC1 cvc, Table currTable, int resultColIndex,
			Node arithNode) {

		Expr RHS = processArithmeticConstraints(cvc, currTable, arithNode, "x!0");

		Expr LHS = ConstraintGenerator.genSelectTest2(cvc, currTable.getTableName(), resultColIndex, "x!0");

		String operator = "=";

		Expr equation = ConstraintGenerator.getComparisionConstraintsForOperator(operator, LHS, RHS);

		return equation;
	}

	public static Expr processArithmeticConstraints(GenerateCVC1 cvc, Table currTable, Node arithNode, String w) {
		Expr constraints = null;

		if (arithNode == null) {
			return null;
		}

		// Handle CAST nodes: process inner expression then apply cast conversion
		if (arithNode.getType().equalsIgnoreCase(Node.getCastNodeType())) {
			Expr inner = processArithmeticConstraints(cvc, currTable, arithNode.getLeft(), w);
			String targetType = null;
			if (arithNode.getCastType() != null) {
				targetType = arithNode.getCastType().toString();
			}
			return handleCastExpression(targetType, inner);
		}
		if (arithNode.getType().equalsIgnoreCase("COLREF")) {
			int baseTableColIndex = arithNode.getColumn().getTable()
					.getColumnIndex(arithNode.getColumn().getColumnName());
			String colName = currTable.getTableName() + "_" + arithNode.getColumn().getTableName() + "__"
					+ arithNode.getColumn().getColumnName() + Integer.toString(baseTableColIndex);
			// String baseTableName = arithNode.getColumn().getTable().getTableName();
			// String colName = getColumnNameForJSQ(cvc, currTable.getTableName(),
			// baseTableName, arithNode.getColumn().getColumnName());
			int joinTableColIndex = currTable.getColumnIndex(colName);
			constraints = ConstraintGenerator.genSelectTest2(cvc, currTable.getTableName(), joinTableColIndex, "x!0");
			return constraints;
		} else if (arithNode.getType().equalsIgnoreCase("VALUE")) {
			constraints = (Expr) ConstraintGenerator.mkConstOfType(arithNode.getStrConst(), null);
			return constraints;
		} else if (arithNode.getType().equalsIgnoreCase("AGGREGATE NODE")) {
			String colName = "";
			if (arithNode.getColumn() == null)
				colName = getColumnNameForGSQ(currTable.getTableName(),
						arithNode.getAgg().getAggExp().getTable().getTableName(), arithNode.getAgg().getFunc(),
						arithNode.getAgg().getAggExp().getColumn().getColumnName());
			else
				colName = getColumnNameForGSQ(currTable.getTableName(), arithNode.getColumn().getTable().getTableName(),
						arithNode.getAgg().getFunc(), arithNode.getColumn().getColumnName());

			int joinTableColIndex = currTable.getColumnIndex(colName);
			constraints = ConstraintGenerator.genSelectTest2(cvc, currTable.getTableName(), joinTableColIndex, "x!0");
			return constraints;
		}

		Expr leftExpr = processArithmeticConstraints(cvc, currTable, arithNode.getLeft(), w);
		Expr rightExpr = processArithmeticConstraints(cvc, currTable, arithNode.getRight(), w);
		String operator = arithNode.getOperator();

		constraints = ConstraintGenerator.getArithmeticConstraintsForOperator(operator, leftExpr, rightExpr);

		return constraints;
	}

	// chaitra solve arithmetic constraints end

	public String generateCVCForNullCheckInHaving() {

		String returnStr = "";
		String[] Datatypes = new String[] { "Real", "Int" };

		for (String Datatype : Datatypes) {
			String columnName = Datatype + "col";
			Expr[] nullArr = null;
			ArithExpr nullVal = null;
			ArithExpr zeroVal = null;
			Sort type = null;

			if (Datatype.endsWith("Real")) {
				nullArr = new Expr[] { ctx.mkRealConst(columnName) };
				type = ctx.getRealSort();
				nullVal = ConstraintGenerator.realNull;
				zeroVal = ctx.mkReal("0.0");
			} else { // Int case
				nullArr = new Expr[] { ctx.mkIntConst(columnName) };
				type = ctx.getIntSort();
				nullVal = ConstraintGenerator.intNull;
				zeroVal = ctx.mkInt(0);
			}

			String checkAllNullName = "CHECKALL_NULL" + Datatype;
			FuncDecl checkAllNull = ctx.mkFuncDecl(checkAllNullName, type, ctx.mkBoolSort());
			ctxFuncDecls.put(checkAllNullName, checkAllNull);

			// String maxRepNullName = "MAX_REPLACE_NULL_" + Datatype;
			// FuncDecl maxRepNull = ctx.mkFuncDecl(maxRepNullName, type, type);
			// ctxFuncDecls.put(maxRepNullName, maxRepNull);

			// String sumRepNullName = "SUM_REPLACE_NULL_" + Datatype;
			// FuncDecl sumRepNull = ctx.mkFuncDecl(sumRepNullName, type, type);
			// ctxFuncDecls.put(sumRepNullName, sumRepNull);

			// String minRepNullName = "MIN_REPLACE_NULL_" + Datatype;
			// FuncDecl minRepNull = ctx.mkFuncDecl(minRepNullName, type, type);
			// ctxFuncDecls.put(minRepNullName, minRepNull);

			// CHECKALL_NULL_*
			Expr checkAllNullCall = checkAllNull.apply(nullArr);
			Expr funcBody = ctx.mkEq(nullArr[0], nullVal);
			Expr quantBody = ctx.mkEq(checkAllNullCall, funcBody);
			Expr funcQuantifier = ctx.mkForall(nullArr, quantBody, 1, null, null, null, null);
			returnStr += "\n" + checkAllNull.toString() + "\n(assert " + funcQuantifier.toString() + ")\n";

		}
		return returnStr;
	}

}
