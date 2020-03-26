namespace CMG.Common
{
    public static class Enums
    {
        public static string AgentCategories = "0, 1, 4, 5, 6";

        public enum AgentEnum
        {
            Peter = 1,
            Frank = 2,
            Bob = 3,
            Mary = 4,
            Kate = 5,
            Marty = 6,
            Others = 7
        }

        public enum LeftNavigation
        {
            Renewals = 0,
            FirstYearCommission = 1,
            Summary = 2,
            Search = 3,
            SalesForce = 4
        }
        public enum CaseStages
        {
            Discovery1 = 1,
            Discovery2 = 2,
            Design1 = 3,
            Design2 = 4,
            Delivery1 = 5,
            Delivery2 = 6,
            Destiny1 = 7,
            Destiny2 = 8
        }
    }
}
