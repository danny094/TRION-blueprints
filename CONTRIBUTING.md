# Contributing to TRION Blueprints

Thank you for your interest in contributing! 🎉

## How to Contribute a Blueprint

### 1. Create Your Blueprint

Create a YAML file in the appropriate category:

```yaml
id: my-awesome-tool
name: "My Awesome Tool"
description: "What your tool does"
icon: "🚀"
network: "none"  # or internal, bridge, full
tags:
  - category1
  - category2

image: "docker/image:tag"
# OR
dockerfile: |
  FROM base-image
  RUN install-commands

resources:
  cpu_limit: "2.0"
  memory_limit: "1g"
  timeout_seconds: 600

allowed_exec:
  - command1
  - command2
```

### 2. Test It

Before submitting, test your blueprint with TRION:

1. Copy YAML to your TRION instance
2. Create a container from it
3. Verify all features work
4. Check resource usage

### 3. Submit a Pull Request

1. Fork this repository
2. Add your blueprint to `blueprints/category/your-blueprint.yaml`
3. Update `index.json` with your blueprint metadata
4. Create a PR with:
   - Blueprint YAML file
   - Updated index.json
   - README for your blueprint (optional but recommended)

### 4. Blueprint Requirements

Your blueprint must:

✅ Have a unique ID (no conflicts)
✅ Include proper resource limits
✅ Specify all required secrets
✅ Use specific image tags (not `:latest`)
✅ Include a clear description
✅ Define allowed_exec commands
✅ Follow security best practices

### 5. Categories

Place your blueprint in the right category:

- `development/` - Databases, dev tools, IDEs
- `data-science/` - ML, analytics, notebooks
- `media/` - Audio, video, image processing
- `automation/` - Workflows, integrations, bots
- `gaming/` - Game servers, streaming
- `security/` - Penetration testing, monitoring

### 6. Security Guidelines

🔒 Security checklist:

- Pin image digests when possible
- Use minimal base images (alpine, slim)
- Don't run as root unless necessary
- Limit network access appropriately
- Declare all secrets explicitly
- Use least-privilege exec commands
- Set reasonable resource limits

### 7. Example Blueprint Structure

```
blueprints/media/my-tool.yaml         # Blueprint definition
blueprints/media/my-tool/             # Optional extras
    README.md                          # Usage guide
    examples/                          # Example files
    scripts/                           # Helper scripts
```

## Questions?

- Open an issue for questions
- Check existing blueprints for examples
- Join the TRION Discord (coming soon)

## License

By contributing, you agree that your contributions will be 
licensed under the MIT License.

Thank you for making TRION better! 🚀
