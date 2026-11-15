# 🚌 Cartoon Bus Game

A fun 3D bus driving game for Android built with Godot Engine 4.x. Drive a cartoon-style bus, pick up passengers, and deliver them to their destinations!

## 🎮 Game Features

- **Drive 3 Different Buses**: City bus, school bus, and double-decker bus
- **Pick Up & Drop Off Passengers**: Earn points by transporting passengers
- **Explore a Cartoon City**: Beautiful low-poly cartoon-style environment
- **Simple Controls**: Easy to learn, fun to master
- **Score System**: Track your performance
- **Time Limit**: Complete as many deliveries as possible in 5 minutes

## 📱 Android Compatibility

This game is optimized for Android devices with:
- Low-poly 3D models for better performance
- Touch controls support
- Responsive UI for various screen sizes

## 📁 Project Structure

```
bus_game/
├── project.godot              # Godot project configuration
├── icon.svg                   # Game icon
├── README.md                  # This file
│
├── scenes/                    # Game scenes
│   ├── main.tscn              # Main game scene
│   ├── bus.tscn               # Bus character scene
│   ├── world.tscn             # Game world with roads, buildings, etc.
│   ├── camera.tscn            # Camera follow system
│   └── ui.tscn                # User interface
│
├── scripts/                   # GDScript files
│   ├── main.gd                # Main game controller
│   ├── bus.gd                 # Bus movement and controls
│   ├── camera.gd              # Camera follow logic
│   ├── ui.gd                  # UI controller
│   ├── game_manager.gd        # Global game state manager
│   ├── audio_manager.gd       # Audio controller
│   ├── passenger.gd           # Passenger AI
│   └── bus_stop.gd            # Bus stop logic
│
├── models/                    # 3D models (imported)
│   ├── buses/                  # Bus models
│   ├── roads/                 # Road and infrastructure
│   ├── buildings/             # City buildings
│   ├── landscape/             # Trees, benches, etc.
│   ├── characters/            # Passenger and driver
│   └── vehicles/              # Other vehicles
│
├── environments/              # Environment settings
│   └── day.env                # Daytime environment
│
└── assets/                    # Game assets
    ├── textures/              # Textures
    ├── fonts/                 # Fonts
    └── sounds/                # Sound effects
```

## 🚀 Quick Start

### Prerequisites

- [Godot Engine 4.x](https://godotengine.org/) (Tested with 4.2+)
- Android Build Template (for exporting to Android)

### Running the Game

1. **Open the project in Godot**:
   ```bash
   godot project.godot
   ```

2. **Run the game**:
   - Press F5 or click the Play button
   - The game will start with the title screen

3. **Controls**:
   - **W/↑**: Accelerate
   - **S/↓**: Reverse
   - **A/←**: Turn left
   - **D/→**: Turn right
   - **Space**: Brake
   - **H**: Honk

### Exporting to Android

1. **Install Android Build Template**:
   - Download from Godot website
   - Install via Godot Editor → Editor → Manage Export Templates

2. **Configure Android Export**:
   - Go to Project → Export
   - Add Android preset
   - Configure package name, version, etc.

3. **Export**:
   - Click Export PCK/ZIP
   - Install APK on Android device

## 🎯 Gameplay

### Objective
Pick up passengers at bus stops and deliver them to their destinations to earn points. The more passengers you deliver, the higher your score!

### Scoring
- **Pick up passenger**: +10 points
- **Drop off passenger**: +20 points
- **Time bonus**: Additional points based on remaining time

### Game Modes
- **Classic Mode**: 5-minute time limit, deliver as many passengers as possible
- **Endless Mode**: No time limit, see how long you can keep going

## 🛠️ Customization

### Adding New Buses
1. Create a new bus model in `models/buses/`
2. Create a new scene in `scenes/` for the bus
3. Attach the `bus.gd` script
4. Update `main.tscn` to use the new bus

### Adding New Levels
1. Create a new world scene in `scenes/`
2. Add roads, buildings, and bus stops
3. Configure passenger spawn points
4. Update `main.gd` to load the new level

### Modifying Controls
Edit `bus.gd` to change:
- `max_speed`: Maximum bus speed
- `acceleration`: How quickly the bus speeds up
- `rotation_speed`: How quickly the bus turns
- `brake_force`: How strong the brakes are

## 🎨 Art Style

The game uses a **cartoon/low-poly** art style:
- Bright, saturated colors
- Simple geometry (low polygon count)
- Exaggerated proportions
- Smooth, rounded shapes

All 3D models are in **GLB format** and can be edited in Blender or other 3D tools.

## 📊 Performance Optimization

For best performance on Android:

1. **LOD (Level of Detail)**: Use lower-poly models for distant objects
2. **Occlusion Culling**: Don't render objects that aren't visible
3. **Object Pooling**: Reuse objects instead of creating/destroying them
4. **Texture Compression**: Use compressed textures (ETC2 for Android)
5. **Reduce Draw Calls**: Combine static objects

## 🔧 Troubleshooting

### Models Not Loading
- Check that model files are in the correct location
- Verify file permissions
- Ensure models are in GLB format

### Controls Not Working
- Check input mapping in Project Settings
- Verify that input actions are defined
- Test with keyboard first, then add touch controls

### Performance Issues
- Reduce number of active objects
- Lower texture resolution
- Simplify models
- Reduce shadow quality

## 📝 Credits

- **3D Models**: Generated with Python + trimesh
- **Game Engine**: Godot Engine 4.x
- **Art Style**: Cartoon / Low-poly

## 📄 License

This project is created for your bus game. You can use it freely for your own projects.

## 🤝 Contributing

Feel free to:
- Add new features
- Improve existing code
- Create new levels
- Add more 3D models
- Fix bugs

## 📞 Support

For questions or issues:
- Check the Godot documentation
- Search online forums
- Ask in Godot community channels

---

**Happy Coding! 🎮**

*Created: 2024*
*Godot Version: 4.x*
