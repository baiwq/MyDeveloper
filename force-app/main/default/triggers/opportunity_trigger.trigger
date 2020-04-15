trigger opportunity_trigger on Opportunity(after insert) 
{
     new Triggers()
    //新建客户之后，需要给客户下的primary类型的联系人创建任务
    .bind(Triggers.Evt.afterinsert,new Handler_CreateTask())
    .execute();
}