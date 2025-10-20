# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Essential Commands

### Build & Development
```bash
# Build everything
yarn build

# Build JavaScript assets
yarn build:js

# Build flow editor
yarn build:editor

# Watch flow editor during development
yarn watch:editor

# Build CSS
yarn build:css

# Rails commands
bundle install
rails db:migrate
rails db:seed
rails server
```

### Testing
```bash
# Run Rails tests
rails test

# Run flow editor tests
cd flow_editor && yarn test

# Run flow editor tests with coverage
cd flow_editor && yarn test:coverage

# Run flow editor tests in watch mode
cd flow_editor && yarn test:watch

# Lint flow editor code
cd flow_editor && yarn lint
```

### Code Quality
```bash
# Run Ruby linter (Standard)
bundle exec standardrb

# Run security analysis
bundle exec brakeman
```

### Docker & Microservices
```bash
# Start all services (Rails app + Docling service)
docker-compose up

# Start in background
docker-compose up -d

# View logs
docker-compose logs -f

# Stop all services
docker-compose down

# Rebuild services
docker-compose build

# Start just the docling service
docker-compose up docling-service
```

## Architecture Overview

This is a Rails 8.0.2 application.

### Core Components
- **Rails Backend**: Main application with multi-tenant architecture using Plutonium framework

### Multi-Database Setup
The application uses SQLite with multiple database connections:
- Main database: Core application data
- Queue database: Background job processing (Solid Queue)
- Cache database: Application caching (Solid Cache)
- Errors database: Error tracking (Solid Errors)

## Development Patterns

### Plutonium Framework
The application heavily uses Plutonium for rapid admin interface development:
- Models include `Plutonium::Resource::Record`
- Definitions control UI and behavior declaratively
- Policies handle authorization and access control
- Auto-detection of fields from model attributes

### Node Development
When adding or modifying nodes, ensure you update:
- `flow_editor/schemas/validators/javascript/schema-validator.js`
- `flow_editor/schemas/validators/ruby/schema_validator.rb`
- `flow_editor/schemas/flow_schema.json`
- `app/views/home/features.html.erb`

### Testing Strategy
- Rails tests use fixtures and parallel execution
- React tests use Testing Library with comprehensive coverage
- Both unit and integration tests are maintained
- Flow execution tests ensure conversation logic works correctly

## Key Configuration Files

### Frontend Build
- `flow_editor/vite.config.js`: Flow editor build configuration
- `flow_editor/vite.webchat.config.js`: WebChat widget build configuration
- `postcss.config.js`: CSS processing configuration
- `tailwind.config.js`: Tailwind CSS configuration

### Rails Configuration
- `config/packages.rb`: Package registration
- `config/initializers/plutonium.rb`: Plutonium framework configuration
- `config/initializers/flowchat.rb`: FlowChat engine configuration
- `config/initializers/ruby_llm.rb`: AI/LLM integration

## Development Guidelines

### File Organization
When creating new files in the flow editor, follow these conventions:
- **Validation utilities**: Place in `flow_editor/src/utils/validation/`
- **Shared constants and utilities**: Place in `flow_editor/src/shared/`
- **Component-specific utilities**: Keep with the component or in `flow_editor/src/utils/`
- **Export from index files**: Update the relevant `index.js` files when adding new exports

### Node Schema Updates
When modifying node data structures or validation logic, always maintain consistency between JavaScript and Ruby implementations.

### Regression Testing
When fixing bugs, add regression tests to prevent similar issues in the future.

### Code Reusability
Extract common logic into reusable functions rather than duplicating code across components.

### CSS Framework
The project uses Tailwind CSS v4 for all styling. Use Tailwind utilities instead of custom CSS whenever possible.

## Authentication & Authorization

### Multi-tier Authentication
- **User Authentication**: Rodauth-based with email/password
- **Admin Authentication**: Separate admin system with enhanced security
- **Entity-based Authorization**: Multi-tenant access control through entity memberships

### Security Features
- CSRF protection enabled
- Content Security Policy configured
- Brakeman static security analysis
- Secure session management

## Entity Scoping & Multi-Tenancy

### How Entity Scoping Works
The application uses Plutonium's built-in entity scoping to ensure data isolation between tenants:

1. **Automatic Scoping**: The customer portal has `scope_to_entity Entity, strategy: :current_entity` configured in `packages/customer_portal/lib/engine.rb`
2. **Current Entity**: Available via `current_entity` method in controllers, which returns `Entity.for_user(current_user)`
3. **Query Filtering**: All queries through `authorized_resource_scope()` are automatically filtered by `entity_id`

### Using Authorized Scopes
Always use Plutonium's authorization helpers to ensure proper scoping:

```ruby
# ✅ CORRECT - Automatically scoped to current_entity
@hackers = authorized_resource_scope(Hacker)
@teams = authorized_resource_scope(Hackathon::Team)

# ❌ WRONG - Bypasses entity scoping
@hackers = Hacker.all
```


### Policy Implementation
Create policies for proper authorization:

```ruby
module HackerDashboardPortal
  module Hackathon
    class DefinitionPolicy < ResourcePolicy
      def show?
        record.entity_id == context[:current_entity].id
      end
    end
  end
end
```

### Security Checklist
- ✅ Always use `authorized_resource_scope()` for queries
- ✅ Never use `.all` or `.find()` directly on entity-scoped models
- ✅ Implement policies for all resources
- ✅ Test cross-entity access attempts
- ✅ For analytics, ensure all aggregations respect entity boundaries

## Deployment & Production

### Background Jobs
- Solid Queue for job processing
- Mission Control for job monitoring
- Recurring job support for scheduled tasks

### Error Monitoring
- Solid Errors for comprehensive error tracking
- Built-in error pages and handling

### Asset Pipeline
- Propshaft for asset serving
- ESBuild for JavaScript bundling
- Tailwind CSS for styling
- Source maps enabled for debugging