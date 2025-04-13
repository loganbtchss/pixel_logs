# Pixel Logs
This is an advanced Discord logging system for FiveM and RedM servers, providing comprehensive logging capabilities with a clean and modern interface.

> [!CAUTION]
> This resource is not yet ready for production use and is only public at this stage for transparency. Please check back in a few days for an official release :D 

## 📑 Table of Contents

- [🚀 Features](#-features)
- [📦 Installation](#-installation)
- [📚 Documentation](#-documentation)
- [❓ Support](#-support)
- [📄 License](#-license)
- [👥 Credits](#-credits)

## 🚀 Features

- **Comprehensive Event Logging**: Player joins/leaves, chat messages, deaths, commands, administrative actions, resource events, and more
- **Debug System**: In-memory debug logging with configurable retention and detailed error tracking
- **Customizable Configuration**: Per-event type toggling, customizable message templates, and more
- **Discord Integration**: Clean and modern Discord embeds with player avatars and detailed information
- **Proxy Support**: Route Discord webhook requests through a proxy server
- **txAdmin Integration**: Log txAdmin events directly to Discord

## 📦 Installation

1. Download the latest release from the [GitHub repository](https://github.com/ByteBrushStudios/pixel_logs/releases)
2. Extract the files to your server's resources directory
3. Add `ensure pixel_logs` to your server.cfg
4. Copy the `temp/pixel_convars.cfg` file to your server's config directory
5. Edit the `pixel_convars.cfg` file to set your desired values
6. Add `exec "pixel_convars.cfg"` to your server.cfg

## 📚 Documentation

For detailed information about Pixel Logs, please refer to the following documentation:

- [Installation Guide](docs/installation.md) - Detailed installation instructions
- [Configuration Guide](docs/configuration.md) - How to configure Pixel Logs
- [Events Guide](docs/events.md) - Information about events and exports
- [Customization Guide](docs/customization.md) - How to customize message templates and appearance
- [Debug Guide](docs/debug.md) - How to use the debug system
- [Proxy Support Guide](docs/proxy.md) - How to use proxy support
- [Troubleshooting Guide](docs/troubleshooting.md) - Solutions for common issues
- [Integration Guide](docs/integration.md) - How to integrate with other resources
- [Convars Guide](docs/convars.md) - Detailed information about convars

## ❓ Support

> [!IMPORTANT]
> For support, feature requests, or bug reports, please:
> 1. Check the [GitHub Issues](https://github.com/ByteBrushStudios/pixel_logs/issues)
> 2. Join our [Discord Server](https://discord.gg/Vv2bdC44Ge)

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Credits

- Developed by [Pixelated](https://codemeapixel.dev)
- Maintained by [ByteBrush Studios](https://github.com/ByteBrushStudios) 