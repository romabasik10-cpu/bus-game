# 🚌 Cartoon Bus Game - 3D Models

## Опис / Description

Це колекція 3D моделей у картунному стилі для гри про автобуси на двигуні **Godot Engine** для **Android**.

This is a collection of cartoon-style 3D models for a bus game on **Godot Engine** for **Android**.

## 📁 Структура папок / Folder Structure

```
models/
├── buses/              # Автобуси / Buses
│   ├── city_bus.glb       # Міський автобус / City bus (red)
│   ├── school_bus.glb     # Шкільний автобус / School bus (yellow)
│   └── double_decker.glb  # Двоповерховий автобус / Double-decker bus (blue)
│
├── roads/              # Дороги та інфраструктура / Roads & Infrastructure
│   ├── straight_road.glb    # Пряма дорога / Straight road segment
│   ├── bus_stop.glb        # Автобусна зупинка / Bus stop with shelter
│   └── traffic_light.glb   # Світлофор / Traffic light
│
├── buildings/          # Будівлі міста / City Buildings
│   ├── house.glb           # Будинок / House with roof
│   ├── apartment.glb       # Багатоповерхівка / Apartment building
│   └── shop.glb            # Магазин / Shop with display window
│
├── landscape/          # Ландшафт / Landscape
│   ├── tree.glb            # Дерево / Tree (brown trunk, green crown)
│   ├── bench.glb           # Лавка / Park bench
│   ├── lamp_post.glb       # Ліхтар / Street lamp
│   └── grass_patch.glb     # Трав'яний покрив / Grass patch
│
├── characters/         # Персонажі / Characters
│   ├── passenger.glb       # Пасажир / Passenger (blue clothes)
│   └── driver.glb          # Водій / Bus driver (blue uniform, brown pants, cap)
│
└── vehicles/           # Транспорт / Vehicles
    ├── car.glb             # Автомобіль / Car (blue)
    └── bicycle.glb         # Велосипед / Bicycle
```

## 🎨 Стиль моделей / Model Style

- **Стиль**: Картун / Cartoon
- **Геометрія**: Low-poly (проста, оптимізована для мобільних пристроїв)
- **Кольори**: Яскраві, насичені тони
- **Формат**: GLB (GLTF Binary) - сумісний з Godot 3.x та 4.x

- **Style**: Cartoon
- **Geometry**: Low-poly (simple, optimized for mobile devices)
- **Colors**: Bright, saturated tones
- **Format**: GLB (GLTF Binary) - compatible with Godot 3.x and 4.x

## 📏 Розміри моделей / Model Sizes

### Автобуси / Buses
- **Міський автобус**: 6.0m × 2.2m × 2.5m
- **Шкільний автобус**: 5.5m × 2.0m × 2.3m
- **Двоповерховий**: 7.0m × 2.4m × 3.5m

### Дороги / Roads
- **Пряма дорога**: 10.0m × 4.0m × 0.1m
- **Автобусна зупинка**: 3.0m × 1.5m (платформа)
- **Світлофор**: 4.0m (висота)

### Будівлі / Buildings
- **Будинок**: 4.0m × 4.0m × 3.0m
- **Квартира**: 6.0m × 4.0m × 8.0m
- **Магазин**: 5.0m × 4.0m × 2.5m

### Ландшафт / Landscape
- **Дерево**: 2.0m (стовбур) + 1.2m (крона)
- **Лавка**: 1.5m × 0.4m × 0.5m
- **Ліхтар**: 4.0m (висота)

### Персонажі / Characters
- **Пасажир/Водій**: ~1.7m (зріст)

### Транспорт / Vehicles
- **Автомобіль**: 2.0m × 1.0m × 1.0m
- **Велосипед**: 0.8m × 0.1m × 0.4m

## 🚀 Як використовувати у Godot / How to Use in Godot

### 1. Імпорт моделей / Import Models

1. Відкрийте свій проект у Godot
2. Перетягніть файли `.glb` у вікно **FileSystem**
3. Або використайте **Import** → виберіть файли `.glb`

1. Open your project in Godot
2. Drag `.glb` files into the **FileSystem** panel
3. Or use **Import** → select `.glb` files

### 2. Додавання на сцену / Add to Scene

```gdscript
# Приклад коду для завантаження моделі
# Example code to load a model

var bus_scene = preload("res://models/buses/city_bus.glb")
var bus = bus_scene.instantiate()
add_child(bus)
```

### 3. Масштабування / Scaling

Моделі створені у реальному масштабі (1 одиниця = 1 метр). Якщо потрібно зменшити/збільшити:

Models are created at real-world scale (1 unit = 1 meter). To scale:

```gdscript
bus.scale = Vector3(0.5, 0.5, 0.5)  # Зменшити у 2 рази / Scale down by 2x
```

### 4. Оптимізація для Android / Android Optimization

Для покращення продуктивності на мобільних пристроях:

For better performance on mobile devices:

- Використовуйте **LOD (Level of Detail)** для віддалених об'єктів
- Об'єднуйте статичні об'єкти за допомогою **StaticBody**
- Використовуйте **Occlusion Culling**
- Зменшуйте кількість полігонів для фонових об'єктів

- Use **LOD (Level of Detail)** for distant objects
- Combine static objects using **StaticBody**
- Use **Occlusion Culling**
- Reduce polygon count for background objects

## 🔧 Технічні деталі / Technical Details

### Формат файлів / File Format
- **GLB (GLTF Binary)**: Бінарний формат, оптимізований для завантаження
- **Сумісність**: Godot 3.2+, Godot 4.0+

- **GLB (GLTF Binary)**: Binary format, optimized for loading
- **Compatibility**: Godot 3.2+, Godot 4.0+

### Матеріали / Materials
Кожна модель має вже призначені кольори у картунному стилі. Ви можете:

Each model has pre-assigned cartoon-style colors. You can:

- Змінити кольори у Godot через **Material**
- Додати текстури для більшого реалізму
- Використовувати **ShaderMaterial** для спеціальних ефектів

- Change colors in Godot via **Material**
- Add textures for more realism
- Use **ShaderMaterial** for special effects

### Оптимізація / Optimization
Моделі оптимізовані для мобільних пристроїв:

Models are optimized for mobile devices:

- Низька кількість полігонів (Low-poly)
- Проста геометрія
- Об'єднано подібні меші
- Видалено приховані полігони

- Low polygon count (Low-poly)
- Simple geometry
- Combined similar meshes
- Removed hidden polygons

## 📊 Статистика моделей / Model Statistics

| Категорія / Category | Кількість / Count | Загальний розмір / Total Size |
|---------------------|------------------|---------------------------|
| Автобуси / Buses | 3 | ~570 KB |
| Дороги / Roads | 3 | ~37 KB |
| Будівлі / Buildings | 3 | ~200 KB |
| Ландшафт / Landscape | 4 | ~50 KB |
| Персонажі / Characters | 2 | ~46 KB |
| Транспорт / Vehicles | 2 | ~200 KB |
| **Всього / Total** | **17** | **~1.1 MB** |

## 🎮 Приклади використання / Usage Examples

### Приклад 1: Створення простої сцени / Example 1: Create a Simple Scene

```gdscript
# main.gd

extends Node3D

func _ready():
    # Додаємо дорогу
    var road = preload("res://models/roads/straight_road.glb").instantiate()
    add_child(road)
    
    # Додаємо автобус
    var bus = preload("res://models/buses/city_bus.glb").instantiate()
    bus.position = Vector3(0, 0, 0.5)
    add_child(bus)
    
    # Додаємо дерево
    var tree = preload("res://models/landscape/tree.glb").instantiate()
    tree.position = Vector3(5, 0, 0)
    add_child(tree)
```

### Приклад 2: Анімація автобуса / Example 2: Bus Animation

```gdscript
# bus.gd

extends Node3D

var speed = 5.0

func _process(delta):
    position.z += speed * delta
    # Рух по колу / Circular movement
    # position.x = cos(Time.get_ticks_msec() * 0.001) * 10
    # position.z = sin(Time.get_ticks_msec() * 0.001) * 10
```

## 🔄 Генерація нових моделей / Generate New Models

Моделі були згенеровані за допомогою Python скрипта `generate_models.py`, який використовує бібліотеку **trimesh**.

Models were generated using the Python script `generate_models.py`, which uses the **trimesh** library.

### Як згенерувати нові моделі / How to Generate New Models

```bash
# Встановіть залежності / Install dependencies
pip install numpy trimesh scipy pygltflib

# Запустіть скрипт / Run the script
python3 generate_models.py
```

Скрипт автоматично створить усі моделі у папці `models/` у форматі GLB.

The script will automatically create all models in the `models/` folder in GLB format.

## 📝 Примітки / Notes

- Усі моделі знаходяться у **світових координатах** (1 одиниця = 1 метр)
- Моделі центровані по центру маси (origin у центрі)
- Для деяких моделей може знадобитися невелика корекція позиції після імпорту

- All models are in **world coordinates** (1 unit = 1 meter)
- Models are centered at the origin (center of mass)
- Some models may require slight position adjustment after import

## 🤝 Внесок / Contribution

Якщо ви хочете додати нові моделі або покращити існуючі:

If you want to add new models or improve existing ones:

1. Додайте нову функцію у `generate_models.py`
2. Додайте її у список `models_to_export`
3. Запустіть скрипт для генерації

1. Add a new function in `generate_models.py`
2. Add it to the `models_to_export` list
3. Run the script to generate

## 📄 Ліцензія / License

Ці моделі створені спеціально для вашої гри про автобуси. Ви можете вільно використовувати їх у своїх проектах.

These models were created specifically for your bus game. You can freely use them in your projects.

---

**Створено за допомогою Python, trimesh та Godot Engine**  
**Created with Python, trimesh, and Godot Engine**

*Дата генерації: 2024*  
*Generation date: 2024*
