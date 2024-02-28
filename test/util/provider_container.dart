

/// A testing utility which creates a [ProviderContainer] and automatically
/// disposes it at the end of the test. Check out https://riverpod.dev/docs/essentials/testing
/// for more usage and information.
// ProviderContainer createContainer({
//   ProviderContainer? parent,
//   List<Override> overrides = const [],
//   List<ProviderObserver>? observers,
// }) {
//   // Create a ProviderContainer, and optionally allow specifying parameters.
//   final container = ProviderContainer(
//     parent: parent,
//     overrides: overrides,
//     observers: observers,
//   );

//   // When the test ends, dispose the container.
//   addTearDown(container.dispose);

//   return container;
// }

// /// A testing utility which creates a [ProviderScope] for widgets. This allows us to sub
// /// in a fake dependency for a real one while testing widgets
// ProviderScope createContainerForWidget({
//   ProviderContainer? parent,
//   List<Override> overrides = const [],
//   List<ProviderObserver>? observers,
//   required Widget child,
// }) {
//   // Create a ProviderContainer, and optionally allow specifying parameters.
//   return ProviderScope(
//     parent: parent,
//     overrides: overrides,
//     observers: observers,
//     child: child,
//   );
// }
