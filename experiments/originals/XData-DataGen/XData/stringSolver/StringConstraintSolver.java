package stringSolver;


import java.io.Serializable;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Vector;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.net.URI;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;

import com.google.common.collect.*;

import dk.brics.automaton.Automaton;
import dk.brics.automaton.BasicOperations;
import generateConstraints.ConstraintGenerator;
import parsing.Column;
import parsing.Table;
import util.Configuration;
import util.TableMap;
import util.Utilities;

/**
 * 
 * @author bikash
 *
 */
public class StringConstraintSolver implements Serializable
{
	private static Logger logger = Logger.getLogger(StringConstraintSolver.class.getName());
	private static final long serialVersionUID = 4110121024171756914L;
	int count;			//count of files
	Vector<Column> columns;	
	TableMap tableMap;
	public HashMap<String,String>generatedStringMap;//Used to store generated string values for string variables
	//Constructor
	public StringConstraintSolver()	{
		//stringConstraintsMap = new HashMap<String,Vector<String>>();
		count=0;
		generatedStringMap = new HashMap<String,String>();
	}
	
	
	public Vector<String> solveConstraints(String assertConstraints,Vector<Column> columns,TableMap tableMap) throws Exception{
		Vector<String> constraints=new Vector<String>();
		constraints.add(assertConstraints);
		return solveConstraints(constraints,columns,tableMap,true);
	}
	
	public String removeBraces(String str){
		while(str.startsWith("(")){
			str=str.substring(1, str.length()-2);
			str=str.trim();
		}
		return str;
	}

	//Added by Amol to handle OR conditions in string constraints.
	public Vector<String> solveOrConstraints(Vector<String> assertConstraints,Vector<Column> columns,TableMap tableMap) throws Exception {
		Vector<String> stringConstraints = new Vector<String>();
		Vector<String> Final=new Vector<String>();
		for(String str:assertConstraints){
			if(str.startsWith("ASSERT")){
				str=str.substring(7, str.length());
				str=str.substring(0, str.length()-1);
				str=str.trim();
			}
			//str=removeBraces(str);
/*			if(str.startsWith("(")){
				
			}*/
			String Ors[]=str.split(" OR ");
			for(String EachOr : Ors){
				//EachOr=removeBraces(EachOr);
				String AndConstraint[] = EachOr.trim().split(" AND ");
				for(String And: AndConstraint){
					//And=removeBraces(And);
					And=And.trim();
					stringConstraints.add(And);
				}
				Vector<String> ret1;
				ret1=solveConstraints(stringConstraints, columns,tableMap,true);
				if(ret1!=null){
					Final.addAll(ret1);
					break;
				}
			}
		}
		return Final;
		
	}
	
	//Added by Shree to handle OR conditions in String conditions in SMT LIB constraint format
	public Vector<String> solveOrConstraintsForSMT(Vector<String> assertConstraints,Vector<Column> columns,TableMap tableMap) throws Exception {
		Vector<String> stringConstraints = new Vector<String>();
		Vector<String> Final=new Vector<String>();
		String finalStr ="";
		for(String str:assertConstraints){
			if(str.startsWith("ASSERT")){
				str=str.substring(7, str.length());
				str=str.substring(0, str.length()-1);
				str=str.trim();
			}
			String Ors[]=str.split(" OR ");
			for(String EachOr : Ors){
				//EachOr=removeBraces(EachOr);
				stringConstraints.clear();
				String AndConstraint[] = EachOr.trim().split(" AND ");
				for(String And: AndConstraint){
					//And=removeBraces(And);
					And=And.trim();
					stringConstraints.add(And);
				}
				Vector<String> ret1;
				ret1= solveConstraints(stringConstraints, columns,tableMap,true);
				
				if(ret1!=null){
					//NEW CODE: POOJA
					for(String conStr: ret1) {
						String temp = conStr;
						if(conStr.contains("assert")) {
							temp = conStr.split("assert")[1].trim();
							temp = temp.substring(0,temp.lastIndexOf(")")).trim();
						}
						finalStr += temp+" ";
					}
					
					//Final.addAll(ret1);
					//break;
				}
			}
		}
		finalStr = "(assert (or "+finalStr+" ))";
		Final.add(finalStr);
		//System.out.println(finalStr);
		return Final;
		
	}
	
	/**
	 * Takes a Vector of String constraints and instantiates the corresponding string variables to CVC compatible form
	 * @param dataConstraints String constraints for generation of datasets
	 * @return CVC constraints corresponding to the given string constraints
	 */
	public Vector<String> solveConstraints(Vector<String> assertConstraints,Vector<Column> columns,TableMap tableMap, boolean withAssert) throws Exception {
		Vector<StringConstraint> resultingConstraints = new Vector<StringConstraint>();
		Vector<StringConstraint> stringConstraints = new Vector<StringConstraint>();
		this.columns=new Vector<>();
		this.columns = columns;
		this.tableMap = tableMap;
		//Vector<String> assertOrNot=new Vector<String>();
		//System.out.println("INPUT Constraints:\n "+assertConstraints);
		int l = assertConstraints.size();
		if(l==0)
			return(new Vector<String>());
		java.util.Map<String, java.util.List<StringConstraint>> columnToConstraints = new java.util.HashMap<>();
		java.util.Map<String, java.util.List<String>> columnToReadableConstraints = new java.util.HashMap<>();
		java.util.Map<String, Boolean> columnHasComplexFunc = new java.util.HashMap<>();

		for(String str:assertConstraints){
			if(str == "")
				continue;
			String Ors[]=str.split(" OR ");
			for(String EachOr : Ors){
				String AndConstraint[] = EachOr.trim().split(" AND ");

				for(String And: AndConstraint){
					String originalAnd = And;
					//FIXME: Temporary fix
					StringConstraint s;
					if(And.contains("assert")) {
						And = And.split("assert")[1].trim();
						And = And.substring(0,And.lastIndexOf(")")).trim();
						s = new StringConstraint(And.substring(And.indexOf("(")+1, And.lastIndexOf(")"))); //removing brackets
						stringConstraints.add(s);
					}
					else {
						s = new StringConstraint(And.substring(And.indexOf("(")+1, And.lastIndexOf(")"))); //removing brackets
						stringConstraints.add(s);
					}
					
					boolean isComplexFunc = s.isSubstr || originalAnd.toLowerCase().contains("strpos") || originalAnd.toLowerCase().contains("strcat") || originalAnd.toLowerCase().contains("substr") || originalAnd.contains("LEN:") || originalAnd.contains("REGEX:");

					String colName = s.var1;
					if (colName == null || colName.equals("1")) {
						java.util.regex.Matcher m = java.util.regex.Pattern.compile("([a-zA-Z0-9]+_[a-zA-Z0-9_]+__?[a-zA-Z0-9_]+\\d+|[a-zA-Z0-9_]+\\[\\d+\\]\\.\\d+)").matcher(originalAnd);
						if (m.find()) colName = m.group(1);
					} else {
						java.util.regex.Matcher m = java.util.regex.Pattern.compile("([a-zA-Z0-9]+_[a-zA-Z0-9_]+__?[a-zA-Z0-9_]+\\d+|[a-zA-Z0-9_]+\\[\\d+\\]\\.\\d+)").matcher(colName);
						if (m.find()) colName = m.group(1);
					}
					
					// s.var1 = colName;
					String readableConstraint = originalAnd;
					if (s.isSubstr) {
						readableConstraint = "SUBSTR(column, " + s.startIndex + (s.offset==-1?"":", " + s.offset) + ") " + s.operator + " '" + s.constant + "'";
					} else if (originalAnd.contains("LEN:")) {
						readableConstraint = "LENGTH(column) " + s.operator + " " + s.constant.replace("LEN:", "");
					} else if (s.constant != null && s.constant.startsWith("REGEX:")) {
						// chaitra: regex constraint — strip the REGEX: prefix for a clean readable form
						String regexPattern = s.constant.substring("REGEX:".length());
						readableConstraint = "column " + s.operator + " '" + regexPattern + "' (POSIX regex: all special characters like ^, $, ., *, +, ?, |, [], () must be interpreted as regex metacharacters)";
					}
					
					columnToConstraints.computeIfAbsent(colName, k -> new java.util.ArrayList<>()).add(s);
					columnToReadableConstraints.computeIfAbsent(colName, k -> new java.util.ArrayList<>()).add(readableConstraint);
					columnHasComplexFunc.put(colName, columnHasComplexFunc.getOrDefault(colName, false) || isComplexFunc);
				}
			}
		}

		boolean useLLM = Configuration.useLLMForStrings != null && Configuration.useLLMForStrings.equalsIgnoreCase("true");

		for (String colName : columnToConstraints.keySet()) {
			java.util.List<StringConstraint> constraintsGroup = columnToConstraints.get(colName);
			java.util.List<String> readableGroup = columnToReadableConstraints.get(colName);
			boolean hasComplexFunc = columnHasComplexFunc.get(colName);

			if (useLLM && hasComplexFunc && colName != null) {
				String cvcDataType = "";
				try { cvcDataType = getCVCDataType(colName); } catch (Exception e) {}
				
				String combinedConstraint = String.join(" AND ", readableGroup);
				
				java.util.List<String> sampleValues = new java.util.ArrayList<>();

				// chaitra : find table name
				String temp = constraintsGroup.get(0).var1.split(" ")[0];
				String tokens[] = temp.split("_");
				String tableName = tokens[0];
				if (!Character.isLetter(tableName.charAt(0)))
					tableName = tokens[0].substring(1);
				int flag = 1;
				if(tableName.contains("JSQ")||tableName.contains("GSQ")||tableName.contains("DSQ")) tableName = tokens[flag++];
				// This for loop is required when relation name contains underscore("_") 
				// In variable 'var', table name is in lower case and column name in upper case; eg: player_match_ROLE_DESC3
				for(int i=flag; i<tokens.length; i++) {
					if(tokens[i].isEmpty()) continue;
					if(!Character.isUpperCase(tokens[i].charAt(0)))
						tableName += "_"+tokens[i];
					else
						break;
				}

				// chaitra : find column
				int columnIndex=Integer.parseInt(""+(temp.charAt(temp.length()-1)));
				Pattern pattern = Pattern.compile("\\d+$");
				Matcher matcher = pattern.matcher(temp);
				if (matcher.find()) 
					columnIndex = Integer.parseInt(matcher.group());

				// chaitra : find sample values
				if (tableName != null && tableMap != null && tableMap.getSQTables() != null) {
					Table currTable = null;
					try {
						currTable = tableMap.getTable(tableName.toUpperCase());
					} catch (Exception e) {}
					try {
						if (currTable == null)
							currTable = tableMap.getSQTableByName(tableName);
					} catch (Exception e) {}
					if (currTable != null) {
						Column col = currTable.getColumn(columnIndex);
						if (col != null && col.getColumnValues() != null) {
							for (String val : col.getColumnValues()) {
								if (val != null && !val.matches("V\\d+")) {
									sampleValues.add(val);
								}
							}
						}
					}
				}

				String llmResult = solveWithLLM(combinedConstraint, colName, sampleValues);
				this.generatedStringMap.put(cvcDataType, llmResult);

				for (StringConstraint s : constraintsGroup) {
					s.constant = llmResult;
					s.operator = "=";
					stringConstraints.add(s);
				}
			} else {
				for (StringConstraint s : constraintsGroup) {
					stringConstraints.add(s);
					if(s.isSubstr){
						int n=stringConstraints.size();
						s.constant = stringForSubstr(s,s.startIndex,s.offset);
						stringConstraints.set(n-1, s);
					}
				}
			}
		}
		//System.out.println(stringConstraints);
		
		if (!useLLM) {
			// Chaitra added here  Non-LLM path: automaton-based constraint solving 
			//TODO:correct this
			//Collections.sort(stringConstraints, new StringConstraint());
			//-----------------------simplify constraints
			//Collections.sort(constraints, new StringConstraint());
			Vector<StringConstraint> equal=new Vector<StringConstraint>();
			boolean flag=removeRedundantConds(stringConstraints,equal);
			if(flag==false){
					return null;
			}		
			//TODO:need to correct it kartik
			for(StringConstraint s:equal)	//constraints of the form of var=const can be assigned directly
				resultingConstraints.add(s);
			

			
			HashMap<String,String> equalVar=new HashMap<String,String>();
			flag=removeEqualConds(stringConstraints,equalVar);
			if(flag==false){
					return null;
			}
			
			if(stringConstraints.size()==0){
				
			}


			HashSet<StringConstraint> relatedConstraints=null;		//hashset would prevent duplicates
			while(stringConstraints.size()>0){  //group constraints on related variables together
				relatedConstraints=new HashSet<StringConstraint>();
				StringConstraint s=stringConstraints.get(0);
				relatedConstraints.add(s);
				stringConstraints.remove(0);

				getReleatedConstraints(s.var1,relatedConstraints,stringConstraints);

				if(s.var2!=null)
					getReleatedConstraints(s.var2,relatedConstraints,stringConstraints);


				stringConstraints.removeAll(relatedConstraints);
				Vector<StringConstraint> rel=new Vector<StringConstraint>();
				rel.addAll(relatedConstraints);
				Vector<StringConstraint> result= solveRelatedConstraints(rel);	
				if(result== null || result.size()==0 ){
					Vector<String> v=new Vector<String>();
					if(Configuration.getProperty("smtsolver").equalsIgnoreCase("cvc3"))
					v.add("ASSERT  (1=2);\n");
					return v;
				}
				else{
					resultingConstraints.addAll(result);
				}
					
				
			}
			
			// Chaitra added here : equalVar propagation 
			Vector<StringConstraint> tempConstraints=new Vector<StringConstraint>();
			Iterator<String> iterEqualVal=equalVar.keySet().iterator();
			while(iterEqualVal.hasNext()){
				flag=false;
				String str=iterEqualVal.next();			
				for(StringConstraint c:resultingConstraints){
					if(c.var1.equals(equalVar.get(str))){
						StringConstraint s =new StringConstraint();
						s.var1=str;
						s.operator="=";
						s.constant=c.constant;
						if(c.isSubstr){
							s.isSubstr=c.isSubstr;
							s.startIndex=c.startIndex;
							s.offset=c.offset;
						}
						tempConstraints.add(s);
						flag=true;
					}
				}
				if(flag==false){
					StringConstraint s =new StringConstraint();
					s.var1=str;
					s.operator="=";
					s.constant="A";
					tempConstraints.add(s);
					s.var1=equalVar.get(str);
					s.operator="=";
					s.constant="A";
					tempConstraints.add(s);
				}
				resultingConstraints.addAll(tempConstraints);
			}
		} else {
			// Chaitra added here : constraints are already simplified to '= llmResult' equalities
			for (StringConstraint s : stringConstraints) {
				resultingConstraints.add(s);
			}
		}
		
		if(columns==null){
			Vector<String> v=new Vector<String>();
			v.add(resultingConstraints.toString());
			return v;
		}
		
		Vector<String> vStr=new Vector<String>();
		//int i=0;
		for(StringConstraint c:resultingConstraints){
			if (!useLLM) {
				// Chaitra added here : resolve automaton-produced constraints to a final constant
				String temp = solveSingleConstraintToGetConst(c);
				if(temp!="")
					addValueToColumn(c.var1,temp,columns,tableMap);
			}

			// Chaitra added here : add the resolved constant value to the column
			String str=addValueToColumn(c.var1,c.constant,columns,tableMap);
			//c.constant=i+"";
			//vStr.add("ASSERT  ("+c.var1+"="+i+");\n"); // Old code, constraint string is in cvc3 format
			String finalstr = "(assert ("+ c.operator + " " + c.var1 +" "+ str + "  ))\n"; // added by POOJA

			// sunanda
			if(c.operator.equalsIgnoreCase("~") || c.operator.equalsIgnoreCase("i~")){
				c.operator = "=";
			}else if(c.operator.equalsIgnoreCase("!~") || c.operator.equalsIgnoreCase("!i~")){
				c.operator = "( not ( = ";
			}
			if(c.operator.equalsIgnoreCase("( not ( = "))
				finalstr = "(assert " + c.operator + c.var1 +" "+ str + "  )))\n";
			else{
				String columnName = str.split("__")[0].substring(1);
				columnName = columnName.replaceAll("[a-z]", "");
				Column colF = null;
				for(Column col : columns){
					if(col.getColumnName().equalsIgnoreCase(columnName)){
						colF = col;
						break;
					}		
				}
				ConstraintGenerator cg = new ConstraintGenerator();
				finalstr = cg.getUserDefinedComparisionOperator(c.operator, colF, c.var1, str);
				finalstr = "(assert " + finalstr + ")\n";
			}
				
			vStr.add(finalstr);
			//System.out.println("FINAL Constraints:  "+finalstr);
			//vStr.add("ASSERT  ("+c.var1+"="+str+");\n");
			//vStr.add(c.toString());
			
		}
		return vStr;
	}
		
	/**
	 * Recursive function to find which constraints depend on the variable var
	 * @param var Variable on which the constraints must depend
	 * @param relatedConstraints HashSet to which related constraints are written
	 * @param dataConstraints Vector from which the constraints are considered
	 * @return 
	 */
	public void  getReleatedConstraints(String var,HashSet<StringConstraint> relatedConstraints,Vector<StringConstraint> dataConstraints)	{
		if(dataConstraints.size()==0) return ;
		int l=dataConstraints.size();
		for(int i=0;i<l;i++){
			if(dataConstraints.size()<=i) return;
			if(dataConstraints.get(i).var1.equalsIgnoreCase(var)){
				relatedConstraints.add(dataConstraints.get(i));
				Vector<StringConstraint> givenConstraints=(Vector<StringConstraint>)dataConstraints.clone();
				givenConstraints.remove(i);
				if(dataConstraints.get(i).var2!=null)
					getReleatedConstraints(dataConstraints.get(i).var2,relatedConstraints,givenConstraints);
			}
			if(dataConstraints.get(i).var2!=null && dataConstraints.get(i).var2.equalsIgnoreCase(var)){
				relatedConstraints.add(dataConstraints.get(i));
				Vector<StringConstraint> givenConstraints=(Vector<StringConstraint>)dataConstraints.clone();
				givenConstraints.remove(i);
				getReleatedConstraints(dataConstraints.get(i).var1,relatedConstraints,givenConstraints);
			}
		}	
		return;
	}
	
	/**
	 * Removes the inequalities by replacing it with < or > and then solves the grouped constraints
	 * @param toBeAdded constraints that remain to be added
	 * @param added Constraints that have been added and need to be passed to string solver
	 * @param noOfVar number of variables in the constraints
	 * @return
	 */
	public HashMap<Integer,String> solveGroupedConstraintsWithInequalities(Vector<StringConstraint> toBeAdded, Vector<StringConstraint> added,int noOfVar){
		if(toBeAdded != null && toBeAdded.size()!=0){
			Vector<StringConstraint> temp=(Vector<StringConstraint>)toBeAdded.clone();
			for(StringConstraint c:temp){
				toBeAdded.remove(c);
				if(c.operator.equals("<>") && c.var2 != null){
					StringConstraint constraint= new StringConstraint(c.var1+" < "+c.var2);
					constraint.isSubstr=c.isSubstr;
					if(constraint.isSubstr){
						constraint.startIndex=c.startIndex;
						constraint.offset=c.offset;
					}
					added.add(constraint);
					HashMap<Integer,String> values= solveGroupedConstraintsWithInequalities(toBeAdded,added,noOfVar);
					if(values!=null) /////////////// if var1 <var2 makes the contrints unsolvable try with var1 >var2
						return values;
					added.remove(constraint);
					constraint= new StringConstraint(c.var1+" > "+c.var2);
					constraint.isSubstr=c.isSubstr;
					if(constraint.isSubstr){
						constraint.startIndex=c.startIndex;
						constraint.offset=c.offset;
					}
					added.add(constraint);
					return solveGroupedConstraintsWithInequalities(toBeAdded,added,noOfVar); // if even this is unsolvable then the inequality is unsolvable
				}
				else{
					added.add(c);
				}
			}
		}
		
		return solveMultipleUsingGraph(added,noOfVar);
	}
	
	/**
	 * Finds the solution to the related strings
	 * @param constraints The related String constraints
	 * @return Value of strings satisfying the constrained
	 */
	private Vector<StringConstraint> solveRelatedConstraints(Vector<StringConstraint> constraints)	{
		Vector<StringConstraint> result=new Vector<StringConstraint>();
		
		
		boolean flag=true;
		int length=constraints.size();
	
		
		//----------------------Solve for Single variable---------------------
		for(int i=0;i<length;i++){		
			StringConstraint s=constraints.get(i);
	
			if(s.var2!=null || s.operator.startsWith("L")){ 
				flag=false;
				break;
			}
		}
	
		if(flag){
			
			String str;
			if(length==1)		//only a single constraint
				str=solveSingleConstraint(constraints.get(0));
			
			else{				//multiple constraints				
				str=solveUsingAutomaton(constraints);
				
			}
			// System.out.print( constraints.get(0).operator) ;
			if(str==null) return null;
			else {
				StringConstraint sc=new StringConstraint(constraints.get(0).var1+constraints.get(0).operator+"'"+ str+"'");
				sc.isSubstr=constraints.get(0).isSubstr;
				if(sc.isSubstr){
					sc.startIndex=constraints.get(0).startIndex;
					sc.offset=constraints.get(0).offset;
				}
				result.add(sc);}	
			return result;
		}
		BiMap<String,Integer> varMap;
		varMap =HashBiMap.create();
		int j=0;
		for(int i=0;i<length;i++){		
			StringConstraint s=constraints.get(i);
			
			Integer lhs=varMap.get(s.var1);
			if(lhs==null){
				varMap.put(s.var1,j);
				lhs=j;
				j++;			
			}
			s.var1=lhs+"";
			
			if(s.var2==null) continue;
			Integer rhs=varMap.get(s.var2);
			if(rhs==null){
				varMap.put(s.var2,j);
				rhs=j;
				j++;			
			}
			s.var2=rhs+"";		
		}
		
		
		//HashMap<Integer,String> val=solveMultipleUsingGraph(constraints,varMap.size());
		HashMap<Integer,String> val= solveGroupedConstraintsWithInequalities(constraints, new Vector<StringConstraint>(),varMap.size());
		if(val==null)  return null;
		BiMap<Integer,String> inverseMap=varMap.inverse();
		for(Integer temp:val.keySet()){
			StringConstraint s=new StringConstraint();
			s.operator = "=";
			s.var1=inverseMap.get(temp);
			s.constant=val.get(temp);
			result.add(s);
		}
		
		return result;
	}
	String getCVCDataType(String var){
		String temp = var.split(" ")[0];
		String tokens[] = temp.split("_");
		String tableName = tokens[0];
		if (!Character.isLetter(tableName.charAt(0)))
			tableName = tokens[0].substring(1);
		int flag = 1;
		if(tableName.contains("JSQ")||tableName.contains("GSQ")||tableName.contains("DSQ")) tableName = tokens[flag++];
		// This for loop is required when relation name contains underscore("_") 
		// In variable 'var', table name is in lower case and column name in upper case; eg: player_match_ROLE_DESC3
		for(int i=flag; i<tokens.length; i++) {
			if(tokens[i].isEmpty()) continue;
			if(!Character.isUpperCase(tokens[i].charAt(0)))
				tableName += "_"+tokens[i];
			else
				break;
		} 
		
		int columnIndex=Integer.parseInt(""+(temp.charAt(temp.length()-1)));
		Pattern pattern = Pattern.compile("\\d+$");

        // Create a matcher for the example string
		// chaitra strings - removed this matched revert here
        // Matcher matcher = pattern.matcher(temp);
		// if (matcher.find()) {
        //     // If a match is found, print it
		// 	columnIndex = Integer.parseInt(matcher.group());

        // }
		//Table t=tableMap.getTable(tableName);
		Table t=this.tableMap.getTable(tableName.toUpperCase()); //added by rambabu
		String cvcDataType=t.getColumn(columnIndex).getCvcDatatype();
		return cvcDataType;
	}
	public String stringForSubstr(StringConstraint constraint,int start,int offset){
		//TODO:ADD condition to handle like and all mutation
		String str=stringForSingleSubStr(constraint, start, offset);
		String cvcDataType="";
		try {
			cvcDataType = getCVCDataType(constraint.var1);
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		Vector<String>colValues= new Vector<String>(); 
		for(int i=0;i<this.columns.size();i++){
			if(this.columns.get(i).getColumnName().equalsIgnoreCase(cvcDataType)){
				colValues= this.columns.get(i).getColumnValues();
				break;
			}
		}	
		StringBuilder newStr=new StringBuilder(str);
		char c;
		// if(constraint.operator.equalsIgnoreCase("=")|| constraint.operator.equalsIgnoreCase(">=") || constraint.operator.equalsIgnoreCase("<=") ){
			
		// }
		if((constraint.operator.equalsIgnoreCase(">") && !constraint.operator.equalsIgnoreCase(">=")) || constraint.operator.equalsIgnoreCase("<>") || constraint.operator.equals("!=") || constraint.operator.equals("/=")||constraint.operator.equalsIgnoreCase("!i~") || constraint.operator.equalsIgnoreCase("!~")){
			List<String> filtered = colValues.stream()
                                 .filter(s -> !s.startsWith("V"))
                                 .collect(Collectors.toList());

			String max = filtered.isEmpty() ? null : Collections.max(filtered);

			//If our generated string is lesser than one of existing string
			if(max!=null && str.compareTo(max)<=0){
				c=max.charAt(0);
				c++;
				newStr.setCharAt(0,c);
			}
			this.generatedStringMap.put(cvcDataType, newStr.toString());
			return newStr.toString();
		}else if(constraint.operator.contains("<") && !constraint.operator.equalsIgnoreCase("<=")){
			List<String> filtered = colValues.stream()
                                 .filter(s -> !s.startsWith("V"))
                                 .collect(Collectors.toList());

			String min = filtered.isEmpty() ? null : Collections.min(filtered);
			//If generated string is larger than one of existing string
			if(min!=null && str.compareTo(min)>=0){
				c=min.charAt(0);
				c--;
				newStr.setCharAt(0,c);
			}
			this.generatedStringMap.put(cvcDataType, newStr.toString());
			return newStr.toString();
		}else{
			this.generatedStringMap.put(cvcDataType, str); 
			return str;
		}
	}

	public String stringForSingleSubStr(StringConstraint str,int start,int offset){
		String value="";
		String cvcDataType="";
		String t="["+start+","+offset+"]"+str.constant;
		try {
			cvcDataType = getCVCDataType(str.var1);
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		String maxString="";
		String substring=str.constant;
		String extra="";
		if(substring.contains("%") || substring.contains("_")){
			extra+=substring.charAt(0);
			substring=substring.substring(1);
			if(extra.equalsIgnoreCase("_")){
				extra="a";
			}else{
				extra="aa";
			}
		}
		if(this.generatedStringMap.containsKey(cvcDataType)){
			maxString=this.generatedStringMap.get(cvcDataType);
		}
		else{
			Vector<String>colValues= new Vector<String>(); 
			for(int i=0;i<this.columns.size();i++){
				if(this.columns.get(i).getColumnName().equalsIgnoreCase(cvcDataType)){
					colValues= this.columns.get(i).getColumnValues();
					break;
				}
			}			
			for(String x:colValues){
				if(x.length()>maxString.length()){
					maxString=x;
				}
				if(!x.equalsIgnoreCase(t) && x.indexOf(substring)==start-1){
					return extra+x;
				}
			}
		}
		
		
		int n=Math.max(maxString.length(),start+offset+1);
		if(substring.length()==n){
			return extra+substring;
		}
		int i=0;
		while(i<n){
			if(i==start-1){
				value+=substring;
				i+=substring.length();
			}else if(i<maxString.length()){
				value+=maxString.charAt(i);
				i++;
			}
			else{
				value+='a';
				i++;
			}
		}
		
		return extra+value;
	}
	public String modifyGeneratedString(String str,String operator,int start){
		StringBuilder newStr=new StringBuilder(str);
		char c=str.charAt(start-1);
		
		if((operator.equalsIgnoreCase(">") && !operator.equalsIgnoreCase(">="))|| operator.equalsIgnoreCase("<>") || operator.equals("!=") || operator.equals("/=")||operator.equalsIgnoreCase("!i~") || operator.equalsIgnoreCase("!~")){
			c+=1;
			newStr.setCharAt(start-1, c);
			return newStr.toString();
		}else if(operator.equalsIgnoreCase("<") && !operator.equalsIgnoreCase("<=")){
			c-=1;
			newStr.setCharAt(start-1, c);
			return newStr.toString();
		}else {
			return str;
		}

		
	}
	/**
	 * If there is only a single constraint on a single variable of the for <var> op <expr> this function can solve by substituting
	 * @param str The single string constraint
	 * @return The value of the string
	 */
	public String solveSingleConstraint(StringConstraint str){

		if(str.operator.equalsIgnoreCase(">=") || str.operator.equalsIgnoreCase("<=") 
		|| str.operator.equalsIgnoreCase("!=") || str.operator.equalsIgnoreCase(">") || str.operator.equalsIgnoreCase("<")){
			return str.constant;
		}
		
		//Modified by Biplab. Original code above
//		if(str.operator.equalsIgnoreCase(">")){
		if(str.operator.equalsIgnoreCase(">") || str.operator.equals("<>") || str.operator.equals("!=") || str.operator.equals("/=")){
			
			StringBuffer temp=new StringBuffer(str.constant);
			int l=temp.length();
			for(int i=0;i<l;i++){
				
				//Modified by Biplab. Original code above
//				if(temp.charAt(i)!='~'){
//					temp.setCharAt(0,(char)(temp.charAt(0)+1));
				if(temp.charAt(i) != '~' && temp.charAt(i) != '9' && temp.charAt(i) != 'Z' && temp.charAt(i) != 'z'){
					temp.setCharAt(i,(char)(temp.charAt(i)+1));
					
					return temp.toString();
				}
			}
			return temp.toString()+"A";
		}
		if(str.operator.equalsIgnoreCase("<")){
			StringBuffer temp=new StringBuffer(str.constant);
			int l=temp.length();
			for(int i=0;i<l;i++){
				
				//Modified by Biplab. Original code above
//				if(temp.charAt(i)!='~'){
//					temp.setCharAt(0,(char)(temp.charAt(0)-1));
				if(temp.charAt(i) != '~' && temp.charAt(i) != '0' && temp.charAt(i) != 'A' && temp.charAt(i) != 'a'){
					temp.setCharAt(i,(char)(temp.charAt(i)-1));
					
					return temp.toString();
				}
			}
			
			//Modified by Biplab. Original code above
//			return temp.deleteCharAt(temp.length()-1).toString();
			temp.setCharAt(0,(char)(temp.charAt(0)-1));
			return temp.toString();
		}
		if(str.operator.equalsIgnoreCase("i~") || str.operator.equalsIgnoreCase("~")){
			String temp=str.constant.replace('_', 'a');
			return temp.replace("%", "aa");
		}
		if(str.operator.equalsIgnoreCase("!i~") || str.operator.equalsIgnoreCase("!~")){
			StringBuffer temp=new StringBuffer(str.constant);
			if(temp.length()==0) return "a";
			int i=0;
			while(temp.charAt(i) == '_' || temp.charAt(i)== '%')	i++;
			// if(temp.charAt(i)!='~')
			// 	temp.setCharAt(i,(char)(temp.charAt(i)+1));
			// else 
			// 	temp.setCharAt(i,(char)(temp.charAt(i)-1));
			String temp1=temp.toString().replace('_', 'a');
			return temp1.replace("%", "aa");
		}	
		return "";
	}

	public String solveSingleConstraintToGetConst(StringConstraint str){
		
		// if(str.operator.equalsIgnoreCase(">=") || str.operator.equalsIgnoreCase("<=") 
		// || str.operator.equalsIgnoreCase("!=") || str.operator.equalsIgnoreCase(">") || str.operator.equalsIgnoreCase("<")){
		// 	return str.constant;
		// }
		
		//Modified by Biplab. Original code above
//		if(str.operator.equalsIgnoreCase(">")){
		if(str.isSubstr){
			String generatedString="";
			String cvcDataType="";
			try {
				cvcDataType = getCVCDataType(str.var1);
			} catch (Exception e) {
				
				e.printStackTrace();
			}
			if(this.generatedStringMap.containsKey(cvcDataType)){
				generatedString= this.generatedStringMap.get(cvcDataType);
			}
			if(generatedString.length()==0){
				return "XXXXX";
			}
			return modifyGeneratedString(generatedString, str.operator, str.startIndex); 
			
		}
		if(str.operator.equalsIgnoreCase(">") || str.operator.equals("<>") || str.operator.equals("!=") || str.operator.equals("/=")){
			
			StringBuffer temp=new StringBuffer(str.constant);
			int l=temp.length();
			for(int i=0;i<l;i++){
				
				//Modified by Biplab. Original code above
//				if(temp.charAt(i)!='~'){
//					temp.setCharAt(0,(char)(temp.charAt(0)+1));
				if(temp.charAt(i) != '~' && temp.charAt(i) != '9' && temp.charAt(i) != 'Z' && temp.charAt(i) != 'z'){
					temp.setCharAt(i,(char)(temp.charAt(i)+1));
					
					return temp.toString();
				}
			}
			return temp.toString()+"A";
		}
		if(str.operator.equalsIgnoreCase("<")){
			StringBuffer temp=new StringBuffer(str.constant);
			int l=temp.length();
			for(int i=0;i<l;i++){
				
				//Modified by Biplab. Original code above
//				if(temp.charAt(i)!='~'){
//					temp.setCharAt(0,(char)(temp.charAt(0)-1));
				if(temp.charAt(i) != '~' && temp.charAt(i) != '0' && temp.charAt(i) != 'A' && temp.charAt(i) != 'a'){
					temp.setCharAt(i,(char)(temp.charAt(i)-1));
					
					return temp.toString();
				}
			}
			
			//Modified by Biplab. Original code above
//			return temp.deleteCharAt(temp.length()-1).toString();
			temp.setCharAt(0,(char)(temp.charAt(0)-1));
			return temp.toString();
		}
		if(str.operator.equalsIgnoreCase("i~") || str.operator.equalsIgnoreCase("~")){
			String temp=str.constant.replace('_', 'a');
			return temp.replace("%", "aa");
		}
		if(str.operator.equalsIgnoreCase("!i~") || str.operator.equalsIgnoreCase("!~")){
			StringBuffer temp=new StringBuffer(str.constant);
			if(temp.length()==0) return "a";
			int i=0;
			while(temp.charAt(i) == '_' || temp.charAt(i)== '%')	i++;
			// if(temp.charAt(i)!='~')
			// 	temp.setCharAt(i,(char)(temp.charAt(i)+1));
			// else 
			// 	temp.setCharAt(i,(char)(temp.charAt(i)-1));
			String temp1=temp.toString().replace('_', 'a');
			return temp1.replace("%", "aa");
		}
		
		return "";
	}
	
	/**
	 * Given a set of constraints on a single variable returns the value satisfying those constraints
	 * @param constraints
	 * @return value satisfying those constraints
	 */
	private String solveUsingAutomaton(Vector<StringConstraint> constraints){
		Automaton a=StringConstraint.giveAutomatonForConstraints(constraints);
		return BasicOperations.getShortestExample(a,true);
	}
	
	/**
	 * If all the string constraints have only variables then this function is used to assign suitable values to the strings
	 * @param constraints
	 * @return
	 */
	private Vector<String> solveMultipleWithoutAutomata(Vector<StringConstraint> constraints){
		
		Vector<String> values=new Vector<String>();
		
		return values;
	}
	
	/**
	 * In case only one variable has constraints with constants that variable is found using automata and remaining variables are claculated from it
	 * @param constraints
	 * @return
	 */
	private Vector<String> solveMultipleUsingAutomata(Vector<StringConstraint> constraints){
		
		Vector<String> values=new Vector<String>();
		
		return values;
	}
	
	/**
	 * Enumerates some possible values of the strings and checks for satisfiability
	 * @param constraints
	 * @return
	 */
	private HashMap<Integer,String> solveMultipleUsingGraph(Vector<StringConstraint> constraints,int numberOfVariables){
		
		StringGraph g=new StringGraph(numberOfVariables);
		if(g.add(constraints)==false)
			return null;
		for(StringNode sn:g.node){
			sn.lessEqual.removeAll(sn.less); //if a var is in both and varEquql list no need to keep it in both
		}
		return g.solve();
	}
	
	/**
	 * Removes the conditions that are can be directly satisfied var = const
	 * @param constraints The String constraints from which redundant constraints are to be removed
	 * @return If it is impossible to satisfy the constraints returns false
	 */
	public static boolean removeRedundantConds(Vector<StringConstraint> input,Vector<StringConstraint> equal){
		
		String var,constant;
		StringConstraint sc=null;
		while(true){
			var="";
			constant="";
			for(StringConstraint s:input){
				if(s.operator.equalsIgnoreCase("=") && s.constant!=null){
					var=s.var1;
					constant=s.constant;
					sc=s;
				}
			}
			if(var.equalsIgnoreCase(""))
				break;
			equal.add(sc);
			input.remove(sc);
			Vector<StringConstraint> redundant=new Vector<StringConstraint>();
			for(StringConstraint s:input){
				if(s.var2!=null && s.var2.equalsIgnoreCase(var)){
					s.var2=null;
					s.constant=new String(constant);
				}
				else if(s.var1.equalsIgnoreCase(var) && s.var2!=null){
					s.var1=s.var2;
					s.var2=null;
					s.constant=constant;
					if(s.operator.equalsIgnoreCase(">"))
						s.operator="<";
					else if(s.operator.equalsIgnoreCase(">="))
						s.operator="<=";
					else if(s.operator.equalsIgnoreCase("<="))
						s.operator=">=";
					else if(s.operator.equalsIgnoreCase("<"))
						s.operator=">";
				}
				else if(s.var1.equalsIgnoreCase(var) && s.var2==null){
					if(s.operator.equalsIgnoreCase(">")){
						if(constant.compareTo(s.constant)>0)
							redundant.add(s);
						else return false;
					}
						
					else if(s.operator.equalsIgnoreCase(">=")){
						if(constant.compareTo(s.constant)>=0)
							redundant.add(s);
						else return false;
					}
						
					else if(s.operator.equalsIgnoreCase("<=")){
						if(constant.compareTo(s.constant)<=0)
							redundant.add(s);
						else return false;
					}
					else if(s.operator.equalsIgnoreCase("<")){
						if(constant.compareTo(s.constant)<0)
							redundant.add(s);
						else return false;
					}
					else if(s.operator.equalsIgnoreCase("=")){
						if(constant.compareTo(s.constant)==0)
							redundant.add(s);
						else return false;
					}
					else if(s.operator.equalsIgnoreCase("~")){
						 Pattern p = Pattern.compile(s.constant);
						 Matcher m = p.matcher(constant);
						 if(m.matches())
							 redundant.add(s);
						 else return false;
					}
						
					else if(s.operator.equalsIgnoreCase("!~")){
						 Pattern p = Pattern.compile(s.constant);
						 Matcher m = p.matcher(constant);
						 if(!m.matches())
							 redundant.add(s);
						 else return false;
					}
					else if(s.operator.equalsIgnoreCase("i~")){
						 Pattern p = Pattern.compile(s.constant.toLowerCase());
						 Matcher m = p.matcher(constant.toLowerCase());
						 if(m.matches())
							 redundant.add(s);
						 else return false;
					}
					else if(s.operator.equalsIgnoreCase("!i~")){
						 Pattern p = Pattern.compile(s.constant.toLowerCase());
						 Matcher m = p.matcher(constant.toLowerCase());
						 if(!m.matches())
							 redundant.add(s);
						 else return false;
					}
				}
			}
			input.removeAll(redundant);
			
		}
		return true;
	}
	
	/**
	 * Simplifies the constraints by replacing conditions of the form var1=var2 by replacing all instances of var1 with var2
	 * @param input All constraints
	 * @param equal Constraints of equality type
	 * @return If it is impossible to satisfy the constraints returns false
	 */
	public static boolean removeEqualConds(Vector<StringConstraint> input,HashMap<String,String> equal){
		String str1,str2;
		if(input.size()==0)	return true;
		while(true){
			str1=new String("");
			str2=new String("");
			Iterator<StringConstraint> i=input.iterator();
			StringConstraint temp=null;
			while(i.hasNext()){
				temp=i.next();
				if(temp.operator.equals("=") && temp.var2!=null){
					str1=new String(temp.var1);
					str2=new String(temp.var2);
					break;
				}		
			}
			if(str1.equalsIgnoreCase("")) break;
			equal.put(str1,str2);
			input.remove(temp);
			i=input.iterator();
			while(i.hasNext()) {
				temp=i.next();
				if(temp.var1.equals(str1))	temp.var1=str2;
				if(temp.var2!= null && temp.var2.equals(str1))	temp.var2=str2;		
			}
			Iterator<String> mapIter=equal.keySet().iterator();
			while(mapIter.hasNext()) {
				String str=mapIter.next();
				if(equal.get(str).equals(str1)){
					equal.put(str,str2);
				}
			}
			
		}
		
		return true;
	}
	
	String addValueToColumn(String var,String value,Vector<Column> columns,TableMap tableMap) throws Exception{
		int pos=-1;
		//String tableName= (var.split("\\["))[0].substring(2);
		String table= (var.split("\\["))[0];
		//String tableName=table.split("O_")[1];
		//int columnIndex=Integer.parseInt((var.split("\\."))[1]);
		
		/*
		 * TEST CODE: Pooja
		 */

		String temp = var.split(" ")[0];
		String tokens[] = temp.split("_");
		String tableName = tokens[0];
		if (!Character.isLetter(tableName.charAt(0)))
			tableName = tokens[0].substring(1);
		int flag = 1;
		if(tableName.contains("JSQ")||tableName.contains("GSQ")||tableName.contains("DSQ")) tableName = tokens[flag++];
		// This for loop is required when relation name contains underscore("_") 
		// In variable 'var', table name is in lower case and column name in upper case; eg: player_match_ROLE_DESC3
		
		// Extract column name (everything from first uppercase to the trailing number)
		String columnName = "";
		for(int i=flag; i<tokens.length; i++) {
			if(tokens[i].isEmpty()) continue;
			if(!Character.isUpperCase(tokens[i].charAt(0)))
				tableName += "_"+tokens[i];
			else {
				// Everything from here onwards until we hit a number is column name
				for(int j=i; j<tokens.length; j++) {
					if(tokens[j].isEmpty()) continue;
					// Check if this token is all digits (the index suffix)
					if(tokens[j].matches("\\d+")) {
						break;
					}
					if(!columnName.isEmpty()) columnName += "_";
					columnName += tokens[j];
				}
				break;
			}
		}
		
		// If columnName is empty, try to extract it differently (in case the variable format is different)
		if(columnName.isEmpty()) {
			Pattern colPattern = Pattern.compile("[A-Z][A-Z_]*");
			Matcher colMatcher = colPattern.matcher(temp);
			if(colMatcher.find()) {
				columnName = colMatcher.group();
			}
		}
		
		//Table t=tableMap.getTable(tableName);
		// FIX ME CHAITRA - taking last digit of column index as per new notation - JSQ0_INSTRUCTOR_DEPT_NAME22
		// if (table.contains("JSQ") || table.contains("GSQ") || table.contains("DSQ")) {
		// 	String s = String.valueOf(columnIndex);
		// 	int mid = s.length() / 2;
		// 	columnIndex = Integer.parseInt(s.substring(0,mid)); 
		// }

		Table t=tableMap.getTable(tableName.toUpperCase()); //added by rambabu
		String cvcDataType=null;
		
		// Try to find column by name first, rather than by accumulated index
		if(!columnName.isEmpty() && t!=null) {
			for(int i=0; i<t.getNoOfColumn(); i++) {
				if(t.getColumn(i).getColumnName().equalsIgnoreCase(columnName)) {
					cvcDataType = t.getColumn(i).getCvcDatatype();
					break;
				}
			}
		}
		
		// Fallback to old method if column not found by name
		if(cvcDataType == null) {
			int columnIndex=Integer.parseInt(""+(temp.charAt(temp.length()-1)));
			Pattern pattern = Pattern.compile("\\d+$");
	
	        // Create a matcher for the example string
	        Matcher matcher = pattern.matcher(temp);
			if (matcher.find()) {
	            // If a match is found, print it
				columnIndex = Integer.parseInt(matcher.group());
	
	        }
			if(t==null){
				Pattern p = Pattern.compile("select\\s+([^\\s\\)]+)");
				Matcher m = p.matcher(var);

				
				if (m.find()) {
					tableName = m.group(1); // This will contain O_JSQ0_2
				}
				t=tableMap.getTable(tableName.toUpperCase()); //added by rambabu
				if(t==null){
					tableName=tokens[0].substring(1);
					t=tableMap.getSQTableByName(tableName);
				}
			}
			
			// Only use this index if it's within valid range
			if(columnIndex < t.getNoOfColumn()) {
				cvcDataType = t.getColumn(columnIndex).getCvcDatatype();
			}
		}
		for(Column c:columns){
			if(c.getColumnName().equals(cvcDataType)){
				
				int len=c.getColumnValues().size();
				for(int i=0;i<len;i++){
					if(c.getColumnValues().get(i) == null && value != null) 
						continue;
						
					if((value==null && c.getColumnValues().get(i) == null) || c.getColumnValues().get(i).equals(value)){
						pos=i;
						break;
					} 
				}
				if(pos==-1){
					pos=len;
					// chaitra : always add value to the front.
					c.getColumnValues().add(0, value);
					
				}
				break;
			}
		}

		if(cvcDataType != null && value != null){
			value="_"+Utilities.escapeCharacters(cvcDataType)+"__"+Utilities.escapeCharacters(value);
		}
		//return pos;
		return value;
	}
		
	
	private static java.util.HashMap<String, String> llmCache = new java.util.HashMap<>();
	private static final HttpClient httpClient = HttpClient.newBuilder().version(HttpClient.Version.HTTP_2).build();

	public String solveWithLLM(String constraintStr, String column, java.util.List<String> sampleValues) {
		String apiKey = Configuration.geminiApiKey;
		if (apiKey == null || apiKey.isEmpty() || apiKey.equals("YOUR_GEMINI_API_KEY")) {
			logger.warning("Gemini API key is not configured.");
			return "AAAAA";
		}
		
		String cacheKey = constraintStr + "|||" + column;
		// if (sampleValues != null && !sampleValues.isEmpty()) {
		// 	cacheKey += "|||" + sampleValues.toString();
		// }
		if (llmCache.containsKey(cacheKey)) {
			return llmCache.get(cacheKey);
		}
		
		try {
			boolean isRegex = constraintStr.contains("POSIX regex") || constraintStr.contains("REGEX:");

			String prompt = "You are a constraint solver. Given the following string constraint on a column, " +
							"generate a single string value that satisfies ALL of the constraints exactly.\n" +
							(isRegex
								? "This constraint uses POSIX regular expression syntax. " +
								  "All special characters (^, $, ., *, +, ?, |, [], ()) MUST be treated as regex metacharacters. " +
								  "The operator ~ means 'matches regex'. Generate a string that MATCHES the regex.\n"
								: "") +
							"Return ONLY the raw string value without any quotes or explanations.\n" +
							"Column: " + column + "\n" +
							"Constraint: " + constraintStr + "\n";
			if (sampleValues != null && !sampleValues.isEmpty()) {
				prompt += "Sample values for this column (for reference): " + sampleValues.toString() + "\n";
			}
			
			String requestBody = "{\n" +
				"  \"contents\": [{\n" +
				"    \"parts\":[{\"text\": \"" + prompt.replace("\"", "\\\"").replace("\n", "\\n") + "\"}]\n" +
				"  }]\n" +
				"}";

			HttpRequest request = HttpRequest.newBuilder()
				.uri(URI.create("https://generativelanguage.googleapis.com/v1beta/models/gemma-4-26b-a4b-it:generateContent?key=" + apiKey))
				.header("Content-Type", "application/json")
				.POST(HttpRequest.BodyPublishers.ofString(requestBody))
				.build();

			HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
			
			if (response.statusCode() == 200) {
				String body = response.body();
				try {
					JsonObject jsonObject = new JsonParser().parse(body).getAsJsonObject();
					JsonArray candidates = jsonObject.getAsJsonArray("candidates");
					if (candidates != null && candidates.size() > 0) {
						JsonObject content = candidates.get(0).getAsJsonObject().getAsJsonObject("content");
						if (content != null) {
							JsonArray parts = content.getAsJsonArray("parts");
							if (parts != null) {
								for (int i = 0; i < parts.size(); i++) {
									JsonObject part = parts.get(i).getAsJsonObject();
									if (!part.has("thought") || !part.get("thought").getAsBoolean()) {
										if (part.has("text")) {
											String result = part.get("text").getAsString().replace("\\n", "").replace("\n", "").trim();
											llmCache.put(cacheKey, result);
											return result;
										}
									}
								}
							}
						}
					}
				} catch (Exception parseEx) {
					logger.warning("JSON parse error: " + parseEx.getMessage());
				}
			} else {
				logger.warning("LLM API failed: " + response.statusCode() + " " + response.body());
			}
		} catch (Exception e) {
			logger.warning("Exception during LLM API call: " + e.getMessage());
			e.printStackTrace();
		}
		return "XXXX-2025"; 
	}

	public static void main(String[] args) throws Exception
	{
		StringConstraintSolver s=new StringConstraintSolver();
		Vector<String> vec = new Vector();
//		vec.add("ASSERT (O_CRSE[2].2 > 'ggegeg');");
//		vec.add("ASSERT (O_CRSE[2].2 != 'h');");
		vec.add("ASSERT (O_TAKES[2].1 != '');");
		vec.add("ASSERT (O_TAKES[2].1 != 'MU-199');");
		vec.add("ASSERT (O_STUDENT[2].1 > 'z');");
//		vec.add("ASSERT (O_STUDENT[2].1 < '0');");
		vec.add("ASSERT (O_TAKES[2].3 != 'Fall');");
		//vec.add("ASSERT (O_CRSE[2].1 > 'igegeg');");
		//vec.add("ASSERT (O_CRSE[2].3 > O_CRSE[2].1);");	
		//vec.add("ASSERT (O_CRSE[2].3 < O_CRSE[2].2);");
		//vec.add("ASSERT (O_CRSE[2].3 > O_CRSE[2].2);");
		//vec.add("ASSERT (O_CRSE[2].4 < O_CRSE[2].3);");
		//vec.add("ASSERT (O_CRSE[2].1 < 'jk');");
		//vec.add("ASSERT (O_CRSE[2].5 ~ '%Abc%ddhsh%');");
		//vec.add("ASSERT (O_CRSE[2].5 ~ '%qwAb%pqw');");
//		vec.add("ASSERT (A ~= B);");
//		vec.add("ASSERT (A > 'aB3');");
		//vec.add("ASSERT (A >= B);");
		//vec.add("ASSERT (A >= D);");
//		vec.add("ASSERT (C <> D);");
		//vec.add("ASSERT (C <= D);");
		long t=System.currentTimeMillis();
		Vector ret=s.solveConstraints(vec,null,null,true);
		if(ret==null) //System.out.println("UNSAT");
		//System.out.println(ret.size());
		for(int i=0;i<ret.size();i++){
			//System.out.println(ret.get(i));
		//System.out.println("time taken "+(System.currentTimeMillis()-t));
		}
		
	}		
}
