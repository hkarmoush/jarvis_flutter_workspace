# Jarvis Flutter Workspace

A monorepo containing reusable Flutter packages and applications.

## Project Structure

```
/jarvis_flutter_workspace
├── packages/
│   ├── core_ui/         # Reusable UI components and design system
│   ├── core_utils/      # Common utility functions and extensions
│   ├── core_network/    # Network layer with Dio integration
│   ├── core_state/      # State management utilities
│   ├── core_storage/    # Local storage utilities
│   ├── core_router/     # Navigation and routing utilities
│   ├── core_localization/ # Internationalization utilities
│   └── core_analytics/  # Analytics and event tracking
├── apps/
│   ├── app_one/         # Example application one
│   └── app_two/         # Example application two
└── melos.yaml           # Melos configuration
```

## Getting Started

1. Install Melos:
```bash
dart pub global activate melos
```

2. Bootstrap the workspace:
```bash
melos bootstrap
```

3. Run commands across all packages:
```bash
melos run analyze  # Run static analysis
melos run test     # Run tests
melos run format   # Format code
```

## Package Dependencies

Each package has its own dependencies, but they follow a hierarchical structure:
- `core_utils` is the base package used by all other packages
- Other packages depend on `core_utils` and may depend on each other as needed
- Applications depend on all core packages

## Development

1. Create a new package:
```bash
mkdir packages/your_package
cd packages/your_package
flutter create --template=package .
```

2. Add the package to melos.yaml:
```yaml
packages:
  - "packages/your_package"
```

3. Bootstrap to update dependencies:
```bash
melos bootstrap
```

## Best Practices

- Follow semantic versioning for package releases
- Write comprehensive tests for each package
- Document public APIs and usage examples
- Keep packages focused on a single responsibility
- Use conventional commits for version management 