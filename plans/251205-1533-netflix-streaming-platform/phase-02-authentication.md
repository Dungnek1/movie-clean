# Phase 02: Authentication

**Parent:** [plan.md](./plan.md) | **Priority:** P0 | **Status:** Planned

---

## Context

**Dependencies:** Phase 01 (User/Profile entities)
**Research:** [Flutter Packages](./research/researcher-02-flutter-packages.md)

---

## Overview

Implement secure authentication with JWT, multi-profile support, and session management. Support email/password + social login.

**Estimated Duration:** 4-5 days

---

## Key Insights

- flutter_secure_storage for token persistence (Keychain/KeyStore)
- Refresh token rotation for security
- Profile isolation critical for watch history separation
- Web platform: flutter_secure_storage experimental; consider alternatives

---

## Requirements

**Functional:**
- Email/password login + registration
- Social login (Google, Apple)
- Multi-profile support (up to 5 profiles)
- Profile switching without re-auth
- Remember me / auto-login
- Logout from all devices

**Technical:**
- JWT access + refresh token pattern
- Secure storage for tokens
- Dio interceptor for auth headers
- GoRouter redirect guards

---

## Architecture

### Auth Flow
```
App Start → Check Token → Valid? → Fetch Profiles → Profile Select → Home
                        → Invalid? → Refresh Token → Success? → Continue
                                                   → Fail? → Login Screen
```

### State Management
```dart
AuthState
├── initial        # App just started
├── unauthenticated # No valid session
├── authenticated   # Valid token, no profile selected
└── profileSelected # Profile active, ready to browse
```

### Repository Pattern
```
AuthRepository (interface)
├── login(email, password) → AuthResult
├── register(email, password, name) → AuthResult
├── refreshToken() → TokenPair
├── logout() → void
└── socialLogin(provider) → AuthResult

ProfileRepository (interface)
├── getProfiles() → List<Profile>
├── createProfile(name, avatar, isKid) → Profile
├── updateProfile(profile) → Profile
├── deleteProfile(id) → void
└── switchProfile(id) → Profile
```

---

## Related Code Files

### Existing (Modify)
- `lib/src/presentation/router/app_router.dart` - Add auth guards
- `lib/main.dart` - Add auth initialization

### New Files
```
lib/src/domain/
├── repositories/auth_repository.dart
└── repositories/profile_repository.dart

lib/src/data/
├── datasources/auth_remote_data_source.dart
├── datasources/auth_local_data_source.dart
├── repositories/auth_repository_impl.dart
└── repositories/profile_repository_impl.dart

lib/src/presentation/
├── providers/auth_provider.dart
├── pages/login_page.dart
├── pages/register_page.dart
├── pages/profile_select_page.dart
├── pages/profile_create_page.dart
└── widgets/profile_avatar.dart

lib/src/core/
├── services/secure_storage_service.dart
└── interceptors/auth_interceptor.dart
```

---

## Implementation Steps

1. Add dependencies: flutter_secure_storage, google_sign_in, sign_in_with_apple
2. Create SecureStorageService for token management
3. Create AuthRepository interface with login/register/refresh methods
4. Create AuthRemoteDataSource for API calls
5. Create AuthLocalDataSource for token persistence
6. Implement AuthRepositoryImpl combining remote + local
7. Create ProfileRepository interface
8. Implement ProfileRepositoryImpl
9. Create AuthNotifier (Riverpod) managing auth state
10. Create AuthInterceptor for Dio (auto-attach tokens, handle 401)
11. Create LoginPage with email/password form
12. Create RegisterPage
13. Create ProfileSelectPage with avatar grid
14. Create ProfileCreatePage with avatar picker
15. Update GoRouter with auth redirect logic
16. Add logout functionality

---

## Todo List

- [ ] Add flutter_secure_storage ^9.0.0
- [ ] Add google_sign_in ^6.2.0
- [ ] Add sign_in_with_apple ^5.0.0
- [ ] Create SecureStorageService
- [ ] Create AuthRepository interface
- [ ] Create AuthRemoteDataSource
- [ ] Create AuthLocalDataSource
- [ ] Implement AuthRepositoryImpl
- [ ] Create ProfileRepository interface
- [ ] Implement ProfileRepositoryImpl
- [ ] Create AuthNotifier StateNotifier
- [ ] Create AuthInterceptor for Dio
- [ ] Create LoginPage UI
- [ ] Create RegisterPage UI
- [ ] Create ProfileSelectPage UI
- [ ] Create ProfileCreatePage UI
- [ ] Create ProfileAvatar widget
- [ ] Configure GoRouter guards
- [ ] Handle deep link auth callbacks
- [ ] Test token refresh flow

---

## Success Criteria

- [ ] Login/Register flow works end-to-end
- [ ] Tokens persist across app restarts
- [ ] 401 triggers automatic token refresh
- [ ] Profile switching maintains session
- [ ] Social login buttons functional
- [ ] Logout clears all secure data

---

## Risk Assessment

| Risk | Impact | Mitigation |
|------|--------|------------|
| Token storage on web | High | Use secure cookies or alternative |
| Social login config | Medium | Document setup steps clearly |
| Refresh race conditions | Medium | Queue requests during refresh |

---

## Security Considerations

- Never log tokens to console
- Use HTTPS only for auth endpoints
- Implement rate limiting on login attempts
- Hash passwords server-side only
- Certificate pinning for production
- Secure storage encryption key management

---

## Next Steps

**Depends on this phase:**
- Phase 03: Video Streaming (authenticated playback)
- Phase 05: Content Management (profile-based history)
- Phase 08: Advanced Features (parental controls)

---

## Unresolved Questions

1. Backend auth provider: Firebase Auth vs custom JWT server?
2. Social login providers: Google + Apple or more?
3. Biometric login support?
4. Session timeout duration?
