# 🚀 KSP kOS Repository

*A collection of Kerbal Space Program resources for automated space exploration using kOS*

![Kerbal Space Program Banner](https://upload.wikimedia.org/wikipedia/it/1/1e/Kerbal_Space_Program_logo.png)

**Disclaimer:** This repository is not affiliated with or endorsed by Squad or Private Division. All trademarks belong to their respective owners.

## 📂 Repository Contents

This repository contains various resources for enhancing your Kerbal Space Program experience with kOS (Kerbal Operating System), including:

- **kOS Scripts**: Automated launch systems, orbital maneuvers, and landing procedures
- **Mod Configurations**: Recommended mod lists and compatibility notes
- **Tutorials**: Getting started guides and script examples
- **Craft Files**: Example vessels pre-configured for kOS control
- **Utilities**: Helper tools and configuration files

## 📜 kOS Scripts Directory

```
/scripts/
├── launch/
│   ├── basic_launch.ks      # Basic rocket launch to 100km orbit
│   └── spaceplane_launch.ks # SSTO spaceplane ascent profile
├── orbital/
│   ├── hohmann_transfer.ks  # Efficient orbital transfer calculations
│   └── rendezvous.ks        # Automated spacecraft docking
├── landing/
│   ├── mun_landing.ks       # Precision Mun landing script
│   └── powered_descent.ks   # Controlled descent algorithm
└── lib/
    └── math_utils.ks        # Common mathematical functions
```

## 🔧 Recommended Mod List

Essential mods for kOS development:
- [kOS (Kerbal Operating System)](https://forum.kerbalspaceprogram.com/index.php?/topic/182200-181-ksp-kos-ksp-kos-v130/)
- [MechJeb 2](https://forum.kerbalspaceprogram.com/index.php?/topic/175277-181-mechjeb-2-801/) (for reference and comparison)
- [Kerbal Engineer Redux](https://forum.kerbalspaceprogram.com/index.php?/topic/182679-181-kerbal-engineer-redux-1415/) (flight data)
- [Module Manager](https://forum.kerbalspaceprogram.com/index.php?/topic/50533-18x-module-manager-414-july-31st-2020/) (mod compatibility)

## 💻 Installation

1. Install kOS through CKAN or manually:
   ```bash
   CKAN → Search "kOS" → Install
   ```
2. Clone this repository to your KSP Scripts folder:
   ```bash
   git clone https://github.com/your-username/KSP-kOS.git /path/to/KSP/Ships/Script/
   ```
3. Launch KSP and ensure kOS is enabled in the mod settings

## 🛠️ Usage Example

Run a basic launch script:
```bash
RUN basic_launch.ks.
```

Monitor script execution:
```bash
LIST.
PRINT SHIP:ALTITUDE.
```

## 🤝 Contributing

Contributions welcome! Please follow these guidelines:
1. Fork the repository
2. Create a feature branch (`git checkout -b new-feature`)
3. Commit changes with descriptive messages
4. Push to branch and open a Pull Request

## 📄 License

This project is licensed under MIT License - see [LICENSE](LICENSE) file for details.

## 🌟 Acknowledgements

- kOS development team for creating this amazing mod
- Squad for developing Kerbal Space Program
- Mod creators in the KSP community
