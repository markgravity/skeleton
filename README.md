# Skeletor

It provides an elegant way to show skeleton animation.

<img src="https://github.com/markgravity/skeleton/raw/main/demo.gif" width=300>

## Usage



- ** Wrap on the top of the content with `Skeleton`**

```dart
Skeleton(
  isShown: true,
  child: content,
)
```



- **Then, wrap the widget to show skeleton animation with `Bone`**

A single bone

```dart
Bone(
  width: 300,
  height: 30,
  child: Text("What is Lorem Ipsum?"),
),
```



Multiple bones

```dart
Bone.multiple(
  number: 8,
  spacing: 8,
  height: 30,
  variants: [1, 1, 0.95],
  borderRadius: BorderRadius.circular(8),
  child: Text(
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"),
)
```



Or, just hidden a widget when skeleton animation is running

```dart
Bone.hidden(child: Text("A hidden text"))
```
