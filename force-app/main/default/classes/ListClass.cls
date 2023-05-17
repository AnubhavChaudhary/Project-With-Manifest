public class ListClass {
    public static void firstList(){
        List<List<Integer>> multiDimensional= new List<List<Integer>>();
        multiDimensional.add(new List<Integer>{1,2,3});
        multiDimensional.add(new List<Integer>{4,5,6});
        multiDimensional.add(new List<Integer>{7,8,9});
        system.debug(multiDimensional);
        multiDimensional[0][1]=4;
        multiDimensional[1][0]=2;
        multiDimensional[1][2]=8;
        multiDimensional[2][0]=3;
        multiDimensional[2][1]=6;
        system.debug(multiDimensional);        
        List<Integer> intList=new Integer[3];
        intList.add(1);
        intList.add(231);
        //intList[2]=2423;
        system.debug(intList);
        
    }
}