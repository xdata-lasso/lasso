package testDataGen;

public class levelStrcuture {
    public Integer queryLevel ;
    public Integer subqueryLevel ;
    public String repSQTable = "";
    public Boolean isAliasingSQTable ;

    levelStrcuture(int level, Boolean flag){
        this.queryLevel = level;
        this.isAliasingSQTable = flag;
    }
    public void setSubqueryLevel(int level){
        if(this.isAliasingSQTable)
            this.subqueryLevel = level;
    }
    public int getSubqueryLevel(){
        if(this.isAliasingSQTable)
            return this.subqueryLevel ;
        else return -1; // aliasing is not for subquery level
    }
    public void setQueryLevel(int level){
        this.queryLevel = level;
    }
    public int getQueryLevel(){
        return this.queryLevel ;
    }
    public void setRepSQTable(String tablename){
        this.repSQTable = tablename;
    }
    public String getRepSQTable() {
        return this.repSQTable;
    }
    public void setIfSQTableAlias(Boolean flag){
        this.isAliasingSQTable = flag;
    }
    public Boolean getIfSQTableAlias(){
        return this.isAliasingSQTable ;
    }
}
