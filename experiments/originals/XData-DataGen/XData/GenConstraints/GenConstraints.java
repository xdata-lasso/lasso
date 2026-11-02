package GenConstraints;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Vector;
import java.util.logging.Level;

import generateConstraints.ConstraintGenerator;
import generateConstraints.GenerateCVCConstraintForNode;
import generateConstraints.GenerateCommonConstraintsForQuery;
import generateConstraints.GenerateConstraintForUnintendedJoins;
import generateConstraints.GenerateConstraintsForConjunct;
import generateConstraints.GenerateConstraintsForHavingClause;
import generateConstraints.GenerateConstraintsForWhereClauseSubQueryBlock;
import generateConstraints.GenerateConstraintsToKillExtraGroupByMutations;
import generateConstraints.GenerateJoinPredicateConstraints;
import generateConstraints.RelatedToEquivalenceClassMutations;
import generateConstraints.UtilsRelatedToNode;
import killMutations.GenerateDataForOriginalQuery;
import oracle.net.aso.f;
import parsing.Column;
import parsing.AggregateFunction;
import parsing.CaseCondition;
import parsing.Column;
import parsing.ConjunctQueryStructure;
import parsing.DisjunctQueryStructure;
import parsing.ForeignKey;
import parsing.JoinClauseInfo;
import parsing.MutationStructure;
import parsing.Node;
import parsing.QueryStructure;
import parsing.Table;
import parsing.correlationStructure;
import testDataGen.CountEstimationRelated;
import testDataGen.GenerateCVC1;
import testDataGen.QueryBlockDetails;
import testDataGen.RelatedToParameters;
import util.Configuration;
import util.ConstraintObject;
import util.Pair;
import util.TagDatasets;

public class GenConstraints {
	/*
	 * @author Sunanda
	 * Driver function for nonempty GenConstraintsdatasets
	 */
	public static void generateDatasetForNonEmptyDataset(GenerateCVC1 cvc) throws Exception {
		// TODO Auto-generated method stub
		Node targetNode = null;
		String mutationType = TagDatasets.MutationType.ORIGINAL.getMutationType()
				+ TagDatasets.QueryBlock.NONE.getQueryBlock();
		Integer mutationTypeNumber = TagDatasets.mutationTypeNumber.ORIGINAL.getMutationType();
		MutationStructure mutStruct = new MutationStructure(mutationType, mutationTypeNumber, targetNode);

		// traverse query blocks and find target locations
		generateDatasetForSpecificMutation(cvc, cvc.getOuterBlock(), mutStruct);

	}

	/*
	 * @author Sunanda
	 * Driver function for mutations
	 */
	public static void generateConstraintsToKillMutations(GenerateCVC1 cvc, String mutationType,
			Integer mutationTypeNumber) throws Exception {

		// TODO Auto-generated method stub
		Node targetNode = null;
		MutationStructure mutStruct = new MutationStructure(mutationType, mutationTypeNumber, targetNode);

		Vector<MutationStructure> targetMutants = traverseQueryBlocksToCollectTargetMutantNodes(cvc,
				cvc.getOuterBlock(), mutStruct);
		traverseQueryBlocksToGenerateDatasetsForTargetMutantNodes(cvc, cvc.getOuterBlock(), targetMutants);
	}

	private static void clearExpDetails(QueryBlockDetails qb) {
		if (qb == null)
			return;
		for (int i = 0; i < qb.getProjectedCols().size(); i++) {
			Node proNode = qb.getProjectedCols().get(i);
			proNode.expDetails.clear();
		}
		for (int i = 0; i < qb.getWhereClauseSubQueries().size(); i++) {
			QueryBlockDetails qbw = qb.getWhereClauseSubQueries().get(i);
			clearExpDetails(qbw);
		}
		for (int i = 0; i < qb.getFromClauseSubQueries().size(); i++) {
			QueryBlockDetails qbf = qb.getFromClauseSubQueries().get(i);
			clearExpDetails(qbf);
		}
	}

	private static void traverseQueryBlocksToGenerateDatasetsForTargetMutantNodes(GenerateCVC1 cvc,
			QueryBlockDetails qb, Vector<MutationStructure> targetMutants) throws Exception {
		// TODO Auto-generated method stub
		QueryBlockDetails s = qb;
		for (int i = 0; i < s.getWhereClauseSubQueries().size(); i++) {
			QueryBlockDetails n = s.getWhereClauseSubQueries().get(i);
			if (n != null) {
				if (n.isSet == 1) {
					traverseQueryBlocksToGenerateDatasetsForTargetMutantNodes(cvc, n.getLeftBlockDetails(),
							targetMutants);
					traverseQueryBlocksToGenerateDatasetsForTargetMutantNodes(cvc, n.getRightBlockDetails(),
							targetMutants);
				} else {
					traverseQueryBlocksToGenerateDatasetsForTargetMutantNodes(cvc, n, targetMutants);
				}

			}
		}
		for (int i = 0; i < s.getFromClauseSubQueries().size(); i++) {
			QueryBlockDetails n = s.getFromClauseSubQueries().get(i);
			if (n != null) {
				if (n.isSet == 1) {
					traverseQueryBlocksToGenerateDatasetsForTargetMutantNodes(cvc, n.getLeftBlockDetails(),
							targetMutants);
					traverseQueryBlocksToGenerateDatasetsForTargetMutantNodes(cvc, n.getRightBlockDetails(),
							targetMutants);

				} else {
					traverseQueryBlocksToGenerateDatasetsForTargetMutantNodes(cvc, n, targetMutants);
				}
			}
		}

		if (s.isSet == 1) {
			traverseQueryBlocksToGenerateDatasetsForTargetMutantNodes(cvc, s.getLeftBlockDetails(), targetMutants);
			traverseQueryBlocksToGenerateDatasetsForTargetMutantNodes(cvc, s.getRightBlockDetails(), targetMutants);
		}

		for (MutationStructure mutant : targetMutants) {
			// chaitra clear expression details of all projected nodes
			clearExpDetails(qb);
			// chaitra clear expression details of all projected nodes
			if (mutant.getQueryBlock().getLevel() == s.getLevel())
				generateDatasetForSpecificMutation(cvc, s, mutant);
		}

	}

	// this function can return final target nodes
	// mutant structure will have query block
	// use generateDatasetForSpecificMutation outside of this function after
	// collecting everything required
	private static Vector<MutationStructure> traverseQueryBlocksToCollectTargetMutantNodes(GenerateCVC1 cvc,
			QueryBlockDetails qb, MutationStructure mutStruct) throws Exception {
		// Traversal of queryblocks
		QueryBlockDetails s = qb;
		Vector<MutationStructure> targetMutants = new Vector<MutationStructure>();
		for (int i = 0; i < s.getWhereClauseSubQueries().size(); i++) {
			QueryBlockDetails n = s.getWhereClauseSubQueries().get(i);
			if (n != null) {
				if (n.isSet == 1) {
					targetMutants.addAll(
							traverseQueryBlocksToCollectTargetMutantNodes(cvc, n.getLeftBlockDetails(), mutStruct));
					targetMutants.addAll(
							traverseQueryBlocksToCollectTargetMutantNodes(cvc, n.getRightBlockDetails(), mutStruct));
				} else {
					targetMutants.addAll(traverseQueryBlocksToCollectTargetMutantNodes(cvc, n, mutStruct));
				}

			}
		}
		for (int i = 0; i < s.getFromClauseSubQueries().size(); i++) {
			QueryBlockDetails n = s.getFromClauseSubQueries().get(i);
			if (n != null) {
				if (n.isSet == 1) {
					targetMutants.addAll(
							traverseQueryBlocksToCollectTargetMutantNodes(cvc, n.getLeftBlockDetails(), mutStruct));
					targetMutants.addAll(
							traverseQueryBlocksToCollectTargetMutantNodes(cvc, n.getRightBlockDetails(), mutStruct));
				} else {
					targetMutants.addAll(traverseQueryBlocksToCollectTargetMutantNodes(cvc, n, mutStruct));
				}

			}
		}

		if (s.isSet == 1) {
			targetMutants
					.addAll(traverseQueryBlocksToCollectTargetMutantNodes(cvc, s.getLeftBlockDetails(), mutStruct));
			targetMutants
					.addAll(traverseQueryBlocksToCollectTargetMutantNodes(cvc, s.getRightBlockDetails(), mutStruct));

		}
		// Generate dataset for killing each equivalence class mutation
		targetMutants.addAll(returnTargetNodesForSpecificMutation(cvc, s, mutStruct));

		return targetMutants;

	}

	private static Vector<MutationStructure> returnTargetNodesForSpecificMutation(GenerateCVC1 cvc, QueryBlockDetails s,
			MutationStructure mutStruct) throws Exception {
		// TODO Auto-generated method stub
		Vector<MutationStructure> targetNodes = new Vector<MutationStructure>();

		switch (mutStruct.getMutationTypeNumber()) {
			case 1:
				// generate non-empty dataset
				break;
			case 2:
				// generate agg
				if (s.getHavingClause() != null) {
					QueryBlockDetails.pushHavingClauseAttrInProjectedColumns(s.getHavingClause(), s.getProjectedCols());
				}
				for (int i = 0; i < s.getProjectedCols().size(); i++) {
					// if (s.getProjectedCols().get(i).getAgg() != null
					// && s.getProjectedCols().get(i).fromBelowLevelFClauseSQ == false)
					if (s.getProjectedCols().get(i).getAgg() != null) {
						// s.getProjectedCols().get(i).setColumn(s.getProjectedCols().get(i).getAgg().getAggExp().getColumn());
						MutationStructure tempMutantStructure = new MutationStructure(mutStruct.getMutationType(),
								mutStruct.getMutationTypeNumber(), s.getProjectedCols().get(i), s);
						tempMutantStructure.setmutationNode(s.getProjectedCols().get(i).getColumn());
						targetNodes.add(tempMutantStructure);
					}
				}
				break;
			case 3:
				// generate count
				break;
			case 4:
				// generate having
				if (s.getHavingClause() != null && s.getHavingClause().getType() != null
						&& s.getAggConstraints() != null) {
					ArrayList<Node> aggConstraints = s.getAggConstraints();

					for (Node havingNode : aggConstraints) {
						ArrayList<Node> havingMutants = UtilsRelatedToNode.getHavingMutations(havingNode);
						for (Node hvMut : havingMutants) {
							if (!havingNode.getOperator().equalsIgnoreCase(hvMut.getOperator())
									|| hvMut.getIsMutant()) {
								MutationStructure tempMutantStructure = new MutationStructure(
										mutStruct.getMutationType(),
										mutStruct.getMutationTypeNumber(), havingNode, s);
								tempMutantStructure.setmutationNode(hvMut);
								targetNodes.add(tempMutantStructure);
							}
						}
					}
				}

				return targetNodes;
			case 5:
				// generate distinct

				if (s.isDistinct()) {
					MutationStructure tempMutantStructure = new MutationStructure(
							mutStruct.getMutationType(),
							mutStruct.getMutationTypeNumber(), s.getProjectedCols(), s);

					targetNodes.add(tempMutantStructure);
				}

				break;
			case 6:
				// generate equivalence

				targetNodes.addAll(getMutatationsFromConjunctsRecursively(s.getConjunctsQs().get(0), s, mutStruct));

				// for (ConjunctQueryStructure conjunct : s.getConjunctsQs()) {
				// // for (Vector<Node> equiClasses : conjunct.getEquivalenceClasses()) {
				// if(conjunct.getDisjuncts()!=null && conjunct.getDisjuncts().size()==0){
				// for(DisjunctQueryStructure disjunct: conjunct.getDisjuncts()){
				// MutationStructure tempMutantStructure = new
				// MutationStructure(mutStruct.getMutationType(),
				// mutStruct.getMutationTypeNumber(), disjunct, s);
				// targetNodes.add(tempMutantStructure);
				// }
				// }
				// MutationStructure tempMutantStructure = new
				// MutationStructure(mutStruct.getMutationType(),
				// mutStruct.getMutationTypeNumber(), conjunct, s);
				// targetNodes.add(tempMutantStructure);
				// // }
				// }
				return targetNodes;

			case 7:
				Map<String, String> tableOccurrence = new HashMap<String, String>();
				ArrayList<Column> extraColumn = GenerateConstraintsToKillExtraGroupByMutations.getExtraColumns(cvc, s,
						tableOccurrence);
				int i = 0;
				for (Column c : extraColumn) {
					if (i > 5)
						break;
					MutationStructure tempMutantStructure = new MutationStructure(
							mutStruct.getMutationType(),
							mutStruct.getMutationTypeNumber(), s.getGroupByNodes(), s);
					tempMutantStructure.setmutationNode(c);
					targetNodes.add(tempMutantStructure);
					i++;

				}
				return targetNodes;
			case 8:
				// PARTIALGROUPBY1
				if (s.getGroupByNodes().size() > 1) {
					for (Node n : s.getGroupByNodes()) {
						MutationStructure tempMutantStructure = new MutationStructure(
								mutStruct.getMutationType(),
								mutStruct.getMutationTypeNumber(), n, s);
						tempMutantStructure.setmutationNode(n.getColumn());
						targetNodes.add(tempMutantStructure);
					}
					return targetNodes;
				}
				break;
			case 10:
				// generate non-equi joins
				Vector<MutationStructure> tempmutants = new Vector<MutationStructure>();
				tempmutants.addAll(getMutatationsFromConjunctsRecursively(s.getConjunctsQs().get(0), s, mutStruct));

				for (MutationStructure mut : tempmutants) {
					if (mut.getMutationLoc() instanceof ConjunctQueryStructure) {
						ConjunctQueryStructure conjunct = (ConjunctQueryStructure) mut.getMutationLoc();
						Vector<Node> nequiJoinNodes = new Vector<Node>();
						nequiJoinNodes.addAll(conjunct.getJoinCondsAllOther());
						nequiJoinNodes.addAll(conjunct.getJoinCondsForEquivalenceClasses());
						for (Node neNode : nequiJoinNodes) {
							Vector<Node> scMutants = UtilsRelatedToNode.getSelectionCondMutations(neNode);
							for (Node scMut : scMutants) {
								if (!neNode.getOperator().equalsIgnoreCase(scMut.getOperator())
										|| scMut.getIsMutant()) {
									MutationStructure tempMutantStructure = new MutationStructure(
											mutStruct.getMutationType(),
											mutStruct.getMutationTypeNumber(), neNode, s);
									tempMutantStructure.setmutationNode(scMut);
									targetNodes.add(tempMutantStructure);
								}
							}
						}
					}
					if (mut.getMutationLoc() instanceof DisjunctQueryStructure) {
						DisjunctQueryStructure conjunct = (DisjunctQueryStructure) mut.getMutationLoc();
						Vector<Node> nequiJoinNodes = new Vector<Node>();
						nequiJoinNodes.addAll(conjunct.getJoinCondsAllOther());
						nequiJoinNodes.addAll(conjunct.getJoinCondsForEquivalenceClasses());
						for (Node neNode : nequiJoinNodes) {
							Vector<Node> scMutants = UtilsRelatedToNode.getSelectionCondMutations(neNode);
							for (Node scMut : scMutants) {
								if (!neNode.getOperator().equalsIgnoreCase(scMut.getOperator())
										|| scMut.getIsMutant()) {
									MutationStructure tempMutantStructure = new MutationStructure(
											mutStruct.getMutationType(),
											mutStruct.getMutationTypeNumber(), neNode, s);
									tempMutantStructure.setmutationNode(scMut);
									targetNodes.add(tempMutantStructure);
								}
							}
						}
					}
				}

				// for (ConjunctQueryStructure conjunct : s.getConjunctsQs()) {
				// // Vector<Node> nequiJoinNodes = conjunct.getAllConds();
				// Vector<Node> nequiJoinNodes = new Vector<Node>();
				// nequiJoinNodes.addAll(conjunct.getJoinCondsAllOther());
				// nequiJoinNodes.addAll(conjunct.getJoinCondsForEquivalenceClasses());
				// for (Node neNode : nequiJoinNodes) {
				// Vector<Node> scMutants =
				// UtilsRelatedToNode.getSelectionCondMutations(neNode);
				// for (Node scMut : scMutants) {
				// if (!neNode.getOperator().equalsIgnoreCase(scMut.getOperator()) ||
				// scMut.getIsMutant()) {
				// MutationStructure tempMutantStructure = new MutationStructure(
				// mutStruct.getMutationType(),
				// mutStruct.getMutationTypeNumber(), neNode, s);
				// tempMutantStructure.setmutationNode(scMut);
				// targetNodes.add(tempMutantStructure);
				// }
				// }
				// // MutationStructure tempMutantStructure = new MutationStructure(
				// // mutStruct.getMutationType(),
				// // mutStruct.getMutationTypeNumber(), neNode, s);
				// // // tempMutantStructure.setmutationNode(neNode);
				// // targetNodes.add(tempMutantStructure);
				// }
				// }
				return targetNodes;
			case 12:
				tempmutants = new Vector<MutationStructure>();
				tempmutants.addAll(getMutatationsFromConjunctsRecursively(s.getConjunctsQs().get(0), s, mutStruct));

				// selection mutations

				for (MutationStructure mut : tempmutants) {
					if (mut.getMutationLoc() instanceof ConjunctQueryStructure) {
						ConjunctQueryStructure conjunct = (ConjunctQueryStructure) mut.getMutationLoc();
						for (Node selecNode : conjunct.getSelectionConds()) {
							Vector<Node> scMutants = UtilsRelatedToNode.getSelectionCondMutations(selecNode);
							for (Node scMut : scMutants) {
								if (!selecNode.getOperator().equalsIgnoreCase(scMut.getOperator())
										|| scMut.getIsMutant()) {
									MutationStructure tempMutantStructure = new MutationStructure(
											mutStruct.getMutationType(),
											mutStruct.getMutationTypeNumber(), selecNode, s);
									tempMutantStructure.setmutationNode(scMut);
									targetNodes.add(tempMutantStructure);
								}
							}
						}
					}
					if (mut.getMutationLoc() instanceof DisjunctQueryStructure) {
						DisjunctQueryStructure conjunct = (DisjunctQueryStructure) mut.getMutationLoc();
						for (Node selecNode : conjunct.getSelectionConds()) {
							Vector<Node> scMutants = UtilsRelatedToNode.getSelectionCondMutations(selecNode);
							for (Node scMut : scMutants) {
								if (!selecNode.getOperator().equalsIgnoreCase(scMut.getOperator())
										|| scMut.getIsMutant()) {
									MutationStructure tempMutantStructure = new MutationStructure(
											mutStruct.getMutationType(),
											mutStruct.getMutationTypeNumber(), selecNode, s);
									tempMutantStructure.setmutationNode(scMut);
									targetNodes.add(tempMutantStructure);
								}
							}
						}
					}
				}

				return targetNodes;
			case 13:
				tempmutants = new Vector<MutationStructure>();
				tempmutants.addAll(getMutatationsFromConjunctsRecursively(s.getConjunctsQs().get(0), s, mutStruct));

				// selection mutations

				for (MutationStructure mut : tempmutants) {
					if (mut.getMutationLoc() instanceof ConjunctQueryStructure) {
						ConjunctQueryStructure conjunct = (ConjunctQueryStructure) mut.getMutationLoc();
						for (Node stringNode : conjunct.getStringSelectionConds()) {
							Vector<Node> scMutants = UtilsRelatedToNode.getStringSelectionCondMutations(stringNode,
									true);
							for (Node scMut : scMutants) {
								if (!stringNode.getOperator().equalsIgnoreCase(scMut.getOperator())
										|| scMut.getIsMutant()) {
									MutationStructure tempMutantStructure = new MutationStructure(
											mutStruct.getMutationType(),
											mutStruct.getMutationTypeNumber(), stringNode, s);
									tempMutantStructure.setmutationNode(scMut);
									targetNodes.add(tempMutantStructure);
								}
							}
						}
					}
					if (mut.getMutationLoc() instanceof DisjunctQueryStructure) {
						DisjunctQueryStructure conjunct = (DisjunctQueryStructure) mut.getMutationLoc();
						for (Node stringNode : conjunct.getStringSelectionConds()) {
							Vector<Node> scMutants = UtilsRelatedToNode.getStringSelectionCondMutations(stringNode,
									true);
							for (Node scMut : scMutants) {
								if (!stringNode.getOperator().equalsIgnoreCase(scMut.getOperator())
										|| scMut.getIsMutant()) {
									MutationStructure tempMutantStructure = new MutationStructure(
											mutStruct.getMutationType(),
											mutStruct.getMutationTypeNumber(), stringNode, s);
									tempMutantStructure.setmutationNode(scMut);
									targetNodes.add(tempMutantStructure);
								}
							}
						}
					}
				}

				return targetNodes;
			case 14:
				i = 0;
				tempmutants = new Vector<MutationStructure>();
				tempmutants.addAll(getMutatationsFromConjunctsRecursively(s.getConjunctsQs().get(0), s, mutStruct));

				for (MutationStructure mut : tempmutants) {
					if (mut.getMutationLoc() instanceof ConjunctQueryStructure) {
						ConjunctQueryStructure conjunct = (ConjunctQueryStructure) mut.getMutationLoc();
						HashMap<String, Table> tables = QueryBlockDetails.getListOfTablesInQueryBlock(cvc, s);
						ArrayList<ArrayList<Node>> extraCommonCols = GenerateConstraintForUnintendedJoins
								.getExtraColumnsWithCommonName(cvc, tables, s, conjunct);
						for (ArrayList<Node> extraCol : extraCommonCols) {
							if (i > 5)
								break;
							Vector<Node> scMutants = UtilsRelatedToNode.getUnintendedMutations(extraCol, conjunct);
							for (Node scMut : scMutants) {
								if (scMut.getIsMutant()) {
									MutationStructure tempMutantStructure = new MutationStructure(
											mutStruct.getMutationType(),
											mutStruct.getMutationTypeNumber(), conjunct, s);
									tempMutantStructure.setmutationNode(scMut);
									targetNodes.add(tempMutantStructure);
								}
							}
							i++;
						}
					}
					if (mut.getMutationLoc() instanceof DisjunctQueryStructure) {
						DisjunctQueryStructure conjunct = (DisjunctQueryStructure) mut.getMutationLoc();
						HashMap<String, Table> tables = QueryBlockDetails.getListOfTablesInQueryBlock(cvc, s);
						ArrayList<ArrayList<Node>> extraCommonCols = GenerateConstraintForUnintendedJoins
								.getExtraColumnsWithCommonName(cvc, tables, s, conjunct);
						for (ArrayList<Node> extraCol : extraCommonCols) {
							if (i > 5)
								break;
							Vector<Node> scMutants = UtilsRelatedToNode.getUnintendedMutations(extraCol, conjunct);
							for (Node scMut : scMutants) {
								if (scMut.getIsMutant()) {
									MutationStructure tempMutantStructure = new MutationStructure(
											mutStruct.getMutationType(),
											mutStruct.getMutationTypeNumber(), conjunct, s);
									tempMutantStructure.setmutationNode(scMut);
									targetNodes.add(tempMutantStructure);
								}
							}
							i++;
						}
					}
				}

				return targetNodes;
			case 15:
				for (ConjunctQueryStructure conjunct : s.getConjunctsQs()) {
					for (Node node : conjunct.getAllSubQueryConds()) {
						Vector<Node> scMutants = UtilsRelatedToNode.getWhereConectiveMutations(node);
						for (Node scMut : scMutants) {
							if (!node.getType().equalsIgnoreCase(scMut.getType()) || scMut.getIsMutant()) {
								MutationStructure tempMutantStructure = new MutationStructure(
										mutStruct.getMutationType(),
										mutStruct.getMutationTypeNumber(), node, s);
								tempMutantStructure.setmutationNode(scMut);
								targetNodes.add(tempMutantStructure);
							}
						}
					}
				}
				return targetNodes;
			case 20:
				if (s.getLevel() == 0) {
					ConjunctQueryStructure con = new ConjunctQueryStructure(new Vector<Node>());
					if (s.getConjunctsQs() != null && s.getConjunctsQs().size() != 0) {
						con = s.getConjunctsQs().get(0);
					}
					for (Node n : s.getProjectedCols()) {
						// Only non-string fields are considered here. The string fields are handled
						// automatically by ensuring that enumeration has different values for

						// chaitra ignore column replacement case for mutations
						if (n.getType().equalsIgnoreCase("CASE NODE")) {
							continue;
						}
						// chaitra ignore column replacement case for mutations end

						Vector<Node> scMutants = UtilsRelatedToNode.getColumnReplacement(cvc, n);
						for (Node scMut : scMutants) {
							if (n.getColumn().getColumnName().equalsIgnoreCase("xdata_cnt"))
								continue;
							if (Configuration.getProperty("printSQL").equalsIgnoreCase("true")) {
								MutationStructure tempMutantStructure = new MutationStructure(
										mutStruct.getMutationType(),
										mutStruct.getMutationTypeNumber(), n, s);
								tempMutantStructure.setmutationNode(scMut);
								targetNodes.add(tempMutantStructure);
							}
							if (n != null && n.getType() != null &&
									(!n.getType().equals(Node.getAggrNodeType()) && n.getColumn() != null
											&& n.getColumn().getDataType() != 12)
									|| n.getType().equals(Node.getBaoNodeType())) {
								MutationStructure tempMutantStructure = new MutationStructure(
										mutStruct.getMutationType(),
										mutStruct.getMutationTypeNumber(), con, s);
								tempMutantStructure.setmutationNode(scMut);
								targetNodes.add(tempMutantStructure);
							}
						}
					}
				}
				return targetNodes;
			// add more as you implement
			case 21:
				MutationStructure tempMutant = new MutationStructure(
						mutStruct.getMutationType(),
						mutStruct.getMutationTypeNumber(), s.getProjectedCols(), s);

				targetNodes.add(tempMutant);

				break;

			// chaitra target nodes for case mutations
			case 23:
				// System.out.println("Here for Case Final!!!!");
				for (i = 0; i < s.getProjectedCols().size(); i++) {
					if (s.getProjectedCols().get(i).getType().equalsIgnoreCase("CASE NODE")) {
						Node caseNode = s.getProjectedCols().get(i);
						Column commonColumnForAllMutants = parsing.ProcessSelectClause.setCaseProjectionColumn(
								caseNode.getCaseExpression().getWhenConditionals().get(0).getWhenNode());
						Vector<CaseCondition> caseMutantConds = UtilsRelatedToNode
								.getCaseCondMutations(caseNode.getCaseExpression().getWhenConditionals().get(0));
						for (CaseCondition c : caseMutantConds) {
							if (!caseNode.getCaseExpression().getWhenConditionals().get(0).getWhenNode().getOperator()
									.equalsIgnoreCase(c.getWhenNode().getOperator())) {
								Node caseMutant = caseNode.clone();
								caseMutant.setColumn(commonColumnForAllMutants);
								caseMutant.setIsMutant(true);
								caseMutant.getCaseExpression().getWhenConditionals().set(0, c);
								MutationStructure tempMutantStructure = new MutationStructure(
										mutStruct.getMutationType(), mutStruct.getMutationTypeNumber(), caseNode, s);
								tempMutantStructure.setmutationNode(caseMutant);
								targetNodes.add(tempMutantStructure);
							}
						}
					}
				}
				break;
			// chaitra target nodes for case mutations end

			case 24:
				if (s.isDistinct() == false) {
					s.setDistinct(true);
					MutationStructure tempMutantStructure = new MutationStructure(
							mutStruct.getMutationType(),
							mutStruct.getMutationTypeNumber(), s.getProjectedCols(), s);

					targetNodes.add(tempMutantStructure);
					// s.setDistinct(false);
				}
			case 25:

				for (i = 0; i < s.getProjectedCols().size(); i++) {

					if (s.getProjectedCols().get(i).getType().equalsIgnoreCase("ANALYTICAL NODE")) {
						List<Object> pair = new ArrayList<>();
						pair.add(s.getProjectedCols().get(i));
						pair.add(0);
						MutationStructure tempMutantW = new MutationStructure(
								mutStruct.getMutationType(),
								mutStruct.getMutationTypeNumber(), pair, s);

						targetNodes.add(tempMutantW);
					}
				}

				break;
			case 26:

				MutationStructure temp = new MutationStructure(mutStruct.getMutationType(),
						mutStruct.getMutationTypeNumber(), null, s);
				targetNodes.add(temp);

				break;
			case 27:
				// ORDER BY mutants
				if (s.getOrderByNodes().size() > 0) {
					Node orderByNode = s.getOrderByNodes().get(0);
					Column col = orderByNode.getColumn();
					boolean hasLimit = s.getLimit() > 0;
					// New mutant: enforce 2 tuples for ORDER BY table, but do not impose null
					// constraints on ORDER BY column.
					MutationStructure twoTupleNoNullConstraint = new MutationStructure(
							mutStruct.getMutationType(),
							mutStruct.getMutationTypeNumber(), orderByNode, s);
					twoTupleNoNullConstraint.setmutationNode("ORDER_BY_TWO_TUPLES_NO_NULL_CONSTRAINT");
					targetNodes.add(twoTupleNoNullConstraint);

					// New mutant: enforce 2 tuples, one NULL and one NON-NULL on ORDER BY column.
					if (col.isNullable()) {
						MutationStructure twoTupleNullAndNonNull = new MutationStructure(
								mutStruct.getMutationType(),
								mutStruct.getMutationTypeNumber(), orderByNode, s);
						twoTupleNullAndNonNull.setmutationNode("ORDER_BY_TWO_TUPLES_NULL_AND_NON_NULL");
						targetNodes.add(twoTupleNullAndNonNull);
					}

					// New mutant: wrong-attribute trap dataset.
					// Make ORDER BY column increase while all other columns decrease across tuples.
					MutationStructure wrongAttributeTrap = new MutationStructure(
							mutStruct.getMutationType(),
							mutStruct.getMutationTypeNumber(), orderByNode, s);
					wrongAttributeTrap.setmutationNode("ORDER_BY_WRONG_ATTRIBUTE_TRAP");
					targetNodes.add(wrongAttributeTrap);

					// Extra dataset for multi-column ORDER BY:
					// force lexicographic ordering constraints across all ORDER BY columns.
					if (s.getOrderByNodes().size() > 1) {
						MutationStructure multiColumnLex = new MutationStructure(
								mutStruct.getMutationType(),
								mutStruct.getMutationTypeNumber(), orderByNode, s);
						multiColumnLex.setmutationNode("ORDER_BY_MULTI_COLUMN_LEX");
						targetNodes.add(multiColumnLex);
					}

					// Existing mutant behavior for nullable ORDER BY column (top tuple null)
					// should only be considered when LIMIT is explicitly present and is LIMIT 1.
					if (hasLimit && s.getLimit() == 1 && col.isNullable()) {
						MutationStructure tempMutantStructure = new MutationStructure(
								mutStruct.getMutationType(),
								mutStruct.getMutationTypeNumber(), orderByNode, s);
						tempMutantStructure.setmutationNode(col);
						targetNodes.add(tempMutantStructure);
					}
				}
				return targetNodes;

			case 28:
				// DATE ARITHMETIC OPERATOR MUTATIONS
				// Mutate: date_column + interval 'X' to date_column - interval 'X' (and vice
				// versa)
				tempmutants = new Vector<MutationStructure>();
				tempmutants.addAll(getMutatationsFromConjunctsRecursively(s.getConjunctsQs().get(0), s, mutStruct));

				for (MutationStructure mut : tempmutants) {
					if (mut.getMutationLoc() instanceof ConjunctQueryStructure) {
						ConjunctQueryStructure conjunct = (ConjunctQueryStructure) mut.getMutationLoc();
						for (Node selecNode : conjunct.getSelectionConds()) {
							Vector<Node> dateArithMutants = UtilsRelatedToNode.getDateArithmeticMutations(selecNode);
							for (Node dateArithMut : dateArithMutants) {
								if (!selecNode.equals(dateArithMut)) {
									MutationStructure tempMutantStructure = new MutationStructure(
											mutStruct.getMutationType(),
											mutStruct.getMutationTypeNumber(), selecNode, s);
									tempMutantStructure.setmutationNode(dateArithMut);
									targetNodes.add(tempMutantStructure);
								}
							}
						}
					}
					if (mut.getMutationLoc() instanceof DisjunctQueryStructure) {
						DisjunctQueryStructure conjunct = (DisjunctQueryStructure) mut.getMutationLoc();
						for (Node selecNode : conjunct.getSelectionConds()) {
							Vector<Node> dateArithMutants = UtilsRelatedToNode.getDateArithmeticMutations(selecNode);
							for (Node dateArithMut : dateArithMutants) {
								if (!selecNode.equals(dateArithMut)) {
									MutationStructure tempMutantStructure = new MutationStructure(
											mutStruct.getMutationType(),
											mutStruct.getMutationTypeNumber(), selecNode, s);
									tempMutantStructure.setmutationNode(dateArithMut);
									targetNodes.add(tempMutantStructure);
								}
							}
						}
					}
				}
				return targetNodes;

			default:
				break;
		}

		return targetNodes;
	}

	private static Vector<MutationStructure> getMutatationsFromConjunctsRecursively(
			ConjunctQueryStructure conjunct, QueryBlockDetails s, MutationStructure mutStruct) {
		// TODO Auto-generated method stub
		Vector<MutationStructure> targetMutants = new Vector<MutationStructure>();

		// for (Vector<Node> equiClasses : conjunct.getEquivalenceClasses()) {
		try {
			if (conjunct.getDisjuncts() != null && conjunct.getDisjuncts().size() != 0) {
				for (DisjunctQueryStructure disjunct : conjunct.getDisjuncts()) {
					MutationStructure tempMutantStructure = new MutationStructure(mutStruct.getMutationType(),
							mutStruct.getMutationTypeNumber(), disjunct, s);
					targetMutants.add(tempMutantStructure);
					if (disjunct.conjuncts != null && disjunct.conjuncts.size() != 0) {
						for (ConjunctQueryStructure con : disjunct.conjuncts)
							targetMutants.addAll(getMutatationsFromConjunctsRecursively(con, s, mutStruct));
					}
				}
			}
			MutationStructure tempMutantStructure = new MutationStructure(mutStruct.getMutationType(),
					mutStruct.getMutationTypeNumber(), conjunct, s);
			targetMutants.add(tempMutantStructure);
			// }
		} catch (Exception e) {
			System.out.println(e.getMessage());
			throw new UnsupportedOperationException("Unimplemented method getMutatationsFromConjunctsRecursively'");
		}
		return targetMutants;

		// throw new UnsupportedOperationException("Unimplemented method
		// 'getMutatationsFromConjunctsRecursively'");
	}

	private static void preprocessBeforeKillingMutants(GenerateCVC1 cvc, MutationStructure mutStruct) throws Exception {
		QueryStructure qStructure = new QueryStructure(cvc.getTableMap());
		String buildString = cvc.getqStructure().getLeftQuery().getQuery().getQueryString() + " "
				+ mutStruct.getMutationNode().toString() + " "
				+ cvc.getqStructure().getRightQuery().getQuery().getQueryString();
		if (buildString.contains("INTERSECT ALL") || buildString.contains("intersect all")
				|| buildString.toString().contains("EXCEPT ALL")
				|| buildString.toString().contains("except all")) {
			cvc.isAll = 1;
		}
		qStructure.buildQueryStructure("q1", buildString, cvc.getDBAppparams());
		qStructure.buildSQLevel();
		qStructure.buildSetNo();
		qStructure.orgSetOperator = cvc.getqStructure().setOperator;
		cvc.setqStructure(qStructure);
		cvc.initializeAllQueryDetails(cvc.getqStructure());

		ArrayList<ForeignKey> foreignK = new ArrayList<ForeignKey>();

		for (ForeignKey key : cvc.getForeignKeysModified()) {
			if (!foreignK.contains(key)) {
				foreignK.add(key);
			}
		}
		cvc.setForeignKeysModified(foreignK);
		cvc.initializeOtherDetails();
		cvc.setConstraintSolver(Configuration.getProperty("smtsolver"));

		cvc.setSolverSpecificCommentCharacter(";");
	}

	/*
	 * @author Sunanda
	 * Main function for generating dataset for specific mutation
	 */
	private static void generateDatasetForSpecificMutation(GenerateCVC1 cvc, QueryBlockDetails qbd,
			MutationStructure mutStruct) throws Exception {

		switch (mutStruct.getMutationTypeNumber()) {
			case 1:
				// generate non-empty dataset
				GenerateDataForOriginalQuery.generateDataForOriginalQuery(cvc, mutStruct.getMutationType());
				break;
			case 2:
				// generate agg
				cvc.inititalizeForDatasetQs();
				cvc.setTypeOfMutation(TagDatasets.MutationType.AGG, TagDatasets.QueryBlock.OUTER_BLOCK);
				cvc.setCurrentMutant(mutStruct);
				Node aggFun = (Node) mutStruct.getMutationLoc();
				/** Get aggregate function to kill in this iteration */
				AggregateFunction af = aggFun.getAgg();
				Column c = aggFun.getColumn();
				if (af.getAggExp() == null) { // projected attribute is not an aggregate
					break;
				}

				/** assign the number of tuples for the this outer query block */
				if (QueryBlockDetails.getTupleAssignment(cvc, qbd, null) == false)
					break;

				/** get the tuple assignment for all other query blocks */
				if (CountEstimationRelated.getTupleAssignmentExceptQueryBlock(cvc, qbd) == false)
					break;

				Node aggNode = Node.createNode(c, c.getTable());
				AggregateFunction ag = new AggregateFunction();
				Node columnNode = new Node(aggNode);
				columnNode.setTable(aggFun.getTable());
				columnNode.setTableAlias(aggFun.getTableAlias());
				columnNode.setTableNameNo(aggFun.getTableNameNo());

				ag.setAggExp(columnNode);
				ag.setFunc(AggregateFunction.getAggCOUNT());

				aggNode.setAgg(ag);
				aggNode.setType(Node.getAggrNodeType());
				aggNode.setTableAlias(columnNode.getTableAlias());
				aggNode.setTableNameNo(columnNode.getTableNameNo());
				aggNode.setIsMutant(true);
				qbd.getProjectedCols().add(aggNode);

				GenerateDataForOriginalQuery.generateDataForQueryMutants(cvc, mutStruct);

				int index = mutStruct.getQueryBlock().getGroupByNodes().size();

				qbd.getProjectedCols().remove(aggNode);

				// qbd.setConstrainedAggregation(true);

				/** get the count needed */

				break;
			case 3:
				// generate count
				break;
			case 4:
				// generate having
				Node mutNode = (Node) mutStruct.getMutationNode();
				Node mutLoc = (Node) mutStruct.getMutationLoc();
				System.out.print("Aggregate Constraints Mutation: " + mutNode + " killed\n");
				Node havingClause = qbd.getAggConstraints().get(qbd.getAggConstraints().indexOf(mutLoc));
				String op = mutLoc.getOperator();
				havingClause.setOperator(mutNode.getOperator());
				cvc.setCurrentMutant(mutStruct);
				// cvc.inititalizeForDatasetQs();
				GenerateDataForOriginalQuery.generateDataForQueryMutants(cvc, mutStruct);
				havingClause.setOperator(op);
				break;
			case 5:
				// generate distinct
				Node prNode = ((ArrayList<Node>) mutStruct.getMutationLoc()).get(0);
				c = prNode.getColumn();
				// System.out.print("Extra Attribute Mutation in Group By Clause Killed: " +
				// c.getTableName() + " "
				// + c.getColumnName() + "\n");

				aggNode = prNode.clone();
				ag = new AggregateFunction();
				columnNode = new Node(aggNode);
				ag.setAggExp(columnNode);
				ag.setFunc(AggregateFunction.getAggCOUNT());
				aggNode.setOrgiColumn(c);
				aggNode.setAgg(ag);
				aggNode.setType(Node.getAggrNodeType());
				aggNode.setTableNameNo(columnNode.getTableNameNo());
				aggNode.setIsMutant(true);
				qbd.getProjectedCols().add(aggNode);

				cvc.setCurrentMutant(mutStruct);
				// cvc.inititalizeForDatasetQs();
				GenerateDataForOriginalQuery.generateDataForQueryMutants(cvc, mutStruct);

				qbd.getProjectedCols().remove(aggNode);

				break;
			case 6:
				// generate data to kill equivalence class mutations
				Object conjunct = null;
				Vector<Vector<Node>> equivalenceClassesOrig = new Vector<Vector<Node>>();
				if (mutStruct.getMutationLoc() instanceof ConjunctQueryStructure) {
					conjunct = (ConjunctQueryStructure) mutStruct.getMutationLoc();
					System.out.print("Killing equivalence class mutations: " + qbd.getLevel() + " "
							+ ((ConjunctQueryStructure) conjunct).getEquivalenceClasses() + "\n");
					equivalenceClassesOrig
							.addAll((Vector<Vector<Node>>) ((ConjunctQueryStructure) conjunct).getEquivalenceClasses()
									.clone());
				}
				if (mutStruct.getMutationLoc() instanceof DisjunctQueryStructure) {
					conjunct = (DisjunctQueryStructure) mutStruct.getMutationLoc();
					System.out.print("Killing equivalence class mutations: " + qbd.getLevel() + " "
							+ ((DisjunctQueryStructure) conjunct).getEquivalenceClasses() + "\n");
					equivalenceClassesOrig
							.addAll((Vector<Vector<Node>>) ((DisjunctQueryStructure) conjunct).getEquivalenceClasses()
									.clone());
				}

				// logger.log(Level.INFO,"\n----------------------------------");
				// logger.log(Level.INFO,"KILLING EC IN WHERE CLAUSE SUBQUERY BLOCK: " +
				// equivalenceClassesOrig);
				// logger.log(Level.INFO,"\n----------------------------------\n");

				/** For each equivalence class of this sub query */
				// for(int i=0; i< equivalenceClassesOrig.size(); i++){
				for (int i = (equivalenceClassesOrig.size() - 1); i >= 0; i--) {

					/** Get the equivalence class that is to be killed */
					Vector<Node> ec = (Vector<Node>) equivalenceClassesOrig.get(i).clone();

					/** Update the equivalence classes...these are used during tuple assignment */
					if (mutStruct.getMutationLoc() instanceof ConjunctQueryStructure) {
						((ConjunctQueryStructure) conjunct)
								.setEquivalenceClasses((Vector<Vector<Node>>) equivalenceClassesOrig.clone());
						((ConjunctQueryStructure) conjunct).getEquivalenceClasses().remove(ec);
					}
					if (mutStruct.getMutationLoc() instanceof DisjunctQueryStructure) {
						((DisjunctQueryStructure) conjunct)
								.setEquivalenceClasses((Vector<Vector<Node>>) equivalenceClassesOrig.clone());
						((DisjunctQueryStructure) conjunct).getEquivalenceClasses().remove(ec);
					}

					// HashMap<String, Object> exdetails = new HashMap<String, Object>();
					Node ecNodeTemp = null;
					/** Update the equivalence classes...these are used during tuple assignment */
					if (!(mutStruct.getMutationLoc() instanceof ConjunctQueryStructure)
							|| !(mutStruct.getMutationLoc() instanceof DisjunctQueryStructure)) {
						mutStruct.setMutationLoc(conjunct);
					}
					if (mutStruct.getMutationLoc() instanceof ConjunctQueryStructure) {
						((ConjunctQueryStructure) conjunct)
								.setEquivalenceClasses((Vector<Vector<Node>>) equivalenceClassesOrig.clone());
						((ConjunctQueryStructure) conjunct).getEquivalenceClasses().remove(ec);
						ConjunctQueryStructure cj = (ConjunctQueryStructure) conjunct;
						Vector<Node> jcforEq = cj.getJoinCondsForEquivalenceClasses();
						Vector<Node> jcforEqUp = new Vector<Node>();
						for (Node n : jcforEq) {
							Node r = n.getRight();
							Node l = n.getLeft();
							boolean flag = false;
							// for(Vector<Node> e: equivalenceClassesOrig){
							if (ec.contains(r) && ec.contains(l)) {
								// jcforEqUp.add(n);
								n.isNegated = true;
								flag = true;
								ecNodeTemp = n;
							}
							// }
							if (flag == false)
								jcforEqUp.add(n);

						}
						// exdetails.put("conjunct", jcforEqUp);
					}
					if (mutStruct.getMutationLoc() instanceof DisjunctQueryStructure) {
						((DisjunctQueryStructure) conjunct)
								.setEquivalenceClasses((Vector<Vector<Node>>) equivalenceClassesOrig.clone());
						((DisjunctQueryStructure) conjunct).getEquivalenceClasses().remove(ec);
						DisjunctQueryStructure cj = (DisjunctQueryStructure) conjunct;
						Vector<Node> jcforEq = cj.getJoinCondsForEquivalenceClasses();
						Vector<Node> jcforEqUp = new Vector<Node>();
						for (Node n : jcforEq) {
							Node r = n.getRight();
							Node l = n.getLeft();
							boolean flag = false;
							// for(Vector<Node> e: equivalenceClassesOrig){

							if (ec.contains(r) && ec.contains(l)) {
								// jcforEqUp.add(n);
								flag = true;
								n.isNegated = true;
								ecNodeTemp = n;
							}
							// }
							if (flag == false)
								jcforEqUp.add(n);

						}

						// exdetails.put("conjunct", jcforEqUp);
					}
					/** In this iteration we are killing equivalence class 'ec' */
					qbd.setEquivalenceClassesKilled(ec);

					/**
					 * Initialize the data structures for generating the data to kill this mutation
					 */
					cvc.inititalizeForDatasetQs();

					/** set the type of mutation we are trying to kill */
					cvc.setTypeOfMutation(TagDatasets.MutationType.EQUIVALENCE, TagDatasets.QueryBlock.WHERE_SUBQUERY);

					/**
					 * get the tuple assignment for this query
					 * If no possible assignment then not possible to kill this mutation
					 */
					if (GenerateCVC1.tupleAssignmentForQuery(cvc) == false)
						continue;

					/** keep a copy of this tuple assignment values */
					HashMap<String, Integer> noOfOutputTuplesOrig1 = (HashMap<String, Integer>) cvc
							.cloneNoOfOutputTuples();
					HashMap<String, Integer> noOfTuplesOrig1 = (HashMap<String, Integer>) cvc.getNoOfTuples().clone();
					HashMap<String, Integer[]> repeatedRelNextTuplePosOrig1 = (HashMap<String, Integer[]>) cvc
							.getRepeatedRelNextTuplePos().clone();

					// for (int j = 0; j < ec.size(); j++) {
					// cvc.setCurrentMutant(mutStruct);
					// // logger.log(Level.INFO,"\n----------------------------------\n");
					// cvc.setConstraints(new ArrayList<String>());
					// cvc.setStringConstraints(new ArrayList<String>());
					// cvc.setCVCStr("");
					// /** Add constraints related to parameters */
					// cvc.getConstraints().add(RelatedToParameters.addDatatypeForParameters(cvc,
					// qbd));
					// cvc.setResultsetTableColumns1(new HashMap<Table, Vector<String>>());
					// cvc.setNoOfTuples((HashMap<String, Integer>) noOfTuplesOrig1.clone());
					// cvc.setNoOfOutputTuples((HashMap<String, Integer>)
					// noOfOutputTuplesOrig1.clone());
					// cvc.setRepeatedRelNextTuplePos(
					// (HashMap<String, Integer[]>) repeatedRelNextTuplePosOrig1.clone());

					// String CVCStr = "";
					// Node eceNulled = ec.get(j);
					// CVCStr += ConstraintGenerator
					// .addCommentLine("DataSet Generated By Nulling: " + eceNulled.toString() +
					// "\n");

					// // if (RelatedToEquivalenceClassMutations.getConstraintsForNulledColumns(cvc,
					// qbd, ec,
					// // eceNulled) == false)
					// // continue;
					// /** Call the method for the data generation */
					// // GenerateDataForOriginalQuery.generateDataForQueryMutants(cvc, mutStruct);
					// // // print not added - parismita ??
					// // if(ecNodeTemp != null)
					// // ecNodeTemp.isNegated = false;
					// }
					GenerateDataForOriginalQuery.generateDataForQueryMutants(cvc, mutStruct);
					// print not added - parismita ??
					if (ecNodeTemp != null)
						ecNodeTemp.isNegated = false;
				}

				if (mutStruct.getMutationLoc() instanceof ConjunctQueryStructure) {
					conjunct = (ConjunctQueryStructure) mutStruct.getMutationLoc();
					System.out.print("Killing equivalence class mutations: " + qbd.getLevel() + " "
							+ ((ConjunctQueryStructure) conjunct).getEquivalenceClasses() + "\n");
					((ConjunctQueryStructure) conjunct).getEquivalenceClasses()
							.addAll(equivalenceClassesOrig);
				}
				if (mutStruct.getMutationLoc() instanceof DisjunctQueryStructure) {
					conjunct = (DisjunctQueryStructure) mutStruct.getMutationLoc();
					System.out.print("Killing equivalence class mutations: " + qbd.getLevel() + " "
							+ ((DisjunctQueryStructure) conjunct).getEquivalenceClasses() + "\n");
					((DisjunctQueryStructure) conjunct).getEquivalenceClasses()
							.addAll(equivalenceClassesOrig);
				}
				System.out.println();
				break;
			case 7:
				if (qbd.getGroupByNodes().size() != 0) {
					cvc.setCurrentMutant(mutStruct);
					// Node temp = (Node)((ArrayList) mutStruct.getMutationLoc()).get(0);
					c = ((Column) mutStruct.getMutationNode());
					System.out.print("Extra Attribute Mutation in Group By Clause Killed: " + c.getTableName() + " "
							+ c.getColumnName() + "\n");

					aggNode = Node.createNode(c, c.getTable());
					ag = new AggregateFunction();
					columnNode = new Node(aggNode);
					ag.setAggExp(columnNode);
					ag.setFunc(AggregateFunction.getAggCOUNT());

					aggNode.setAgg(ag);
					aggNode.setType(Node.getAggrNodeType());
					aggNode.setTableNameNo(columnNode.getTableNameNo());
					aggNode.setIsMutant(true);
					qbd.getProjectedCols().add(aggNode);

					// GenerateDataForOriginalQuery.generateDataForQueryMutants(cvc, mutStruct);
					// mutStruct.orderByMutant=true;
					// System.out.println("Creating Dataset to generate nulls in columns of order
					// by");
					GenerateDataForOriginalQuery.generateDataForQueryMutants(cvc, mutStruct);
					index = mutStruct.getQueryBlock().getGroupByNodes().size();
					// mutStruct.getQueryBlock().getGroupByNodes().remove(index - 1);

					qbd.getProjectedCols().remove(aggNode);
				}
				break;

			case 8:
				if (qbd.getGroupByNodes().size() != 0) {
					cvc.setCurrentMutant(mutStruct);
					Node temp = (Node) mutStruct.getMutationLoc();

					Column n = ((Column) mutStruct.getMutationNode());
					System.out.print("Missing Attribute Mutation in Group By Clause Killed: " + " " + n + "\n");

					aggNode = Node.createNode(n, n.getTable());
					ag = new AggregateFunction();
					columnNode = new Node(aggNode);

					ag.setAggExp(columnNode);
					ag.setFunc(AggregateFunction.getAggCOUNT());

					aggNode.setAgg(ag);
					aggNode.setType(Node.getAggrNodeType());
					aggNode.setTableNameNo(columnNode.getTableNameNo());
					aggNode.setIsMutant(true);
					qbd.getProjectedCols().add(aggNode);

					qbd.getGroupByNodes().remove(temp);

					GenerateDataForOriginalQuery.generateDataForQueryMutants(cvc, mutStruct);
					index = mutStruct.getQueryBlock().getGroupByNodes().size();
					// mutStruct.getQueryBlock().getGroupByNodes().remove(index-1);

					qbd.getGroupByNodes().add(temp);
					qbd.getProjectedCols().remove(aggNode);
				}
				break;
			case 10:
				Node pred = (Node) mutStruct.getMutationLoc();
				Node predMut = (Node) mutStruct.getMutationNode();
				String oldOperator = pred.getOperator();
				// alternate way is to set isNegated true when this mutant is activated
				cvc.setCurrentMutant(mutStruct);
				System.out.println("#############################");
				System.out.print("Level " + qbd.getLevel() + " " + pred + " changed to (" + pred.getLeft()
						+ predMut.getOperator()
						+ pred.getRight() + ")\n");
				System.out.println("#############################");
				HashMap<String, Table> rels = UtilsRelatedToNode.getListOfRelationsFromNode(cvc,
						mutStruct.getQueryBlock(), pred);

				// Iterator rel = rels.keySet().iterator();
				// while(rel.hasNext()){

				String CVCStr = "";
				cvc.setConstraints(new ArrayList<String>());
				cvc.setStringConstraints(new ArrayList<String>());
				cvc.setTypeOfMutation("");
				cvc.setCVCStr("");

				/** set the type of mutation we are trying to kill */
				cvc.setTypeOfMutation(TagDatasets.MutationType.NONEQUIJOIN, TagDatasets.QueryBlock.OUTER_BLOCK);

				/** Add constraints related to parameters */
				cvc.getConstraints().add(RelatedToParameters.addDatatypeForParameters(cvc, qbd));

				// String aliasName = (String)rel.next();
				// String tableName = rels.get(aliasName).getTableName();

				/**
				 * FIXME: This function is generating constraints of form ASSERT NOT EXISTS (i:
				 * O_SECTION_INDEX_INT): ((O_SECTION[1].0>O_TAKES[1].1));
				 * These are causing problem. Example query19
				 */
				/**
				 * FIXME: Also the repeated relations are not correctly handled in the below
				 * method
				 */
				// cvc.getConstraints().add(
				// GenerateCVCConstraintForNode.genNegativeCondsForPredAgg(cvc, qbd, pred,
				// aliasName, tableName) );

				/**
				 * get positive constraints for all conditions except all conditions of the
				 * conjunct
				 */
				// cvc.getConstraints().add(
				// GenerateConstraintsForConjunct.getConstraintsForConjuctExceptNonEquiJoins(cvc,
				// qbd, conjunct) );

				GenerateDataForOriginalQuery.generateDataForQueryMutants(cvc, mutStruct);
				pred.setOperator(oldOperator);
				// }
				break;

			case 12:
				Node n = (Node) mutStruct.getMutationLoc();
				oldOperator = n.getOperator();

				System.out.println("#############################");
				System.out.print("Mutant from level " + qbd.getLevel() + " " + n + "changed to"
						+ (Node) mutStruct.getMutationNode() + "\n");
				System.out.println("#############################");
				cvc.setCurrentMutant(mutStruct);
				GenerateDataForOriginalQuery.generateDataForQueryMutants(cvc, mutStruct);
				n.setOperator(oldOperator);
				mutStruct.setIsExpired(true);
				break;

			case 13:
				n = (Node) mutStruct.getMutationLoc();
				oldOperator = n.getOperator();
				Node oldRight = n.getRight();
				System.out.println("#############################");
				System.out.print("Mutant from level " + qbd.getLevel() + " " + (Node) mutStruct.getMutationLoc()
						+ "changed to" + (Node) mutStruct.getMutationNode() + "\n");
				System.out.println("#############################");
				int iMatched = -1, jMatched = -1;
				boolean found = false;

				for (int i = 0; i < cvc.getOuterBlock().getConjunctsQs().size(); i++) {
					for (int j = 0; j < cvc.getOuterBlock().getConjunctsQs().get(i).getStringSelectionConds()
							.size(); j++) {
						if (cvc.getOuterBlock().getConjunctsQs().get(i).getStringSelectionConds().get(j).equals(n)) {
							cvc.getOuterBlock().getConjunctsQs().get(i).getStringSelectionConds().set(j,
									(Node) mutStruct.getMutationNode());
							iMatched = i;
							jMatched = j;
							found = true;
							break;
						}
					}
					if (found)
						break;
				}

				cvc.setCurrentMutant(mutStruct);
				if (cvc.getStringSolver().generatedStringMap.size() > 0) {
					cvc.getStringSolver().generatedStringMap.clear();
				}

				GenerateDataForOriginalQuery.generateDataForQueryMutants(cvc, mutStruct);

				// Now undo the mutation using saved indices
				if (iMatched != -1 && jMatched != -1) {
					cvc.getOuterBlock().getConjunctsQs().get(iMatched).getStringSelectionConds().set(jMatched, n);
				}
				n.setOperator(oldOperator);
				n.setRight(oldRight);
				mutStruct.setIsExpired(true);
				break;
			case 14:

				if (mutStruct.getMutationLoc() instanceof ConjunctQueryStructure) {
					ConjunctQueryStructure con = (ConjunctQueryStructure) mutStruct.getMutationLoc();
					con.getJoinCondsForEquivalenceClasses().add((Node) mutStruct.getMutationNode());
					System.out.println("#############################");
					System.out.print("Unintended Join Mutant from level " + qbd.getLevel()
							+ " added constraints for " + (Node) mutStruct.getMutationNode() + "\n");
					System.out.println("#############################");
					cvc.setCurrentMutant(mutStruct);
					GenerateDataForOriginalQuery.generateDataForQueryMutants(cvc, mutStruct);
					con.getJoinCondsForEquivalenceClasses().remove((Node) mutStruct.getMutationNode());
					mutStruct.setIsExpired(true);
					break;
				}
				if (mutStruct.getMutationLoc() instanceof DisjunctQueryStructure) {
					DisjunctQueryStructure con = (DisjunctQueryStructure) mutStruct.getMutationLoc();
					con.getJoinCondsForEquivalenceClasses().add((Node) mutStruct.getMutationNode());
					System.out.println("#############################");
					System.out.print("Unintended Join Mutant from level " + qbd.getLevel()
							+ " added constraints for " + (Node) mutStruct.getMutationNode() + "\n");
					System.out.println("#############################");
					cvc.setCurrentMutant(mutStruct);
					GenerateDataForOriginalQuery.generateDataForQueryMutants(cvc, mutStruct);
					con.getJoinCondsForEquivalenceClasses().remove((Node) mutStruct.getMutationNode());
					mutStruct.setIsExpired(true);
					break;
				}

			case 15:
				n = (Node) mutStruct.getMutationLoc();
				oldOperator = n.getType();
				System.out.println("#############################");
				System.out.print("Mutant from level " + qbd.getLevel() + " " + (Node) mutStruct.getMutationLoc()
						+ "changed to" + (Node) mutStruct.getMutationNode() + "\n");
				System.out.println("#############################");
				cvc.setCurrentMutant(mutStruct);
				GenerateDataForOriginalQuery.generateDataForQueryMutants(cvc, mutStruct);
				n.setType(oldOperator);
				mutStruct.setIsExpired(true);
				break;
			case 20:
				if (qbd.getLevel() == 0) {
					mutNode = (Node) mutStruct.getMutationNode();
					if (Configuration.getProperty("printSQL").equalsIgnoreCase("true")) {
						System.out.println("#############################");
						System.out.print("Column Replacement Mutant from level " + qbd.getLevel() +
								" condition " + mutNode + "\n");
						System.out.println("#############################");
						cvc.setCurrentMutant(mutStruct);
						GenerateDataForOriginalQuery.generateDataForQueryMutants(cvc, mutStruct);
						mutStruct.setIsExpired(true);
					} else {
						ConjunctQueryStructure con = (ConjunctQueryStructure) mutStruct.getMutationLoc();

						con.getSelectionConds().add(mutNode);
						System.out.println("#############################");
						System.out.print("Column Replacement Mutant from level " + qbd.getLevel() +
								" condition " + mutNode + "\n");
						System.out.println("#############################");
						cvc.setCurrentMutant(mutStruct);
						GenerateDataForOriginalQuery.generateDataForQueryMutants(cvc, mutStruct);
						con.getSelectionConds().remove(mutNode);
						mutStruct.setIsExpired(true);
					}
				}

				break;
			case 21:
				// must add code
				if (qbd.isSet == -1)
					break;
				else {
					System.out.println("Setop mutant start");
					GenerateDataForOriginalQuery.generateDataForQueryMutantsForSet(cvc, mutStruct);
					System.out.println("Setop mutant end");

					break;

				}

				// chaitra gen dataset for mutations of case
			case 23:
				System.out.println("Here for Case Nodes!!");
				n = (Node) mutStruct.getMutationLoc();
				oldOperator = n.getOperator();

				System.out.println("#############################");
				System.out.print("Mutant of CASE from level " + qbd.getLevel() + " " + n + "changed to"
						+ (Node) mutStruct.getMutationNode() + "\n");
				System.out.println("#############################");
				cvc.setCurrentMutant(mutStruct);
				GenerateDataForOriginalQuery.generateDataForCaseMutants(cvc, mutStruct);
				n.setOperator(oldOperator);
				mutStruct.setIsExpired(true);
				break;
			// chaitra gen dataset for mutations for case end

			case 24:
				prNode = ((ArrayList<Node>) mutStruct.getMutationLoc()).get(0);
				c = prNode.getColumn();
				aggNode = prNode.clone();
				ag = new AggregateFunction();
				columnNode = new Node(aggNode);
				ag.setAggExp(columnNode);
				ag.setFunc(AggregateFunction.getAggCOUNT());
				aggNode.setOrgiColumn(c);
				aggNode.setAgg(ag);
				aggNode.setType(Node.getAggrNodeType());
				aggNode.setTableNameNo(columnNode.getTableNameNo());
				aggNode.setIsMutant(true);
				qbd.getProjectedCols().add(aggNode);

				cvc.setCurrentMutant(mutStruct);
				// cvc.inititalizeForDatasetQs();
				GenerateDataForOriginalQuery.generateDataForQueryMutants(cvc, mutStruct);

				qbd.getProjectedCols().remove(aggNode);
				qbd.setDistinct(false);

			case 25:

				// kumaran

				// rank vs dense rank
				System.out.println("**** this dataset is used to kill mutation beween rank vs dense rank ****\n");
				System.out.println(
						"**** DS1 will only be created when there is a dense_rank or rank present in query ****\n");
				List<Object> retrievedPair = (List<Object>) mutStruct.getMutationLoc();
				retrievedPair.set(1, 1);
				mutStruct.setMutationLoc(retrievedPair);
				GenerateDataForOriginalQuery.generateDataForQueryMutantsForWindow(cvc, mutStruct);
				System.out.println("***** End of DS1 created");

				// missing attribute in order by 2v1 1st mutation
				System.out.println(
						"**** this dataset is used to kill missing order by mutation, 2nd order by element is missing ****\n");
				System.out.println(
						"**** DS2 will only be created when there is exactly 2 elements in the order by elements ****\n");
				retrievedPair.set(1, 2);
				mutStruct.setMutationLoc(retrievedPair);
				GenerateDataForOriginalQuery.generateDataForQueryMutantsForWindow(cvc, mutStruct);
				System.out.println("***** End of DS2 created");

				// missing attribute in order by 2v1 2nd mutation
				System.out.println(
						"**** this dataset is used to kill missing order by mutation, 1sr order by element is missing ****\n");
				System.out.println(
						"**** DS3 will only be created when there is exactly 2 elements in the order by elements ****\n");
				retrievedPair.set(1, 3);
				mutStruct.setMutationLoc(retrievedPair);
				GenerateDataForOriginalQuery.generateDataForQueryMutantsForWindow(cvc, mutStruct);
				System.out.println("***** End of DS3 created");

				// ordering of order by attributes
				System.out.println("**** this dataset is used to kill order by elements are on the wrong order ****\n");
				System.out.println(
						"**** DS4 will only be created when there is exactly 2 elements in the order by elements ****\n");
				retrievedPair.set(1, 4);
				mutStruct.setMutationLoc(retrievedPair);
				GenerateDataForOriginalQuery.generateDataForQueryMutantsForWindow(cvc, mutStruct);
				System.out.println("***** End of DS4 created");

				// //order by asc vs desc
				System.out.println("**** this dataset is used to kill order by mutation of ASC VS DESC ****\n");
				System.out.println(
						"**** DS5 will only be created when there is exactly 1 elements in the order by element ****\n");
				retrievedPair.set(1, 5);
				mutStruct.setMutationLoc(retrievedPair);
				GenerateDataForOriginalQuery.generateDataForQueryMutantsForWindow(cvc, mutStruct);
				System.out.println("***** End of DS5 created");

				// replacement of order by attrbute
				System.out.println("**** this dataset is used to kill order by mutation with wrong attribute ****\n");
				System.out.println(
						"**** DS6 will only be created when there is exactly 1 elements in the order by element ****\n");
				retrievedPair.set(1, 6);
				mutStruct.setMutationLoc(retrievedPair);
				GenerateDataForOriginalQuery.generateDataForQueryMutantsForWindow(cvc, mutStruct);
				System.out.println("***** End of DS6 created");

				// extra attribute in orderby clause
				System.out.println(
						"**** this dataset is used to kill order by mutation which has extra attribute ****\n");
				System.out.println(
						"**** DS7 will only be created when there is exactly 1 element in the order by element ****\n");
				retrievedPair.set(1, 7);
				mutStruct.setMutationLoc(retrievedPair);
				GenerateDataForOriginalQuery.generateDataForQueryMutantsForWindow(cvc, mutStruct);
				System.out.println("***** End of DS7 created");

				// additional partition by
				System.out.println("**** this dataset is used to kill additional partition by element ****\n");
				System.out.println(
						"**** DS8 will only be created when there is exactly 1 elements in the partition by column ****\n");
				retrievedPair.set(1, 8);
				mutStruct.setMutationLoc(retrievedPair);
				GenerateDataForOriginalQuery.generateDataForQueryMutantsForWindow(cvc, mutStruct);
				System.out.println("***** End of DS8 created");

				// //missing partition by attribute
				System.out.println("**** this dataset is used to kill missing attribute in partititoin by ****\n");
				System.out.println(
						"**** DS9 will only be created when there is exactly 2 elements in the order by element ****\n");
				retrievedPair.set(1, 9);
				mutStruct.setMutationLoc(retrievedPair);
				GenerateDataForOriginalQuery.generateDataForQueryMutantsForWindow(cvc, mutStruct);
				System.out.println("***** End of DS9 created");
				break;
			case 26:
				for (int j = 0; j < qbd.getConjunctsQs().size(); j++) {
					ConjunctQueryStructure cqs = qbd.getIConjunctQueryStructure(j);
					Vector<Node> joinConds = cqs.getJoinCondsForEquivalenceClasses();
					if (joinConds.size() == 0)
						joinConds = cqs.getJoinCondsAllOther();

					for (int k = 0; k < joinConds.size() && k < qbd.JoinClauseTypes.size(); k++) {
						String s = qbd.JoinClauseTypes.get(k);
						System.out.println("#############################");
						System.out.print("Outer joins mutation");
						System.out.println("#############################");
						// qbd.JoinClauseTypes.set(k, JoinClauseInfo.fullOuterJoin);
						Node left = new Node(cqs.joinCondsAllOther.get(k).getLeft());
						left.setType(Node.getColRefType());
						Node right = new Node(cqs.joinCondsAllOther.get(k).getRight());
						right.setType(Node.getColRefType());
						int l;
						if ((s.equals(JoinClauseInfo.rightOuterJoin) || s.equals(JoinClauseInfo.fullOuterJoin))
								&& qbd.getBaseRelations().contains(left.getTableNameNo())) {
							System.out.println("#############################");
							System.out.print("Setting Right Node to NULL\n");
							System.out.println("#############################");
							Node parent1 = new Node();
							parent1.setOperator("=");
							parent1.setType(Node.getIsNullNodeType());
							parent1.setLeft(left);
							// cqs.getIsNullConds().add(parent1);
							mutStruct.setmutationNode(parent1);
							cvc.setCurrentMutant(mutStruct);
							GenerateDataForOriginalQuery.generateDataForQueryMutants(cvc, mutStruct);
							// l=cqs.getIsNullConds().size();
							// cqs.getIsNullConds().remove(l-1);

						}
						if ((s.equals(JoinClauseInfo.leftOuterJoin) || s.equals(JoinClauseInfo.fullOuterJoin))
								&& qbd.getBaseRelations().contains(right.getTableNameNo())) {
							System.out.println("#############################");
							System.out.print("Setting Left Node to NULL\n");
							System.out.println("#############################");
							Node parent2 = new Node();
							parent2.setOperator("=");
							parent2.setType(Node.getIsNullNodeType());
							parent2.setLeft(right);
							// cqs.getIsNullConds().add(parent2);
							mutStruct.setmutationNode(parent2);
							cvc.setCurrentMutant(mutStruct);
							GenerateDataForOriginalQuery.generateDataForQueryMutants(cvc, mutStruct);
							// l=cqs.getIsNullConds().size();
							// cqs.getIsNullConds().remove(l-1);
						}

						// qbd.JoinClauseTypes.set(k, s);

					}

				}
				break;
			case 27: // ORDER BY mutants
				if (cvc.getqStructure().getOrderByNodes().size() > 0) {
					boolean shouldGenerate = false;
					boolean hasLimit = cvc.getqStructure().getLimit() > 0;
					if (mutStruct.getMutationNode() instanceof String
							&& "ORDER_BY_TWO_TUPLES_NO_NULL_CONSTRAINT"
									.equalsIgnoreCase(mutStruct.getMutationNode().toString())) {
						shouldGenerate = true;
					} else if (mutStruct.getMutationNode() instanceof String
							&& "ORDER_BY_MULTI_COLUMN_LEX"
									.equalsIgnoreCase(mutStruct.getMutationNode().toString())) {
						shouldGenerate = cvc.getqStructure().getOrderByNodes().size() > 1;
					} else if (mutStruct.getMutationNode() instanceof String
							&& "ORDER_BY_WRONG_ATTRIBUTE_TRAP"
									.equalsIgnoreCase(mutStruct.getMutationNode().toString())) {
						shouldGenerate = true;
					} else if (mutStruct.getMutationNode() instanceof String
							&& "ORDER_BY_TWO_TUPLES_NULL_AND_NON_NULL"
									.equalsIgnoreCase(mutStruct.getMutationNode().toString())) {
						shouldGenerate = true;
					} else if (hasLimit && cvc.getqStructure().getLimit() == 1) {
						Node orderByNode = cvc.getqStructure().getOrderByNodes().get(0);
						Column col = orderByNode.getColumn();
						shouldGenerate = col.isNullable();
					}
					if (shouldGenerate) {
						// Set the current mutant so generateDataForQueryMutants can access it
						cvc.setCurrentMutant(mutStruct);
						GenerateDataForOriginalQuery.generateDataForQueryMutants(cvc, mutStruct);
					}
				}
				break;
			case 28:
				// DATE ARITHMETIC OPERATOR MUTATIONS
				n = (Node) mutStruct.getMutationLoc();

				System.out.println("#############################");
				System.out.print("DATE Arithmetic Mutant from level " + qbd.getLevel() + " " + n
						+ "changed to" + (Node) mutStruct.getMutationNode() + "\n");
				System.out.println("#############################");

				cvc.setCurrentMutant(mutStruct);
				GenerateDataForOriginalQuery.generateDataForQueryMutants(cvc, mutStruct);
				mutStruct.setIsExpired(true);
				break;

			default:
				break;
		}

		// throw new UnsupportedOperationException("Unimplemented method
		// 'generateDatasetForSpecificMutation'");
	}

	/**
	 * @author parismita
	 *         Main function for generating dataset for specific mutation
	 */
	public static String PrintDiffForSpecificMutation(MutationStructure mutStruct) throws Exception {
		if (mutStruct == null)
			return "{\"mutation type\":\"no change\", \"from\": \"\", \"changed to\": \"\"}";
		switch (mutStruct.getMutationTypeNumber()) {
			case 1:
				return "{\"mutation type\":\"no change\", \"from\": \"\", \"changed to\": \"\"}";
			case 2:
				// generate agg
				Node aggFun = (Node) mutStruct.getMutationLoc();
				return "{ \"mutation type\" : \"" + mutStruct.getMutationType() + "\", \"from\" : \""
						+ mutStruct.getMutationLoc().toString()
						+ "\", \"changed to\": \"" + aggFun.toString() + "\"}";

			case 3:
				// generate count
				return "{ \"mutation type\" : \"" + mutStruct.getMutationType()
						+ "\", \"from\": \"\", \"changed to\": \"\"}";
			case 4:
				// generate having
				Node mutNode = (Node) mutStruct.getMutationNode();
				Node mutLoc = (Node) mutStruct.getMutationLoc();
				return "{ \"mutation type\" : \"" + mutStruct.getMutationType() + "\", from : " + mutLoc
						+ "\", \"changed to\": " + mutNode + "\"}";
			case 5:
				// generate distinct
				return "{ \"mutation type\" : \"" + mutStruct.getMutationType()
						+ "\",\"from\": \"\", \"changed to\": \"\"}";
			case 6:
				// generate data to kill equivalence class mutations
				ConjunctQueryStructure conjunct = (ConjunctQueryStructure) mutStruct.getMutationLoc();
				return "{ \"mutation type\" : \"" + mutStruct.getMutationType() + "\", \"additional info\": "
						+ conjunct.getJoinCondsForEquivalenceClasses().get(0)
						+ "\", \"from\": \"\", \"changed to\": \"\"}";
			case 7:
				Column c = ((Column) mutStruct.getMutationNode());
				return "{ \"mutation type\" : \"" + mutStruct.getMutationType() + "\", \"from\":\"\""
						+ ", \"additional info\": \"Extra Attribute Mutation in Group By Clause at " + c.getTableName()
						+ " " + c.getColumnName() + "\", \"changed to\":\"" + c.getTableName() + " " + c.getColumnName()
						+ "\"}";
			case 8:
				Column n = ((Column) mutStruct.getMutationNode());
				return "{ \"mutation type\" : \"" + mutStruct.getMutationType() + "\", \"from\":\"\""
						+ ", \"changed to\":\"" + n
						+ "\", \"additional info\": \"Missing Attribute Mutation in Group By Clause at " + n + "\"}";
			
			case 10:
				Node pred = (Node) mutStruct.getMutationLoc();
				Node predMut = (Node) mutStruct.getMutationNode();
				return "{ \"mutation type\" : \"" + mutStruct.getMutationType() + "\", \"from\" : \"" + pred
						+ "\", \"changed to\": \"" + predMut + "\"}";

			case 12:
				pred = (Node) mutStruct.getMutationLoc();
				predMut = (Node) mutStruct.getMutationNode();
				return "{ \"mutation type\" : \"" + mutStruct.getMutationType() + "\", \"from\" : \"" + pred
						+ "\", \"changed to\": \"" + predMut + "\"}";

			case 13:
				pred = (Node) mutStruct.getMutationLoc();
				predMut = (Node) mutStruct.getMutationNode();
				return "{ \"mutation type\" : \"" + mutStruct.getMutationType() + "\", \"from\" : \"" + pred
						+ "\", \"changed to\": \"" + predMut + "\"}";

			case 14:
				predMut = (Node) mutStruct.getMutationNode();
				return "{ \"mutation type\" : \"" + mutStruct.getMutationType()
						+ "\", \"from\": \"\", \"changed to\": \"" + (Node) mutStruct.getMutationNode() + "\"}";

			case 15:
				pred = (Node) mutStruct.getMutationLoc();
				predMut = (Node) mutStruct.getMutationNode();
				return "{ \"mutation type\" : \"" + mutStruct.getMutationType() + "\", \"subquery\" : \"" + pred
						+ "\", \"from\" : \"" + pred.getType() + "\", \"changed to\": \"" + predMut.getType() + "\"}";
			case 20:
				return "{ \"mutation type\" : \"" + mutStruct.getMutationType()
						+ "\", \"from\" : \"" + ((Node) mutStruct.getMutationNode()).getLeft()
						+ "\", \"changed to\" : \"" + ((Node) mutStruct.getMutationNode()).getRight() + "\"}";

			case 27:
				// DATE ARITHMETIC OPERATOR MUTATIONS
				pred = (Node) mutStruct.getMutationLoc();
				predMut = (Node) mutStruct.getMutationNode();
				return "{ \"mutation type\" : \"" + mutStruct.getMutationType() + "\", \"from\" : \"" + pred
						+ "\", \"changed to\": \"" + predMut + "\"}";

			default:
				if (mutStruct.getMutationType() != null)
					return "{ \"mutation type\" : \"" + mutStruct.getMutationType()
							+ "\", \"from\": \"\", \"changed to\": \"\"}";
				else
					return "{\"mutation type\":\"no change\", \"from\": \"\", \"changed to\": \"\"}";
		}
	}

	public static Vector<Node> HandleSelectionMutations(Vector<Node> selConds, MutationStructure mutation) {
		// TODO Auto-generated method stub
		if (!mutation.getIsExpired() && mutation.getMutationTypeNumber() == 12) {
			for (Node condition : selConds) {
				Node n = (Node) mutation.getMutationLoc();
				if (n.equals(condition)) {
					condition.setOperator(((Node) mutation.getMutationNode()).getOperator());
					n.setOperator(((Node) mutation.getMutationNode()).getOperator());
				}
			}
		}
		if (!mutation.getIsExpired() && mutation.getMutationTypeNumber() == 27) {
			Node n = (Node) mutation.getMutationLoc();
			for (int i = 0; i < selConds.size(); i++) {
				if (n.equals(selConds.get(i))) {
					selConds.set(i, (Node) mutation.getMutationNode());
				}
			}
		}
		return selConds;
		// throw new UnsupportedOperationException("Unimplemented method
		// 'HandleSelectionMutations'");
	}

	public static Vector<Node> HandleStringSelectionMutations(Vector<Node> strConds, MutationStructure mutation) {
		// TODO Auto-generated method stub
		if (!mutation.getIsExpired() && mutation.getMutationTypeNumber() == 13) {
			for (Node condition : strConds) {
				Node n = (Node) mutation.getMutationLoc();
				if (n.equals(condition)) {
					n.setOperator(((Node) mutation.getMutationNode()).getOperator());
					condition.setOperator(((Node) mutation.getMutationNode()).getOperator());
					if (n.getOperator().contains("~")) {
						n.setRight(((Node) mutation.getMutationNode()).getRight());
						condition.setRight(((Node) mutation.getMutationNode()).getRight());
					} // n and condition are not same node - they are same valued clones
				}
			}
		}
		return strConds;
	}

	public static void HandleWhereConnectiveMutations(Node condition, MutationStructure mutation) {
		if (!mutation.getIsExpired() && mutation.getMutationTypeNumber() == 15) {
			Node n = (Node) mutation.getMutationLoc();
			if (n.equals(condition)) {
				if (n.getType().equals(Node.getBroNodeSubQType())) {
					n.setOperator(((Node) mutation.getMutationNode()).getOperator());
					condition.setOperator(((Node) mutation.getMutationNode()).getOperator());
				} else
					n.setType(((Node) mutation.getMutationNode()).getType());
			}
		}
		// return condition;
	}

	public static Vector<Node> HandleNonEquiJoinMutations(Vector<Node> selConds, MutationStructure mutation) {
		// TODO Auto-generated method stub
		if (mutation != null && !mutation.getIsExpired() && mutation.getMutationTypeNumber() == 10) {
			for (Node condition : selConds) {
				Node n = (Node) mutation.getMutationLoc();
				if (n.equals(condition)) {
					condition.setOperator(((Node) mutation.getMutationNode()).getOperator());
					n.setOperator(((Node) mutation.getMutationNode()).getOperator());
				}
			}
		}
		return selConds;
		// throw new UnsupportedOperationException("Unimplemented method
		// 'HandleNonEquiJoinMutations'");
	}

	public static ArrayList<Node> HandleExtraGroupByMutations(ArrayList<Node> selConds, MutationStructure mutation) {

		if (mutation != null && !mutation.getIsExpired() && mutation.getMutationTypeNumber() == 7) {
			// selConds.get(0);
			Node n = new Node(selConds.get(0));
			Column newC = (Column) (mutation.getMutationNode());

			n.setColumn(newC);
			n.setTable(newC.getTable());
			n.setTableAlias(newC.getAliasName());
			// n.setTableNameNo(newC.getTable().ge);
			n.setIsMutant(true);
			selConds.add(n);
		}
		return selConds;
		// throw new UnsupportedOperationException("Unimplemented method
		// 'HandleNonEquiJoinMutations'");
	}

}
