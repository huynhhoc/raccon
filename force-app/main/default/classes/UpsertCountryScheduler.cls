global class UpsertCountryScheduler implements Schedulable{
    global void execute(SchedulableContext SC) {
      System.enqueueJob(new UpsertCountryQueueable());
   }
}