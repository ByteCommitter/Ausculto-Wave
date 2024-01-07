import 'package:flutter/material.dart';
import 'package:test/Addpage.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  @override
  void initState(){
    super.initState();
  }

  int _selectedIndex = 0;
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

  @override
  Widget build(BuildContext context){
    

    return  Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(
        elevation: 0,
        title:const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Ausculto",
                          style:
                          TextStyle(color: Color.fromARGB(221, 7, 173, 224), fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Wave",
                          style: TextStyle(color: Color.fromARGB(255, 248, 213, 16), fontWeight: FontWeight.w600),
                        )
                      ],
                    ),centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),

      body: IndexedStack(
        index: _selectedIndex,
        children: <Widget>[
          // Add the widgets that should be displayed when a tab is selected
          // For example:
          // FirstTab(),
          // SecondTab(),....
            ListView(
              //Main Home Page here:

                  children: const [
                    Text("   Top Categories",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold)),
                      
                      
              ]),
            
            AddScreen(),

            //Profile Page
            
            Center(
            child:ListView(
              //Main Home Page here:

                  children: const [
                    Text("  Profile Page",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold)),
                      
                      
              ]),),
          

            const Icon(
              Icons.person_outline_rounded,
              size: 150,
            ),

        ],
      ),
      
      

      //Bottom Navigation Bar:
      bottomNavigationBar: BottomNavigationBar(
        //decoration of the bar
        type: BottomNavigationBarType.shifting,
        selectedIconTheme: const IconThemeData(color: Color.fromARGB(221, 7, 173, 224)),
        iconSize: 34,
        selectedItemColor: const Color.fromARGB(255, 248, 213, 16),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedIconTheme: const IconThemeData(
          color: Color.fromARGB(255, 0, 0, 0),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0, 
        //to do with the different pages in the bar
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.add),
        label: "Home",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.add_circle_outline),
        label: 'Add File',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person_outline_rounded),
        label: 'Profile',
      ),
    ],
    currentIndex: _selectedIndex, //New
    onTap: _onItemTapped,
  ),
  

      
    );
  }
}


