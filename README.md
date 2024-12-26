Do whatever you want with it, have fun :>

Install:
    1. Drag and drop the artex-3dtextui to your fivem server recources folder where you now want it to be
    2. Ensure the folder in the server.cfg if not already done with the [ParentForlderName] or whatever you named the file where you start your recources
    3. Done now you just have to add it to some script you want to use it on

Usage in the client of a script:

1 arg: Title  
2 arg: Whether to show the simpe text from far away or not  
3 arg: Key you have to input when close to execute what you want  
4 arg: Action like Press e to get healthcare or Press e to teleport to hospital  
5 arg: Whether to show your own text or not if not leave emty string  
6 arg: Coords where it sohuld be(can be GetEntityCoords(PlayerPedId()) to put it on the ped)  
7 arg: Global distance how far away the simple text should be shown  
8 arg: Close range distance of how far away the advanced text/prompt to do sometihng will show  
9 arg: Whether to have you hold the toggle keybind or not to show the simple text  
10 arg: Whether you will display the advancetext or not(having this set to true will not let you press a button to execute stuff etc and setting to false will)  
11 arg: A function that executes what you want to execute  

exports['artex-3dtextui']:StartText3d("Healthcare", true, 46, "get", "", vector3(296.0008850097656, -591.5004272460938, 43.27257537841797), 3.0, 1.0, false, false, function()
    print(GetEntityHealth(PlayerPedId()))
end)
