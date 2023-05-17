public class ReturnDuplicateRecords {
    public static void retunDuplicate(List<Integer> List1, List<Integer> List2, List<Integer> List3){
        Set<Integer> set1= new Set<Integer>();
        Set<Integer> duplicateSet= new Set<Integer>();
        set1.addAll(List1);
        system.debug(set1);
        integer i;
        integer j;
        for(i=0;i<List2.size();i++)
        {
            if(set1.contains(List2[i]))
            {
                for(j=0;j<List3.size();j++)
                {
                    if(set1.contains(List3[j]))
                    {
                        duplicateSet.add(List3[j]);
                    }
                }
            }
        }
        System.debug(duplicateSet);
    }
}
//List<Integer> list1= new List<Integer>();
//list1.add(12);
//list1.add(34);
//list1.add(4);
//List<Integer> list2= new List<Integer>();
//list2.add(4);
//list2.add(14);
//list2.add(24);
//List<Integer> list3= new List<Integer>();
//list3.add(112);
//list3.add(314);
//list3.add(4);
//ReturnDuplicateRecords.retunDuplicate(list1,list2,list3);