// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$firebaseAuthHash() => r'7791bf70ce0f01bf991a53a76abc915478673c0b';

/// See also [firebaseAuth].
@ProviderFor(firebaseAuth)
final firebaseAuthProvider = AutoDisposeProvider<FirebaseAuth>.internal(
  firebaseAuth,
  name: r'firebaseAuthProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$firebaseAuthHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FirebaseAuthRef = AutoDisposeProviderRef<FirebaseAuth>;
String _$authStateChangesHash() => r'246216fb58ccd90cdc0648eb76dc26ef40047afa';

/// See also [authStateChanges].
@ProviderFor(authStateChanges)
final authStateChangesProvider = AutoDisposeStreamProvider<User?>.internal(
  authStateChanges,
  name: r'authStateChangesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authStateChangesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthStateChangesRef = AutoDisposeStreamProviderRef<User?>;
String _$uidHash() => r'455df0e3dac8573b1b3408eaee5ec535ea56c497';

/// See also [uid].
@ProviderFor(uid)
final uidProvider = AutoDisposeProvider<String?>.internal(
  uid,
  name: r'uidProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$uidHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UidRef = AutoDisposeProviderRef<String?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
