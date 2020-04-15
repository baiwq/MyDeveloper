global class CallSchedule implements Schedulable {
    global void execute(SchedulableContext sc) {
        Database.executeBatch(new CallBatch());
    }
}