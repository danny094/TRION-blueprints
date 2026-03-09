# TRION Blueprints

Official collection of ready-to-use container blueprints for TRION.

## 🚀 Quick Start

Install any blueprint with one command:

```bash
# Via TRION WebUI
Settings → Blueprints → Install from GitHub

# Or via CLI (coming soon)
trion blueprint install postgres-admin
```

## 📦 Available Blueprints

### Development
- **postgres-admin** 🐘 - PostgreSQL database with admin tools
- **redis-cache** ⚡ - Redis in-memory data store

### Data Science
- **jupyter-datascience** 📊 - Complete Jupyter Lab environment

### Media Processing
- **ffmpeg-processor** 🎬 - Video/audio conversion
- **whisper-stt** 🎤 - AI-powered speech-to-text

### Automation
- **n8n-automation** 🔄 - Visual workflow builder

## 🎯 Starter Pack (Recommended)

These 5 blueprints show the full power of TRION:

1. **postgres-admin** - Database management
2. **jupyter-datascience** - Data analysis
3. **ffmpeg-processor** - Media conversion
4. **n8n-automation** - Workflow automation
5. **whisper-stt** - AI transcription

## 📖 Blueprint Format

All blueprints follow the TRION Blueprint specification:

```yaml
id: my-blueprint
name: "My Blueprint"
description: "What it does"
icon: "🐍"
network: "none"  # none | internal | bridge | full
tags: ["tag1", "tag2"]

image: "docker-image:tag"
# OR
dockerfile: |
  FROM base-image
  RUN install-stuff

resources:
  cpu_limit: "2.0"
  memory_limit: "1g"
  timeout_seconds: 600

allowed_exec:
  - command1
  - command2
```

## 🤝 Contributing

Want to add your own blueprint?

1. Fork this repo
2. Create your blueprint YAML in `blueprints/category/`
3. Test it with TRION
4. Submit a Pull Request

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## 📦 Bundle Format

For sharing blueprints, use the `.trion-bundle.tar.gz` format:

```
my-blueprint.trion-bundle.tar.gz
├── blueprint.yaml
├── Dockerfile (optional)
├── README.md
└── meta.json
```

## 🔒 Security

All blueprints are:
- ✅ Reviewed for security
- ✅ Use pinned image digests (when applicable)
- ✅ Follow least-privilege principles
- ✅ Declare all required secrets

## 📝 License

MIT License - See [LICENSE](LICENSE)

## 🙏 Credits

Created with ❤️ by the TRION community

Built using:
- TRION AI System
- Claude Code
- Community contributions
