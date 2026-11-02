package killMutations;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Vector;
import java.util.concurrent.TimeoutException;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.microsoft.z3.ArithExpr;
import com.microsoft.z3.Expr;

import GenConstraints.GenConstraints;
import generateConstraints.ConstraintGenerator;
import generateConstraints.GenerateCommonConstraintsForQuery;
import generateConstraints.GetSolverHeaderAndFooter;
import parsing.Column;
import parsing.ConjunctQueryStructure;
import parsing.MutationStructure;
import parsing.Node;
import parsing.Table;
import testDataGen.CountEstimationRelated;
import testDataGen.GenerateCVC1;
import testDataGen.QueryBlockDetails;
import testDataGen.RelatedToPreprocessing;
import util.Configuration;
import util.Utilities;

/**
 * This class generates data sets for the original query. This data set is
 * intended tom give non empty result for the original query
 * 
 * @author mahesh
 *
 */
public class GenerateDataForOriginalQuery {

	private static Logger logger = Logger.getLogger(GenerateDataForOriginalQuery.class.getName());

	/**
	 * Generates data set for the original query
	 * 
	 * @param cvc
	 */
	public static boolean generateDataForOriginalQuery(GenerateCVC1 cvc, String mutationType) throws Exception {

		logger.log(Level.INFO, "\n----------------------------------");
		logger.log(Level.INFO, "GENERATE DATA FOR ORIGINAL QUERY: ");
		logger.log(Level.INFO, "---------------------------------\n");
		try {
			/**
			 * Initialize the data structures for generating the data to kill this mutation
			 */
			cvc.inititalizeForDatasetQs();
			/**
			 * get the tuple assignment for this query
			 * If no possible assignment then not possible to kill this mutation
			 */
			if (GenerateCVC1.tupleAssignmentForQuery(cvc) == false)
				return false;

			/** set the type of mutation we are trying to kill */
			cvc.setTypeOfMutation(mutationType);

			GetSolverHeaderAndFooter.generateSolver_Header(cvc, false); // testcode by Sunanda for IS_NULL

			GenerateCommonConstraintsForQuery.generateNullandDBConstraints(cvc, false);

			if (Configuration.tempJoins.equalsIgnoreCase("true")) {
				// step 1 and step 2 : Sunanda
				// Build Correlation Map
				QueryBlockDetails.ProcessProjectedColumnsFromFClauseSQ(cvc, cvc.getOuterBlock());
				QueryBlockDetails.TraverseNestedQueryStrcuture(cvc, cvc.getqStructure()); // have to add some details for set operator queries
				// Calculates the level at which correlation conditions to be processed
				// considering Exists and Not Exists types
				QueryBlockDetails.setLevelForProcessingCorrelationCondition(cvc);
			}

		if(Configuration.getProperty("printSQL").equalsIgnoreCase("true")){
				String str = cvc.printSQL(cvc.outerBlock, null);
				System.out.println(str);
				String filePath = Configuration.getProperty("printDir") +"/"+cvc.getQueryId()+ "/printSQL.txt";
				Utilities.writeFile(filePath, str, true);
				filePath = Configuration.getProperty("printDir") +"/"+cvc.getQueryId()+ "/diff.txt";
				String diff = GenConstraints.PrintDiffForSpecificMutation(null);
				Utilities.writeFile(filePath, diff, true);
				return true;
			}

			/**Get the constraints for all the blocks of the query  */
			cvc.getConstraints().add( QueryBlockDetails.getConstraintsForQueryBlock(cvc) );

			/** Call the method for the data generation */
			return GenerateCommonConstraintsForQuery.generateDataSetForConstraints(cvc, false);
		} catch (TimeoutException e) {
			logger.log(Level.SEVERE, e.getMessage(), e);
			throw e;
		} catch (Exception e) {
			logger.log(Level.SEVERE, e.getMessage(), e);
			throw e;
		}
	}

	// chaitra generate data for case mutants function
	public static boolean generateDataForCaseMutants(GenerateCVC1 cvc, MutationStructure mutation){
		logger.log(Level.INFO, "\n----------------------------------");
		logger.log(Level.INFO, "GENERATE DATA TO KILL CASE MUTANTS: ");
		logger.log(Level.INFO, "---------------------------------\n");
		try {
			cvc.inititalizeForDatasetQs();
			cvc.setTypeOfMutation(mutation.getMutationType());
			GetSolverHeaderAndFooter.generateSolver_Header(cvc, false);
			GenerateCommonConstraintsForQuery.generateNullandDBConstraints(cvc, false);
			cvc.getOuterBlock().getProjectedCols().set(0, (Node)mutation.getMutationNode());
			cvc.getConstraints().add( QueryBlockDetails.getConstraintsForQueryBlock(cvc) );
			return GenerateCommonConstraintsForQuery.generateDataSetForConstraints(cvc, false);
		} catch(Exception e){
			cvc.getOuterBlock().getProjectedCols().add((Node)mutation.getMutationNode());
			// System.out.println(e);
			e.printStackTrace();
		}
		return false;
	}
	// chaitra generate data for case mutants function

	public static boolean modifyAndGenerateMutantForSetOperators(GenerateCVC1 cvc, String oldSetOperator, int oldIsAll , MutationStructure mutation, int oneOrZero) throws Exception {

		logger.log(Level.INFO, "\n----------------------------------");
		logger.log(Level.INFO, "GENERATE DATA FOR ORIGINAL QUERY: ");
		logger.log(Level.INFO, "---------------------------------\n");
		try {

			

			cvc.inititalizeForDatasetQs();

			cvc.clearConstraints();

			if (GenerateCVC1.tupleAssignmentForQuery(cvc) == false)
				return false;

			cvc.setTypeOfMutation(mutation.getMutationType());
			
			cvc.oneOrZero =oneOrZero;

			if( (mutation.getQueryBlock().setOperatorString=="INTERSECT" || mutation.getQueryBlock().setOperatorString=="EXCEPT") && mutation.getQueryBlock().isAll==1)
			{
				//cvc.addMoreTuples();
			}


			GetSolverHeaderAndFooter.generateSolver_Header(cvc, false); 

			GenerateCommonConstraintsForQuery.generateNullandDBConstraints(cvc, false);

			
			if (Configuration.tempJoins.equalsIgnoreCase("true")) {
				QueryBlockDetails.ProcessProjectedColumnsFromFClauseSQ(cvc, cvc.getOuterBlock());
				QueryBlockDetails.TraverseNestedQueryStrcuture(cvc, cvc.getqStructure()); 
				QueryBlockDetails.setLevelForProcessingCorrelationCondition(cvc);
			}

			if(Configuration.getProperty("printSQL").equalsIgnoreCase("true")){
				String str = cvc.printSQL(cvc.outerBlock, null);
				System.out.println(str);
				String filePath = Configuration.getProperty("printDir") +"/"+cvc.getQueryId()+ "/printSQL.txt";
				Utilities.writeFile(filePath, str, true);
				filePath = Configuration.getProperty("printDir") +"/"+cvc.getQueryId()+ "/diff.txt";
				String diff = GenConstraints.PrintDiffForSpecificMutation(null);
				Utilities.writeFile(filePath, diff, true);
				return true;
			}



			/**Get the constraints for all the blocks of the query  */
			cvc.getConstraints().add( QueryBlockDetails.getConstraintsForQueryBlock(cvc) );

			cvc.oneOrZero = -1;

			String mutOp = (String) mutation.getMutationNode();
			
			//now add extra constraints if needed
			if( (oldSetOperator.equalsIgnoreCase("UNION") && mutOp.equalsIgnoreCase("INTERSECT")) ||
			 	(oldSetOperator.equalsIgnoreCase("UNION") && mutOp.equalsIgnoreCase("EXCEPT"))  ||
				(oldSetOperator.equalsIgnoreCase("UNION") && mutOp.equalsIgnoreCase("EXCEPT ALL") ) ||

				(oldSetOperator.equalsIgnoreCase("INTERSECT") && oldIsAll==0 && mutOp.equalsIgnoreCase("UNION") ) ||

				(oldSetOperator.equalsIgnoreCase("EXCEPT") && oldIsAll==0 && mutOp.equalsIgnoreCase("UNION"))  ||
				
				(oldSetOperator.equalsIgnoreCase("UNION ALL") && mutOp.equalsIgnoreCase("EXCEPT ALL")) ||

				(oldSetOperator.equalsIgnoreCase("INTERSECT") && oldIsAll==1 && mutOp.equalsIgnoreCase("EXCEPT ALL")) ||

				(oldSetOperator.equalsIgnoreCase("EXCEPT") && oldIsAll==1 && mutOp.equalsIgnoreCase("UNION")) ||

				(oldSetOperator.equalsIgnoreCase("EXCEPT") && oldIsAll==1 && mutOp.equalsIgnoreCase("UNION ALL"))
				
				)
			{
				cvc.getConstraints().add( QueryBlockDetails.addExtraConstaints(cvc, mutation.getQueryBlock().baseSQ, oldSetOperator, oldIsAll, mutOp) );
			}

			/** Call the method for the data generation */
			return GenerateCommonConstraintsForQuery.generateDataSetForConstraints(cvc, false);

		} catch (TimeoutException e) {
			logger.log(Level.SEVERE, e.getMessage(), e);
			throw e;
		} catch (Exception e) {
			logger.log(Level.SEVERE, e.getMessage(), e);
			throw e;
		}
		finally{
			if( (mutation.getQueryBlock().setOperatorString=="INTERSECT" || mutation.getQueryBlock().setOperatorString=="EXCEPT") && mutation.getQueryBlock().isAll==1)
			{
				cvc.removeExtraTuples();
			}
			
		}
	}


	public static void findBlock(GenerateCVC1 cvc, QueryBlockDetails qb, MutationStructure mutation) throws Exception {

		if(qb.getLevel()==mutation.getQueryBlock().getLevel())
		{
			String oldSetOperator = qb.setOperatorString;
			int oldIsAll = qb.isAll;

			if(oldSetOperator=="UNION")
			{
				//union vs union all
				cvc.setCVCStr("");
				qb.setOperatorString="UNION ALL";
				mutation.setmutationNode("UNION ALL");
				mutation.setIsExpired(false);
				modifyAndGenerateMutantForSetOperators(cvc, oldSetOperator, oldIsAll, mutation, 1);
				mutation.setIsExpired(true);
				
				//union vs intersect
				cvc.setCVCStr("");
				qb.setOperatorString="UNION";
				mutation.setmutationNode("INTERSECT");
				mutation.setIsExpired(false);
				modifyAndGenerateMutantForSetOperators(cvc, oldSetOperator, oldIsAll, mutation, 0);
				mutation.setIsExpired(true);

				//union vs intersect all
				cvc.setCVCStr("");
				qb.setOperatorString="INTERSECT";
				qb.isAll=1;
				mutation.setmutationNode("INTERSECT ALL");
				mutation.setIsExpired(false);
				modifyAndGenerateMutantForSetOperators(cvc, oldSetOperator, oldIsAll, mutation,0);
				qb.isAll=0;
				mutation.setIsExpired(true);


				//union vs except
				cvc.setCVCStr("");
				qb.setOperatorString="UNION";
				mutation.setmutationNode("EXCEPT");
				mutation.setIsExpired(false);
				modifyAndGenerateMutantForSetOperators(cvc, oldSetOperator, oldIsAll, mutation, 0);
				mutation.setIsExpired(true);

				//union vs except all
				cvc.setCVCStr("");
				qb.setOperatorString="UNION";
				mutation.setmutationNode("EXCEPT ALL");
				mutation.setIsExpired(false);
				modifyAndGenerateMutantForSetOperators(cvc, oldSetOperator, oldIsAll, mutation, 0);
				mutation.setIsExpired(true);
				
			}
			if(oldSetOperator=="INTERSECT" && oldIsAll==0)
			{
				//intersect vs union
				cvc.setCVCStr("");
				qb.setOperatorString="UNION";
				mutation.setmutationNode("UNION");
				mutation.setIsExpired(false);
				modifyAndGenerateMutantForSetOperators(cvc, oldSetOperator, oldIsAll, mutation, 0);
				mutation.setIsExpired(true);



				//intersect vs except
				cvc.setCVCStr("");
				qb.setOperatorString="EXCEPT";
				mutation.setmutationNode("EXCEPT");
				mutation.setIsExpired(false);
				modifyAndGenerateMutantForSetOperators(cvc, oldSetOperator, oldIsAll, mutation, 0);
				mutation.setIsExpired(true);

				//intersect vs union all
				cvc.setCVCStr("");
				qb.setOperatorString="UNION ALL";
				mutation.setmutationNode("UNION ALL");
				mutation.setIsExpired(false);
				modifyAndGenerateMutantForSetOperators(cvc, oldSetOperator, oldIsAll, mutation, 1);
				mutation.setIsExpired(true);

				//intersect vs intersect all
				cvc.setCVCStr("");
				qb.setOperatorString="INTERSECT";
				qb.isAll=1;
				mutation.setmutationNode("INTERSECT ALL");
				mutation.setIsExpired(false);
				modifyAndGenerateMutantForSetOperators(cvc, oldSetOperator, oldIsAll, mutation, 1);
				qb.isAll=0;
				mutation.setIsExpired(true);

				//intersect vs except all
				cvc.setCVCStr("");
				qb.setOperatorString="EXCEPT";
				qb.isAll=1;
				mutation.setmutationNode("EXCEPT ALL");
				mutation.setIsExpired(false);
				modifyAndGenerateMutantForSetOperators(cvc, oldSetOperator, oldIsAll, mutation, 0);
				qb.isAll=0;
				mutation.setIsExpired(true);
				 

			}
			if(oldSetOperator=="EXCEPT" && oldIsAll==0)
			{
				//except vs union 
				cvc.setCVCStr("");
				qb.setOperatorString="UNION";
				mutation.setmutationNode("UNION");
				mutation.setIsExpired(false);
				modifyAndGenerateMutantForSetOperators(cvc, oldSetOperator, oldIsAll, mutation, 0);
				mutation.setIsExpired(true);

				//except vs intersect
				cvc.setCVCStr("");
				qb.setOperatorString="EXCEPT";
				mutation.setmutationNode("INTERSECT");
				mutation.setIsExpired(false);
				modifyAndGenerateMutantForSetOperators(cvc, oldSetOperator, oldIsAll, mutation, 0);
				mutation.setIsExpired(true);

				//except vs union all
				cvc.setCVCStr("");
				qb.setOperatorString="UNION ALL";
				mutation.setmutationNode("UNION ALL");
				mutation.setIsExpired(false);
				modifyAndGenerateMutantForSetOperators(cvc, oldSetOperator, oldIsAll, mutation, 1);
				mutation.setIsExpired(true);

				//except vs intersect all
				cvc.setCVCStr("");
				qb.setOperatorString="EXCEPT";
				mutation.setmutationNode("INTERSECT ALL");
				mutation.setIsExpired(false);
				modifyAndGenerateMutantForSetOperators(cvc, oldSetOperator, oldIsAll, mutation, 0);
				mutation.setIsExpired(true);

				//except vs except all
				cvc.setCVCStr("");
				qb.setOperatorString="EXCEPT";
				qb.isAll=1;
				mutation.setmutationNode("EXCEPT ALL");
				mutation.setIsExpired(false);
				modifyAndGenerateMutantForSetOperators(cvc, oldSetOperator, oldIsAll, mutation, 1);
				mutation.setIsExpired(true);


			}
			if(oldSetOperator=="UNION ALL")
			{
				//union all vs union
				cvc.setCVCStr("");
				qb.setOperatorString="UNION ALL";
				mutation.setmutationNode("UNION");
				mutation.setIsExpired(false);
				modifyAndGenerateMutantForSetOperators(cvc, oldSetOperator, oldIsAll, mutation, 1);
				mutation.setIsExpired(true);

				//union all vs intersect
				cvc.setCVCStr("");
				qb.setOperatorString="UNION ALL";
				mutation.setmutationNode("INTERSECT");
				mutation.setIsExpired(false);
				modifyAndGenerateMutantForSetOperators(cvc, oldSetOperator, oldIsAll, mutation, 1);
				mutation.setIsExpired(true);

				//union all vs except
				cvc.setCVCStr("");
				qb.setOperatorString="UNION ALL";
				mutation.setmutationNode("EXCEPT");
				mutation.setIsExpired(false);
				modifyAndGenerateMutantForSetOperators(cvc, oldSetOperator, oldIsAll, mutation, 1);
				mutation.setIsExpired(true);

				//union all vs intersect all
				cvc.setCVCStr("");
				qb.setOperatorString="EXCEPT";
				mutation.setmutationNode("INTERSECT ALL");
				mutation.setIsExpired(false);
				modifyAndGenerateMutantForSetOperators(cvc, oldSetOperator, oldIsAll, mutation, 0);
				mutation.setIsExpired(true);

				//union all vs except all
				cvc.setCVCStr("");
				qb.setOperatorString="UNION ALL";
				mutation.setmutationNode("EXCEPT ALL");
				mutation.setIsExpired(false);
				modifyAndGenerateMutantForSetOperators(cvc, oldSetOperator, oldIsAll, mutation, 0);
				mutation.setIsExpired(true);

			}
			if(oldSetOperator=="INTERSECT" && oldIsAll==1)
			{
				//intersect all vs union 
				cvc.setCVCStr("");
				qb.setOperatorString="INTERSECT";
				qb.isAll=1;
				mutation.setmutationNode("UNION");
				mutation.setIsExpired(false);
				modifyAndGenerateMutantForSetOperators(cvc, oldSetOperator, oldIsAll, mutation, 1);
				mutation.setIsExpired(true);

				//intersect all vs intersect 
				cvc.setCVCStr("");
				qb.setOperatorString="INTERSECT";
				qb.isAll=1;
				mutation.setmutationNode("INTERSECT");
				mutation.setIsExpired(false);
				modifyAndGenerateMutantForSetOperators(cvc, oldSetOperator, oldIsAll, mutation, 1);
				mutation.setIsExpired(true);

				//intersect all vs except
				cvc.setCVCStr("");
				qb.setOperatorString="INTERSECT";
				qb.isAll=0;
				mutation.setmutationNode("EXCEPT");
				mutation.setIsExpired(false);
				modifyAndGenerateMutantForSetOperators(cvc, oldSetOperator, oldIsAll, mutation, 0);
				qb.isAll=1;
				mutation.setIsExpired(true);

				//intersect all vs union all
				cvc.setCVCStr("");
				qb.setOperatorString="UNION ALL";
				qb.isAll=0;
				mutation.setmutationNode("UNION ALL");
				mutation.setIsExpired(false);
				modifyAndGenerateMutantForSetOperators(cvc, oldSetOperator, oldIsAll, mutation, 0);
				qb.isAll=1;
				mutation.setIsExpired(true);

				//intersect all vs except all
				cvc.setCVCStr("");
				qb.setOperatorString="EXCEPT";
				qb.isAll=1;
				mutation.setmutationNode("EXCEPT ALL");
				mutation.setIsExpired(false);
				modifyAndGenerateMutantForSetOperators(cvc, oldSetOperator, oldIsAll, mutation, 0);
				mutation.setIsExpired(true);


			}
			if(oldSetOperator=="EXCEPT" && oldIsAll==1)
			{
				//except all vs union
				cvc.setCVCStr("");
				qb.setOperatorString="UNION";
				qb.isAll=0;
				mutation.setmutationNode("UNION");
				mutation.setIsExpired(false);
				modifyAndGenerateMutantForSetOperators(cvc, oldSetOperator, oldIsAll, mutation, 0);
				qb.isAll=1;
				mutation.setIsExpired(true);

				//except all vs intersect
				cvc.setCVCStr("");
				qb.setOperatorString="INTERSECT";
				qb.isAll=0;
				mutation.setmutationNode("INTERSECT");
				mutation.setIsExpired(false);
				modifyAndGenerateMutantForSetOperators(cvc, oldSetOperator, oldIsAll, mutation, 0);
				qb.isAll=1;
				mutation.setIsExpired(true);

				//except all vs except
				cvc.setCVCStr("");
				qb.setOperatorString="EXCEPT";
				qb.isAll=1;
				mutation.setmutationNode("EXCEPT");
				mutation.setIsExpired(false);
				modifyAndGenerateMutantForSetOperators(cvc, oldSetOperator, oldIsAll, mutation, 1);
				mutation.setIsExpired(true);

				//except all vs union all
				cvc.setCVCStr("");
				qb.setOperatorString="UNION";
				qb.isAll=0;
				mutation.setmutationNode("UNION ALL");
				mutation.setIsExpired(false);
				modifyAndGenerateMutantForSetOperators(cvc, oldSetOperator, oldIsAll, mutation, 0);
				qb.isAll=1;
				mutation.setIsExpired(true);


				//except all vs intersect all
				cvc.setCVCStr("");
				qb.setOperatorString="INTERSECT";
				qb.isAll=0;
				mutation.setmutationNode("INTERSECT ALL");
				mutation.setIsExpired(false);
				modifyAndGenerateMutantForSetOperators(cvc, oldSetOperator, oldIsAll, mutation, 0);
				qb.isAll=1;
				mutation.setIsExpired(true);

			}

			
			

			//set it back to original
			qb.setOperatorString = oldSetOperator;

		}
		else
		{
			findBlock(cvc, qb.getLeftBlockDetails(), mutation);
			findBlock(cvc, qb.getRightBlockDetails(), mutation);
		}
		

	}

	public static boolean generateDataForQueryMutantsForWindow(GenerateCVC1 cvc, MutationStructure mutation) throws Exception {
logger.log(Level.INFO, "\n----------------------------------");
		logger.log(Level.INFO, "GENERATE DATA TO KILL WINDOW MUTANTS: ");
		logger.log(Level.INFO, "---------------------------------\n");
		try {
			cvc.outerBlock.isWindow=1;
			List<Object> retrievedPair = (List<Object>) mutation.getMutationLoc();
			Node curNode = (Node) retrievedPair.get(0);
			cvc.isWindowMutant = (Integer) retrievedPair.get(1);
			/**
			 * Initialize the data structures for generating the data to kill this mutation
			 */
			cvc.inititalizeForDatasetQs();
			/**
			 * get the tuple assignment for this query
			 * If no possible assignment then not possible to kill this mutation
			 */
			if (GenerateCVC1.tupleAssignmentForQuery(cvc) == false)
				return false;

			/** set the type of mutation we are trying to kill */
			cvc.setTypeOfMutation(mutation.getMutationType());

			GetSolverHeaderAndFooter.generateSolver_Header(cvc, false); // testcode by Sunanda for IS_NULL

			GenerateCommonConstraintsForQuery.generateNullandDBConstraints(cvc, false);

			if (Configuration.tempJoins.equalsIgnoreCase("true")) {
				// step 1 and step 2 : Sunanda
				// Build Correlation Map
				QueryBlockDetails.ProcessProjectedColumnsFromFClauseSQ(cvc, cvc.getOuterBlock());
				QueryBlockDetails.TraverseNestedQueryStrcuture(cvc, cvc.getqStructure()); // have to add some details for set operator queries
				// Calculates the level at which correlation conditions to be processed
				// considering Exists and Not Exists types
				QueryBlockDetails.setLevelForProcessingCorrelationCondition(cvc);
			}

			if(Configuration.getProperty("printSQL").equalsIgnoreCase("true")){
				String str = cvc.printSQL(cvc.outerBlock, null);
				System.out.println(str);
				String filePath = Configuration.getProperty("printDir") +"/"+cvc.getQueryId()+ "/printSQL.txt";
				Utilities.writeFile(filePath, str, true);
				filePath = Configuration.getProperty("printDir") +"/"+cvc.getQueryId()+ "/diff.txt";
				String diff = GenConstraints.PrintDiffForSpecificMutation(null);
				Utilities.writeFile(filePath, diff, true);
				return true;
			}

			
			/**Get the constraints for all the blocks of the query  */
			cvc.getConstraints().add( QueryBlockDetails.getConstraintsForQueryBlock(cvc) );

			if(cvc.isWindowMutant==1)
			{
				String constraintString = "";
				if(mutation.getQueryBlock().isWindow==1)
				{
					//rank vs dense rank
					//dense rank vs rank
					for(Node x : mutation.getQueryBlock().getProjectedCols())
					{
						if(x.getNodeType().equalsIgnoreCase("ANALYTICAL NODE") && (x.getWindowAggString().equalsIgnoreCase("rank")  || x.getWindowAggString().equalsIgnoreCase("dense_rank") ) && x.partitionByNodes.size()==0)
						{
							String projColumnName = (x.getColumn()==null ? (x.orderNodesInWindow.size()>0 ? x.orderNodesInWindow.get(0).getColumn().getColumnName() : "" ): x.getColumn().getColumnName() );
							int currentLevel = mutation.getQueryBlock().getLevel();

							if(!projColumnName.equalsIgnoreCase((curNode.getColumn()==null ? (curNode.orderNodesInWindow.size()>0 ? curNode.orderNodesInWindow.get(0).getColumn().getColumnName() : "" ): curNode.getColumn().getColumnName() )))
								continue;

							for(int i=0 ; i<cvc.getTableMap().getSQTableByName("JSQ"+String.valueOf(currentLevel)).getColumns().size() ; i++)
							{
								String joinTable = "JSQ"+String.valueOf(currentLevel);
								String currentColumnName = cvc.getTableMap().getSQTableByName(joinTable).getColumn(i).getColumnName();

								if(currentColumnName.contains(projColumnName))
								{

									int currentIndex = cvc.getTableMap().getSQTableByName(joinTable).getColumnIndex(currentColumnName);
									Expr expr1 = ConstraintGenerator.genSelectTest(cvc,joinTable, currentIndex , 1);
									Expr expr2 = ConstraintGenerator.genSelectTest(cvc,joinTable, currentIndex , 2);
									Expr expr3 = ConstraintGenerator.genSelectTest(cvc,joinTable, currentIndex , 3);

									String ass = "(assert (and ";
									constraintString+= ass + "\n( = " + expr1.toString() + expr2.toString() +")\n";
									constraintString+= "\n (not ( = " + expr1.toString() + expr3.toString() +") )\n";
									constraintString+=" ))";

								}
							}
						}
					}
					if(!constraintString.equalsIgnoreCase(""))
					{
						cvc.getConstraints().add( constraintString );
						return GenerateCommonConstraintsForQuery.generateDataSetForConstraints(cvc, false);
					}
					

				}
			}
			else if(cvc.isWindowMutant==2) //missing attribute in order by, the second order is missing
			{
				String constraintString = "";
				if(curNode.orderNodesInWindow.size()==2)
				{
					Column firstCol = (curNode.getColumn()==null ? (curNode.orderNodesInWindow.size()>0 ? curNode.orderNodesInWindow.get(0).getColumn() : null ): curNode.getColumn() );
					Column secondCol = (curNode.getColumn()==null ? (curNode.orderNodesInWindow.size()>0 ? curNode.orderNodesInWindow.get(1).getColumn() : null ): curNode.getColumn() );

					int currentLevel = mutation.getQueryBlock().getLevel();
					
					for(int i=0 ; i<cvc.getTableMap().getSQTableByName("JSQ"+String.valueOf(currentLevel)).getColumns().size() ; i++)
					{
						String joinTable = "JSQ"+String.valueOf(currentLevel);
						String currentColumnName = cvc.getTableMap().getSQTableByName(joinTable).getColumn(i).getColumnName();

						if(currentColumnName.contains(secondCol.getColumnName()))
						{

							int currentIndex = cvc.getTableMap().getSQTableByName(joinTable).getColumnIndex(currentColumnName);
							Expr expr1 = ConstraintGenerator.genSelectTest(cvc,joinTable, currentIndex , 1);
							Expr expr2 = ConstraintGenerator.genSelectTest(cvc,joinTable, currentIndex , 2);
							

							String ass = "(assert  ";
							constraintString+= ass + "\n (not ( = " + expr1.toString() + " " + expr2.toString() +"))\n";
							constraintString+=" )\n";

						}
					}
					for(int i=0 ; i<cvc.getTableMap().getSQTableByName("JSQ"+String.valueOf(currentLevel)).getColumns().size() ; i++)
					{
						String joinTable = "JSQ"+String.valueOf(currentLevel);
						String currentColumnName = cvc.getTableMap().getSQTableByName(joinTable).getColumn(i).getColumnName();

						if(currentColumnName.contains(firstCol.getColumnName()))
						{

							int currentIndex = cvc.getTableMap().getSQTableByName(joinTable).getColumnIndex(currentColumnName);
							Expr expr1 = ConstraintGenerator.genSelectTest(cvc,joinTable, currentIndex , 1);
							Expr expr2 = ConstraintGenerator.genSelectTest(cvc,joinTable, currentIndex , 2);
							

							String ass = "(assert ";
							constraintString+= ass + "\n  ( = " + expr1.toString() + " " + expr2.toString() +")\n";
							constraintString+=" )\n";

						}
					}

					if(!constraintString.equalsIgnoreCase(""))
					{
						cvc.getConstraints().add( constraintString );
						return GenerateCommonConstraintsForQuery.generateDataSetForConstraints(cvc, false);
					}
				}
				

			}

			else if(cvc.isWindowMutant==3) //missing attribute in order by, the first order is missing
			{
				String constraintString = "";
				if(curNode.orderNodesInWindow.size()==2)
				{
					Column firstCol = (curNode.getColumn()==null ? (curNode.orderNodesInWindow.size()>0 ? curNode.orderNodesInWindow.get(0).getColumn() : null ): curNode.getColumn() );
					Column secondCol = (curNode.getColumn()==null ? (curNode.orderNodesInWindow.size()>0 ? curNode.orderNodesInWindow.get(1).getColumn() : null ): curNode.getColumn() );

					int currentLevel = mutation.getQueryBlock().getLevel();
					
					for(int i=0 ; i<cvc.getTableMap().getSQTableByName("JSQ"+String.valueOf(currentLevel)).getColumns().size() ; i++)
					{
						String joinTable = "JSQ"+String.valueOf(currentLevel);
						String currentColumnName = cvc.getTableMap().getSQTableByName(joinTable).getColumn(i).getColumnName();

						if(currentColumnName.contains(firstCol.getColumnName()))
						{

							int currentIndex = cvc.getTableMap().getSQTableByName(joinTable).getColumnIndex(currentColumnName);
							Expr expr1 = ConstraintGenerator.genSelectTest(cvc,joinTable, currentIndex , 1);
							Expr expr2 = ConstraintGenerator.genSelectTest(cvc,joinTable, currentIndex , 2);
							

							String ass = "(assert ";
							constraintString+= ass + "\n (not ( = " + expr1.toString() + " " + expr2.toString() +"))\n";
							constraintString+=" )\n";

						}
					}
					for(int i=0 ; i<cvc.getTableMap().getSQTableByName("JSQ"+String.valueOf(currentLevel)).getColumns().size() ; i++)
					{
						String joinTable = "JSQ"+String.valueOf(currentLevel);
						String currentColumnName = cvc.getTableMap().getSQTableByName(joinTable).getColumn(i).getColumnName();

						if(currentColumnName.contains(secondCol.getColumnName()))
						{

							int currentIndex = cvc.getTableMap().getSQTableByName(joinTable).getColumnIndex(currentColumnName);
							Expr expr1 = ConstraintGenerator.genSelectTest(cvc,joinTable, currentIndex , 1);
							Expr expr2 = ConstraintGenerator.genSelectTest(cvc,joinTable, currentIndex , 2);
							

							String ass = "(assert ";
							constraintString+= ass + "\n  ( = " + expr1.toString() + " " + expr2.toString() +")\n";
							constraintString+=" )\n";

						}
					}

					if(!constraintString.equalsIgnoreCase(""))
					{
						cvc.getConstraints().add( constraintString );
						return GenerateCommonConstraintsForQuery.generateDataSetForConstraints(cvc, false);
					}
				}
				

			}
			else if(cvc.isWindowMutant==4) //ordering of order by attributes
			{
				String constraintString = "";
				if(curNode.orderNodesInWindow.size()==2)
				{
					Column firstCol = (curNode.getColumn()==null ? (curNode.orderNodesInWindow.size()>0 ? curNode.orderNodesInWindow.get(0).getColumn() : null ): curNode.getColumn() );
					Column secondCol = (curNode.getColumn()==null ? (curNode.orderNodesInWindow.size()>0 ? curNode.orderNodesInWindow.get(1).getColumn() : null ): curNode.getColumn() );

					int currentLevel = mutation.getQueryBlock().getLevel();
					
					for(int i=0 ; i<cvc.getTableMap().getSQTableByName("JSQ"+String.valueOf(currentLevel)).getColumns().size() ; i++)
					{
						String joinTable = "JSQ"+String.valueOf(currentLevel);
						String currentColumnName = cvc.getTableMap().getSQTableByName(joinTable).getColumn(i).getColumnName();

						if(currentColumnName.contains(firstCol.getColumnName()))
						{

							int currentIndex = cvc.getTableMap().getSQTableByName(joinTable).getColumnIndex(currentColumnName);
							Expr expr1 = ConstraintGenerator.genSelectTest(cvc,joinTable, currentIndex , 1);
							Expr expr2 = ConstraintGenerator.genSelectTest(cvc,joinTable, currentIndex , 2);
							

							if(firstCol.getCvcDatatype().equalsIgnoreCase("Int") || firstCol.getCvcDatatype().equalsIgnoreCase("Real"))
							{
								String ass = "(assert";
								constraintString+= ass + "\n ( > " + expr1.toString() + " " + expr2.toString() +" )\n";
								constraintString+=" )\n";
							}
							else
							{
								String ass = "(assert ";
								constraintString+= ass + "\n ( " + "gt"+ firstCol.getCvcDatatype() + " " + expr1.toString() + " " + expr2.toString() +" )\n";
								constraintString+=" )\n";
								
							}
							

						}
					}
					for(int i=0 ; i<cvc.getTableMap().getSQTableByName("JSQ"+String.valueOf(currentLevel)).getColumns().size() ; i++)
					{
						String joinTable = "JSQ"+String.valueOf(currentLevel);
						String currentColumnName = cvc.getTableMap().getSQTableByName(joinTable).getColumn(i).getColumnName();

						if(currentColumnName.contains(secondCol.getColumnName()))
						{

							int currentIndex = cvc.getTableMap().getSQTableByName(joinTable).getColumnIndex(currentColumnName);
							Expr expr1 = ConstraintGenerator.genSelectTest(cvc,joinTable, currentIndex , 1);
							Expr expr2 = ConstraintGenerator.genSelectTest(cvc,joinTable, currentIndex , 2);
							

							if(secondCol.getCvcDatatype().equalsIgnoreCase("Int") || secondCol.getCvcDatatype().equalsIgnoreCase("Real"))
							{
								String ass = "(assert";
								constraintString+= ass + "\n  ( < " + expr1.toString() + " " + expr2.toString() +")\n";
								constraintString+=" )\n";
							}
							else
							{
								String ass = "(assert";
								constraintString+= ass + "\n ( " + "lt"+ secondCol.getCvcDatatype() + " " + expr1.toString() + " " + expr2.toString() +" )\n";
								constraintString+=" )\n";

							}	

						}
					}

					if(!constraintString.equalsIgnoreCase(""))
					{
						cvc.getConstraints().add( constraintString );
						return GenerateCommonConstraintsForQuery.generateDataSetForConstraints(cvc, false);
					}
				}
				
			}
			else if(cvc.isWindowMutant==5) //asc vs desc
			{

				String constraintString = "";
				if(curNode.orderNodesInWindow.size()==1)
				{
					Column firstCol = (curNode.getColumn()==null ? (curNode.orderNodesInWindow.size()>0 ? curNode.orderNodesInWindow.get(0).getColumn() : null ): curNode.getColumn() );

					int currentLevel = mutation.getQueryBlock().getLevel();
					
					for(int i=0 ; i<cvc.getTableMap().getSQTableByName("JSQ"+String.valueOf(currentLevel)).getColumns().size() ; i++)
					{
						String joinTable = "JSQ"+String.valueOf(currentLevel);
						String currentColumnName = cvc.getTableMap().getSQTableByName(joinTable).getColumn(i).getColumnName();

						if(currentColumnName.contains(firstCol.getColumnName()))
						{

							int currentIndex = cvc.getTableMap().getSQTableByName(joinTable).getColumnIndex(currentColumnName);
							Expr expr1 = ConstraintGenerator.genSelectTest(cvc,joinTable, currentIndex , 1);
							Expr expr2 = ConstraintGenerator.genSelectTest(cvc,joinTable, currentIndex , 2);
							

							if(firstCol.getCvcDatatype().equalsIgnoreCase("Int") || firstCol.getCvcDatatype().equalsIgnoreCase("Real"))
							{
								String ass = "(assert";
								constraintString+= ass + "\n(not ( = " + expr1.toString() + " " + expr2.toString() +" ))\n";
								constraintString+=" )\n";
							}
							

						}
					}

					if(!constraintString.equalsIgnoreCase(""))
					{
						cvc.getConstraints().add( constraintString );
						return GenerateCommonConstraintsForQuery.generateDataSetForConstraints(cvc, false);
					}
				}
				
			}
			else if(cvc.isWindowMutant==6) //wrong atribute in order by clause 
			{
				String constraintString = "";
				if(curNode.orderNodesInWindow.size()==1)
				{
					Column firstCol = (curNode.getColumn()==null ? (curNode.orderNodesInWindow.size()>0 ? curNode.orderNodesInWindow.get(0).getColumn() : null ): curNode.getColumn() );
					Column secondCol = null; // will get the other projected column

					for(int i=0 ;  i<mutation.getQueryBlock().getProjectedCols().size() ; i++)
					{
						if(!mutation.getQueryBlock().getProjectedCols().get(i).getType().equalsIgnoreCase("ANALYTICAL NODE") )
						{
							secondCol = mutation.getQueryBlock().getProjectedCols().get(i).getColumn();
							break;
						}
					}

					int currentLevel = mutation.getQueryBlock().getLevel();
					
					for(int i=0 ; i<cvc.getTableMap().getSQTableByName("JSQ"+String.valueOf(currentLevel)).getColumns().size() ; i++)
					{
						String joinTable = "JSQ"+String.valueOf(currentLevel);
						String currentColumnName = cvc.getTableMap().getSQTableByName(joinTable).getColumn(i).getColumnName();

						if(currentColumnName.contains(firstCol.getColumnName()))
						{

							int currentIndex = cvc.getTableMap().getSQTableByName(joinTable).getColumnIndex(currentColumnName);
							Expr expr1 = ConstraintGenerator.genSelectTest(cvc,joinTable, currentIndex , 1);
							Expr expr2 = ConstraintGenerator.genSelectTest(cvc,joinTable, currentIndex , 2);
							

							if(firstCol.getCvcDatatype().equalsIgnoreCase("Int") || firstCol.getCvcDatatype().equalsIgnoreCase("Real"))
							{
								String ass = "(assert";
								constraintString+= ass + "\n ( > " + expr1.toString() + " " + expr2.toString() +" )\n";
								constraintString+=" )\n";
							}
							else
							{
								String ass = "(assert ";
								constraintString+= ass + "\n ( " + "gt"+ firstCol.getCvcDatatype() + " " + expr1.toString() + " " + expr2.toString() +" )\n";
								constraintString+=" )\n";
								
							}
							

						}
					}
					for(int i=0 ; i<cvc.getTableMap().getSQTableByName("JSQ"+String.valueOf(currentLevel)).getColumns().size() ; i++)
					{
						String joinTable = "JSQ"+String.valueOf(currentLevel);
						String currentColumnName = cvc.getTableMap().getSQTableByName(joinTable).getColumn(i).getColumnName();

						if(currentColumnName.contains(secondCol.getColumnName()))
						{

							int currentIndex = cvc.getTableMap().getSQTableByName(joinTable).getColumnIndex(currentColumnName);
							Expr expr1 = ConstraintGenerator.genSelectTest(cvc,joinTable, currentIndex , 1);
							Expr expr2 = ConstraintGenerator.genSelectTest(cvc,joinTable, currentIndex , 2);
							

							if(secondCol.getCvcDatatype().equalsIgnoreCase("Int") || secondCol.getCvcDatatype().equalsIgnoreCase("Real"))
							{
								String ass = "(assert";
								constraintString+= ass + "\n  ( < " + expr1.toString() + " " + expr2.toString() +")\n";
								constraintString+=" )\n";
							}
							else
							{
								String ass = "(assert";
								constraintString+= ass + "\n ( " + "lt"+ secondCol.getCvcDatatype() + " " + expr1.toString() + " " + expr2.toString() +" )\n";
								constraintString+=" )\n";

							}	

						}
					}

					if(!constraintString.equalsIgnoreCase(""))
					{
						cvc.getConstraints().add( constraintString );
						return GenerateCommonConstraintsForQuery.generateDataSetForConstraints(cvc, false);
					}
				}
				
			}
			else if(cvc.isWindowMutant==8) //additional partition by
			{
				String constraintString= "";

				if(curNode.partitionByNodes.size()==1)
				{
					if(curNode.orderNodesInWindow.size()==1)
					{
						Column firstCol = (curNode.getColumn()==null ? (curNode.orderNodesInWindow.size()>0 ? curNode.orderNodesInWindow.get(0).getColumn() : null ): curNode.getColumn() ); // partition by column
						Column secondCol = null; // will get the other projected column

						for(int i=0 ;  i<mutation.getQueryBlock().getProjectedCols().size() ; i++)
						{
							if(!mutation.getQueryBlock().getProjectedCols().get(i).getType().equalsIgnoreCase("ANALYTICAL NODE") )
							{
								secondCol = mutation.getQueryBlock().getProjectedCols().get(i).getColumn();
								break;
							}
						}

						int currentLevel = mutation.getQueryBlock().getLevel();
						
						for(int i=0 ; i<cvc.getTableMap().getSQTableByName("JSQ"+String.valueOf(currentLevel)).getColumns().size() ; i++)
						{
							String joinTable = "JSQ"+String.valueOf(currentLevel);
							String currentColumnName = cvc.getTableMap().getSQTableByName(joinTable).getColumn(i).getColumnName();

							if(currentColumnName.contains(firstCol.getColumnName()))
							{

								int currentIndex = cvc.getTableMap().getSQTableByName(joinTable).getColumnIndex(currentColumnName);
								Expr expr1 = ConstraintGenerator.genSelectTest(cvc,joinTable, currentIndex , 1);
								Expr expr2 = ConstraintGenerator.genSelectTest(cvc,joinTable, currentIndex , 2);
								
								String ass = "(assert";
								constraintString+= ass + "\n ( = " + expr1.toString() + " " + expr2.toString() +" )\n";
								constraintString+=" )\n";	

							}
						}
						for(int i=0 ; i<cvc.getTableMap().getSQTableByName("JSQ"+String.valueOf(currentLevel)).getColumns().size() ; i++)
						{
							String joinTable = "JSQ"+String.valueOf(currentLevel);
							String currentColumnName = cvc.getTableMap().getSQTableByName(joinTable).getColumn(i).getColumnName();

							if(currentColumnName.contains(secondCol.getColumnName()))
							{

								int currentIndex = cvc.getTableMap().getSQTableByName(joinTable).getColumnIndex(currentColumnName);
								Expr expr1 = ConstraintGenerator.genSelectTest(cvc,joinTable, currentIndex , 1);
								Expr expr2 = ConstraintGenerator.genSelectTest(cvc,joinTable, currentIndex , 2);
								

								if(secondCol.getCvcDatatype().equalsIgnoreCase("Int") || secondCol.getCvcDatatype().equalsIgnoreCase("Real"))
								{
									String ass = "(assert";
									constraintString+= ass + "\n  ( < " + expr1.toString() + " " + expr2.toString() +")\n";
									constraintString+=" )\n";
								}
								else
								{
									String ass = "(assert";
									constraintString+= ass + "\n ( " + "lt"+ secondCol.getCvcDatatype() + " " + expr1.toString() + " " + expr2.toString() +" )\n";
									constraintString+=" )\n";

								}	

							}
						}
					}
					if(!constraintString.equalsIgnoreCase(""))
					{
						cvc.getConstraints().add( constraintString );
						return GenerateCommonConstraintsForQuery.generateDataSetForConstraints(cvc, false);
					}
				}

			}
			else if(cvc.isWindowMutant==7) //extra attribute in order by
			{
				String constraintString= "";

				if(curNode.orderNodesInWindow.size()==1)
				{
					if(curNode.orderNodesInWindow.size()==1)
					{
						Column firstCol = (curNode.getColumn()==null ? (curNode.orderNodesInWindow.size()>0 ? curNode.orderNodesInWindow.get(0).getColumn() : null ): curNode.getColumn() );
						Column secondCol = null; // will get the other projected column

						for(int i=0 ;  i<mutation.getQueryBlock().getProjectedCols().size() ; i++)
						{
							if(!mutation.getQueryBlock().getProjectedCols().get(i).getType().equalsIgnoreCase("ANALYTICAL NODE") )
							{
								secondCol = mutation.getQueryBlock().getProjectedCols().get(i).getColumn();
								break;
							}
						}

						int currentLevel = mutation.getQueryBlock().getLevel();
						
						for(int i=0 ; i<cvc.getTableMap().getSQTableByName("JSQ"+String.valueOf(currentLevel)).getColumns().size() ; i++)
						{
							String joinTable = "JSQ"+String.valueOf(currentLevel);
							String currentColumnName = cvc.getTableMap().getSQTableByName(joinTable).getColumn(i).getColumnName();

							if(currentColumnName.contains(firstCol.getColumnName()))
							{

								int currentIndex = cvc.getTableMap().getSQTableByName(joinTable).getColumnIndex(currentColumnName);
								Expr expr1 = ConstraintGenerator.genSelectTest(cvc,joinTable, currentIndex , 1);
								Expr expr2 = ConstraintGenerator.genSelectTest(cvc,joinTable, currentIndex , 2);
								
								String ass = "(assert";
								constraintString+= ass + "\n ( = " + expr1.toString() + " " + expr2.toString() +" )\n";
								constraintString+=" )\n";	

							}
						}
						for(int i=0 ; i<cvc.getTableMap().getSQTableByName("JSQ"+String.valueOf(currentLevel)).getColumns().size() ; i++)
						{cvc.getConstraints().add( constraintString );
							String joinTable = "JSQ"+String.valueOf(currentLevel);
							String currentColumnName = cvc.getTableMap().getSQTableByName(joinTable).getColumn(i).getColumnName();

							if(currentColumnName.contains(secondCol.getColumnName()))
							{

								int currentIndex = cvc.getTableMap().getSQTableByName(joinTable).getColumnIndex(currentColumnName);
								Expr expr1 = ConstraintGenerator.genSelectTest(cvc,joinTable, currentIndex , 1);
								Expr expr2 = ConstraintGenerator.genSelectTest(cvc,joinTable, currentIndex , 2);
								

								if(secondCol.getCvcDatatype().equalsIgnoreCase("Int") || secondCol.getCvcDatatype().equalsIgnoreCase("Real"))
								{
									String ass = "(assert";
									constraintString+= ass + "\n (not ( = " + expr1.toString() + " " + expr2.toString() +"))\n";
									constraintString+=" )\n";
								}	

							}
						}
					}
					if(!constraintString.equalsIgnoreCase(""))
					{
						cvc.getConstraints().add( constraintString );
						return GenerateCommonConstraintsForQuery.generateDataSetForConstraints(cvc, false);
					}

				}

			}
			else if(cvc.isWindowMutant==9) //missing element in partition by
			{
				String constraintString= "";

				if(curNode.partitionByNodes.size()==2)
				{
					
					Column firstCol = curNode.partitionByNodes.get(0).getColumn();
					Column secondCol = curNode.partitionByNodes.get(1).getColumn();
				
					int currentLevel = mutation.getQueryBlock().getLevel();
					
					for(int i=0 ; i<cvc.getTableMap().getSQTableByName("JSQ"+String.valueOf(currentLevel)).getColumns().size() ; i++)
					{
						String joinTable = "JSQ"+String.valueOf(currentLevel);
						String currentColumnName = cvc.getTableMap().getSQTableByName(joinTable).getColumn(i).getColumnName();

						if(currentColumnName.contains(firstCol.getColumnName()))
						{

							int currentIndex = cvc.getTableMap().getSQTableByName(joinTable).getColumnIndex(currentColumnName);
							Expr expr1 = ConstraintGenerator.genSelectTest(cvc,joinTable, currentIndex , 1);
							Expr expr2 = ConstraintGenerator.genSelectTest(cvc,joinTable, currentIndex , 2);
							
							String ass = "(assert";
							constraintString+= ass + "\n ( = " + expr1.toString() + " " + expr2.toString() +" )\n";
							constraintString+=" )\n";	

						}
					}
					for(int i=0 ; i<cvc.getTableMap().getSQTableByName("JSQ"+String.valueOf(currentLevel)).getColumns().size() ; i++)
					{
						String joinTable = "JSQ"+String.valueOf(currentLevel);
						String currentColumnName = cvc.getTableMap().getSQTableByName(joinTable).getColumn(i).getColumnName();

						if(currentColumnName.contains(secondCol.getColumnName()))
						{

							int currentIndex = cvc.getTableMap().getSQTableByName(joinTable).getColumnIndex(currentColumnName);
							Expr expr1 = ConstraintGenerator.genSelectTest(cvc,joinTable, currentIndex , 1);
							Expr expr2 = ConstraintGenerator.genSelectTest(cvc,joinTable, currentIndex , 2);
							

							if(secondCol.getCvcDatatype().equalsIgnoreCase("Int") || secondCol.getCvcDatatype().equalsIgnoreCase("Real"))
							{
								String ass = "(assert";
								constraintString+= ass + "\n (not ( = " + expr1.toString() + " " + expr2.toString() +"))\n";
								constraintString+=" )\n";
							}	

						}
					}
					
					if(!constraintString.equalsIgnoreCase(""))
					{
						cvc.getConstraints().add( constraintString );
						return GenerateCommonConstraintsForQuery.generateDataSetForConstraints(cvc, false);
					}
				}

				
			}

			
			cvc.isWindowMutant = -1;

			/** Call the method for the data generation */
			return false;
		} catch (TimeoutException e) {
			logger.log(Level.SEVERE, e.getMessage(), e);
			throw e;
		} catch (Exception e) {
			logger.log(Level.SEVERE, e.getMessage(), e);
			throw e;
		}
	}

	public static boolean generateDataForQueryMutantsForSet(GenerateCVC1 cvc, MutationStructure mutation) throws Exception {

		// must add code

		System.out.println("Start making changes");

		//now have to find the block

		if(cvc.getOuterBlock().isSet==1)
		{
			// this is for searching for from the outer block, else it will be there at the from clause or whhere clause subqueries
			findBlock(cvc, cvc.getOuterBlock() ,mutation);	
		}
		else{
			// check in where clause and from clause subqueries
		}
		System.out.println("End of changes");
		return false; 
	}

	public static boolean generateDataForQueryMutants(GenerateCVC1 cvc, MutationStructure mutation) throws Exception {

		logger.log(Level.INFO, "\n----------------------------------");
		logger.log(Level.INFO, "GENERATE DATA FOR ORIGINAL QUERY: ");
		logger.log(Level.INFO, "---------------------------------\n");
		try {
			if(Configuration.getProperty("printSQL").equalsIgnoreCase("true")){
				String filePath = Configuration.getProperty("printDir") +"/"+cvc.getQueryId()+ "/diff.txt";
				String diff = GenConstraints.PrintDiffForSpecificMutation(mutation);
				Utilities.writeFile(filePath, diff, true);
			}
			/**
			 * Initialize the data structures for generating the data to kill this mutation
			 */
			if (mutation.getMutationTypeNumber() != 6 && mutation.getMutationTypeNumber() != 27)
				cvc.inititalizeForDatasetQs();

			/**
			 * get the tuple assignment for this query
			 * If no possible assignment then not possible to kill this mutation
			 */

			if (GenerateCVC1.tupleAssignmentForQuery(cvc) == false)
				return false;

			// Special handling for ORDER BY mutation (type 27)
				if (cvc.getCurrentMutant() != null && cvc.getCurrentMutant().getMutationTypeNumber() == 27) {
					cvc.inititalizeForDatasetQs();
					Node orderByNode = cvc.getqStructure().getOrderByNodes().get(0);
					Column col = orderByNode.getColumn();
					Table table = col.getTable();
					String tableName = col.getTable().getTableName();
					String mode = cvc.getCurrentMutant().getMutationNode() == null ? ""
							: cvc.getCurrentMutant().getMutationNode().toString();

					// if ("ORDER_BY_MULTI_COLUMN_LEX".equalsIgnoreCase(mode)) {
					// 	// Separate dataset for multi-column ORDER BY lexicographic behavior.
					// 	// Force exactly 2 tuples and assert lexicographic ordering across
					// 	// ORDER BY columns: c1, then c2 on ties, then c3, ...
					// 	StringBuilder constraint = new StringBuilder();
					// 	constraint.append(ConstraintGenerator
					// 			.addCommentLine("ORDER BY MULTI-COLUMN LEXICOGRAPHIC DATASET"));
					// 	forceTwoTuplesForTable(cvc, tableName);
					// 	appendTwoTupleCountConstraints(cvc, table, tableName, constraint);
					// 	appendLexicographicOrderByAssertion(cvc, constraint, 1, 2);
					// 	constraint.append(ConstraintGenerator
					// 			.addCommentLine("END OF ORDER BY MULTI-COLUMN LEXICOGRAPHIC DATASET"));
					// 	cvc.getConstraints().add(constraint.toString());
					// } 
					if ("ORDER_BY_TWO_TUPLES_NO_NULL_CONSTRAINT".equalsIgnoreCase(mode)) {
						// Force exactly 2 physical tuples for ORDER BY table, with no null constraint
						// on the ORDER BY column.
						StringBuilder constraint = new StringBuilder();
						constraint.append(ConstraintGenerator
								.addCommentLine("ORDER BY TWO TUPLES (NO NULL CONSTRAINT ON ORDER BY COLUMN)"));
						forceTwoTuplesForTable(cvc, tableName);
						appendTwoTupleCountConstraints(cvc, table, tableName, constraint);
						constraint.append(ConstraintGenerator
								.addCommentLine("END OF ORDER BY TWO TUPLES (NO NULL CONSTRAINT ON ORDER BY COLUMN)"));
						cvc.getConstraints().add(constraint.toString());
					} else if ("ORDER_BY_TWO_TUPLES_NULL_AND_NON_NULL".equalsIgnoreCase(mode)) {
						// Force exactly 2 physical tuples for ORDER BY table:
						// tuple1 => NULL on ORDER BY col, tuple2 => NON-NULL on ORDER BY col.
						forceTwoTuplesForTable(cvc, tableName);
						String columnName = col.getColumnName();
						StringBuilder constraint = new StringBuilder();
						constraint.append(
								ConstraintGenerator.addCommentLine("ORDER BY TWO TUPLES (ONE NULL, ONE NON-NULL)"));
						appendTwoTupleCountConstraints(cvc, table, tableName, constraint);

						Expr t1 = ConstraintGenerator.ctx.mkInt(1);
						Expr t2 = ConstraintGenerator.ctx.mkInt(2);
						Expr v1 = ConstraintGenerator.smtMap(col, t1);
						Expr v2 = ConstraintGenerator.smtMap(col, t2);
						constraint.append("(assert (ISNULL_").append(columnName).append(" ").append(v1.toString()).append("))\n");
						constraint.append("(assert (not (ISNULL_").append(columnName).append(" ").append(v2.toString()).append(")))\n");
						constraint
								.append(ConstraintGenerator.addCommentLine("END OF ORDER BY TWO TUPLES (ONE NULL, ONE NON-NULL)"));
						cvc.getConstraints().add(constraint.toString());
					} else if ("ORDER_BY_WRONG_ATTRIBUTE_TRAP".equalsIgnoreCase(mode)) {
						// Force exactly 2 physical tuples.
						// ORDER BY column A: t1.A < t2.A
						// Other columns of same table: t1.col > t2.col
						forceTwoTuplesForTable(cvc, tableName);
						String orderByColumn = col.getColumnName();
						StringBuilder constraint = new StringBuilder();
						constraint.append(ConstraintGenerator.addCommentLine(
								"ORDER BY WRONG ATTRIBUTE TRAP: t1.A<t2.A and t1.otherCols>t2.otherCols"));
						appendTwoTupleCountConstraints(cvc, table, tableName, constraint);

					ConstraintGenerator consGen = new ConstraintGenerator();
					Expr t1 = ConstraintGenerator.ctx.mkInt(1);
					Expr t2 = ConstraintGenerator.ctx.mkInt(2);

					// A: t1.A < t2.A
					Expr a1 = ConstraintGenerator.smtMap(col, t1);
					Expr a2 = ConstraintGenerator.smtMap(col, t2);
					String orderByCmp = consGen.getUserDefinedComparisionOperator("<", col, a1.toString(), a2.toString());
					if (orderByCmp != null && !orderByCmp.isEmpty()) {
						constraint.append("(assert ").append(orderByCmp).append(")\n");
					}

					// Other columns: t1.col > t2.col
					for (Column otherCol : table.getColumns().values()) {
						if (otherCol == null || otherCol.getColumnName() == null)
							continue;
						if (otherCol.getColumnName().equalsIgnoreCase(orderByColumn))
							continue;
						if (otherCol.getColumnName().equalsIgnoreCase("XDATA_CNT"))
							continue;

						Expr o1 = ConstraintGenerator.smtMap(otherCol, t1);
						Expr o2 = ConstraintGenerator.smtMap(otherCol, t2);
						String cmp = consGen.getUserDefinedComparisionOperator(">", otherCol, o1.toString(), o2.toString());
						if (cmp != null && !cmp.isEmpty()) {
							constraint.append("(assert ").append(cmp).append(")\n");
						}
					}

					constraint.append(ConstraintGenerator.addCommentLine(
							"END OF ORDER BY WRONG ATTRIBUTE TRAP"));
					cvc.getConstraints().add(constraint.toString());
				} else {
					cvc.putNoOfOutputTuples(tableName, 1);

					// Existing behavior: Add SMT constraint for NULL in top tuple.
					//Table table = col.getTable();
					String columnName = col.getColumnName();
					int pos = table.getColumnIndex(columnName);
					String colVar = tableName + "_" + columnName + pos;
					String smtMapVar = "(" + colVar + " (select O_" + tableName + " 1))";
					String constraint = ConstraintGenerator
							.addCommentLine("ORDER BY LIMIT 1 NULL mutation: top tuple must be NULL\n");
					constraint += "(assert (ISNULL_" + columnName + " " + smtMapVar + "))\n";
					cvc.getConstraints().add(constraint);
				}
			}

			if (cvc.getCurrentMutant() != null && (cvc.getCurrentMutant().getMutationTypeNumber() == 5 || cvc.getCurrentMutant().getMutationTypeNumber() == 24) ) {
				/** get table name */
				if(CountEstimationRelated.getCountNeededToKillDistinctMutation(cvc,
							cvc.currentMutant.getQueryBlock()) == false)
					return false;
				String tableNameNo = null;

				Node n1 = null;
				for (Node n : cvc.currentMutant.getQueryBlock().getProjectedCols())
					for (QueryBlockDetails qb : cvc.getOuterBlock().getFromClauseSubQueries())
						if (!qb.getProjectedCols().contains(n)) {
							tableNameNo = n.getTableNameNo();
							n1 = n;
						}

				/**
				 * If this relation is involved in equi-joins then we can ensure multiple tuples
				 * at the output, even if this relation contains a single tuple
				 * FIXME: But what if all the relations in this equivalence class contains a
				 * single tuple
				 */
				for (ConjunctQueryStructure con : cvc.currentMutant.getQueryBlock().getConjunctsQs())
					for (Vector<Node> ec : con.getEquivalenceClasses())
						for (Node n2 : ec)
							if (n2.getTableNameNo().equalsIgnoreCase(tableNameNo))
								tableNameNo = null;

				/** assign the number of tuples for the this query block */
				if (QueryBlockDetails.getTupleAssignment(cvc, cvc.currentMutant.getQueryBlock(), tableNameNo) == false)
					return false;

				/** get the tuple assignment for all other query blocks */
				if (CountEstimationRelated.getTupleAssignmentExceptQueryBlock(cvc, cvc.currentMutant.getQueryBlock()) == false)
					return false;

			}
			

			if (cvc.getCurrentMutant() != null
					&& (cvc.getCurrentMutant().getMutationTypeNumber() == 7
							|| cvc.getCurrentMutant().getMutationTypeNumber() == 8)
					&& CountEstimationRelated.getCountAndTupleAssignmentToKillExtraGroupByMutations(cvc,
							cvc.currentMutant.getQueryBlock()) == false)
				return false;

			if (cvc.getCurrentMutant() != null && (cvc.getCurrentMutant().getMutationTypeNumber() == 7
					|| cvc.getCurrentMutant().getMutationTypeNumber() == 8)) {
				Column c = ((Column) cvc.getCurrentMutant().getMutationNode());
				if (cvc.noOfOutputTuplesContains(c.getTableName().toUpperCase()))
					cvc.putNoOfOutputTuples(c.getTableName().toUpperCase(),
							cvc.getNoOfOutputTuples(c.getTableName().toUpperCase()) + 1);
			}
			if (cvc.getCurrentMutant() != null && cvc.getCurrentMutant().getMutationTypeNumber() == 2
					&& CountEstimationRelated.getCountNeededToKillAggregationMutation(cvc,
							cvc.getCurrentMutant().getQueryBlock(), 5) == false)
				return false;

			if (cvc.getCurrentMutant() != null && cvc.getCurrentMutant().getMutationTypeNumber() == 2) {
				Column c = ((Node) cvc.getCurrentMutant().getMutationLoc()).getColumn();
				if (cvc.noOfOutputTuplesContains(c.getTableName().toUpperCase()))
					cvc.putNoOfOutputTuples(c.getTableName().toUpperCase(),
							cvc.getNoOfOutputTuples(c.getTableName().toUpperCase()) + 2);
			}

			// For COUNT column replacement (type 29): add 1 extra tuple so the SMT EXISTS
			// constraint that enforces the null/non-null pattern has room to be satisfied.
			if (cvc.getCurrentMutant() != null && cvc.getCurrentMutant().getMutationTypeNumber() == 29) {
				Node countOrigNode = (Node) cvc.getCurrentMutant().getMutationLoc();
				Column origCol = countOrigNode.getAgg().getAggExp().getColumn();
				if (origCol != null && origCol.getTableName() != null
						&& cvc.noOfOutputTuplesContains(origCol.getTableName().toUpperCase())) {
					cvc.putNoOfOutputTuples(origCol.getTableName().toUpperCase(),
							cvc.getNoOfOutputTuples(origCol.getTableName().toUpperCase()) + 1);
				}
			}

			/** set the type of mutation we are trying to kill */
			cvc.setTypeOfMutation(mutation.getMutationType());

			GetSolverHeaderAndFooter.generateSolver_Header(cvc, false); // testcode by Sunanda for IS_NULL

			GenerateCommonConstraintsForQuery.generateNullandDBConstraints(cvc, false);

			if (Configuration.tempJoins.equalsIgnoreCase("true")) {
				// step 1 and step 2 : Sunanda
				// Build Correlation Map
				QueryBlockDetails.ProcessProjectedColumnsFromFClauseSQ(cvc, cvc.getOuterBlock());

				QueryBlockDetails.TraverseNestedQueryStrcuture(cvc, cvc.getqStructure());
				// Calculates the level at which correlation conditions to be processed
				// considering Exists and Not Exists types
				QueryBlockDetails.setLevelForProcessingCorrelationCondition(cvc);
			}

			/**Get the constraints for all the blocks of the query  */
			cvc.getConstraints().add( QueryBlockDetails.getConstraintsForQueryBlock(cvc) );

			if(Configuration.getProperty("printSQL").equalsIgnoreCase("true")){
				String str = cvc.printSQL(cvc.outerBlock, mutation);
				System.out.println(str);
				String filePath = Configuration.getProperty("printDir") +"/"+cvc.getQueryId()+ "/printSQL.txt";
				Utilities.writeFile(filePath, str, true);
				return true;
			}
			
			/** Call the method for the data generation*/
			return GenerateCommonConstraintsForQuery.generateDataSetForConstraints(cvc,false);
		}catch (TimeoutException e){
			logger.log(Level.SEVERE,e.getMessage(),e);		
			throw e;
		} catch (Exception e) {
			logger.log(Level.SEVERE, e.getMessage(), e);
			throw e;
		}
	}

	private static void forceTwoTuplesForTable(GenerateCVC1 cvc, String tableName) {
		cvc.putNoOfOutputTuples(tableName, 2);
	}

	private static void appendTwoTupleCountConstraints(GenerateCVC1 cvc, Table table, String tableName,
			StringBuilder constraint) {
		Column cntCol = table.getColumn("XDATA_CNT");
		if (cntCol == null) {
			return;
		}
		int tupleCount = cvc.getNoOfOutputTuples(tableName);
		for (int i = 1; i <= tupleCount; i++) {
			Expr ti = ConstraintGenerator.ctx.mkInt(i);
			Expr ci = ConstraintGenerator.smtMap(cntCol, ti);
			if (i <= 2)
				constraint.append("(assert (= ").append(ci.toString()).append(" 1))\n");
			else
				constraint.append("(assert (= ").append(ci.toString()).append(" 0))\n");
		}
	}
}
