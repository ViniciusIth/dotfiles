package main

import (
	"bufio"
	"fmt"
	"os"
	"os/exec"
	"path"
	"path/filepath"
	"strconv"
	"strings"
)

type module struct {
	name string
	path string
}

func main() {
	ensureBashLoader()

	wd, _ := os.Getwd()
	modules := discoverModules(path.Join(wd, "modules"))
	if len(modules) == 0 {
		fmt.Println("No modules found")
		os.Exit(1)
	}

	printModules(modules)

	selected := promptSelection(len(modules))
	for _, idx := range selected {
		mod := modules[idx]
		runModule(mod)
	}

	fmt.Println("\n✔ All selected modules installed")
}

func discoverModules(base string) []module {
	entries, err := os.ReadDir(base)
	if err != nil {
		panic(err)
	}

	var mods []module
	for _, e := range entries {
		if e.IsDir() {
			mods = append(mods, module{
				name: e.Name(),
				path: filepath.Join(base, e.Name()),
			})
		}
	}
	return mods
}

func printModules(mods []module) {
	fmt.Println("Available modules:")
	for i, m := range mods {
		fmt.Printf("%d) %s\n", i+1, m.name)
	}
	fmt.Println()
}

func promptSelection(max int) []int {
	reader := bufio.NewReader(os.Stdin)
	fmt.Print("Select modules to install (comma-separated): ")
	line, _ := reader.ReadString('\n')
	line = strings.TrimSpace(line)

	parts := strings.Split(line, ",")
	var result []int

	for _, p := range parts {
		i, err := strconv.Atoi(strings.TrimSpace(p))
		if err != nil || i < 1 || i > max {
			fmt.Printf("Invalid selection: %s\n", p)
			os.Exit(1)
		}
		result = append(result, i-1)
	}

	return result
}

func runModule(m module) {
	fmt.Printf("\n▶ Installing %s\n", m.name)

	installer := detectInstaller(m.path)
	config := detectConfig(m.path)

	if installer == "" {
		fmt.Println("  no installer found, skipping")
		goto LINK
	}
	fmt.Printf("  running %s\n", filepath.Base(installer))
	runCmd(installer, m.path, m.name)

	if config == "" {
		fmt.Println("  no config found, skipping")
		goto LINK
	}
	fmt.Printf("  running %s\n", filepath.Base(config))
	runCmd(config, m.path, m.name)

LINK:
	shell := filepath.Join(m.path, "shell.bash")
	if exists(shell) {
		dst := filepath.Join(os.Getenv("HOME"), ".config/bash", m.name+".bash")
		ensureSymlink(shell, dst)
		fmt.Printf("  linked shell.bash → %s\n", dst)
	}
}

func detectSystemPM() string {
	for _, pm := range []string{"pacman", "dnf", "apt", "brew"} {
		if _, err := exec.LookPath(pm); err == nil {
			return pm
		}
	}
	return ""
}

func detectInstaller(path string) string {
	// pm := detectSystemPM()
	// fmt.Printf("  detected package manager: %s\n", pm)

	// if pm != "" {
	// 	p := filepath.Join(path, pm+".sh")
	// 	if exists(p) {
	// 		return p
	// 	}
	// }

	p := filepath.Join(path, "local.sh")
	if exists(p) {
		return p
	}

	return ""
}

func detectConfig(path string) string {
	p := filepath.Join(path, "config.sh")
	if exists(p) {
		return p
	}

	return ""
}

func runCmd(script, dir, prefix string) {
	cmd := exec.Command("bash", script)
	cmd.Dir = dir
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	cmd.Stdin = os.Stdin

	if err := cmd.Run(); err != nil {
		fmt.Printf("[%s] installer failed: %v\n", prefix, err)
		os.Exit(1)
	}
}

func exists(p string) bool {
	_, err := os.Stat(p)
	return err == nil
}

func ensureBashLoader() {
	wd, _ := os.Getwd()

	src := filepath.Join(wd, "loader", "bash.rc")
	loader, err := os.ReadFile(src)
	if err != nil {
		panic(err)
	}

	dst := filepath.Join(os.Getenv("HOME"), ".bashrc")

	// If already present, do nothing
	if data, err := os.ReadFile(dst); err == nil {
		if strings.Contains(string(data), ".config/bash") {
			return
		}
	}

	f, err := os.OpenFile(dst, os.O_CREATE|os.O_APPEND|os.O_WRONLY, 0644)
	if err != nil {
		panic(err)
	}
	defer f.Close()

	f.WriteString("\n# added by config installer\n")
	f.Write(loader)
	f.WriteString("\n")
}

func ensureSymlink(src, dst string) {
	backup := dst + ".bak"

	// Ensure parent directory exists
	if err := os.MkdirAll(filepath.Dir(dst), 0755); err != nil {
		panic(err)
	}

	// If destination exists
	if info, err := os.Lstat(dst); err == nil {
		// If it's already the correct symlink, do nothing
		if info.Mode()&os.ModeSymlink != 0 {
			if target, err := os.Readlink(dst); err == nil && target == src {
				return
			}
		}

		// Otherwise back it up
		if err := os.Rename(dst, backup); err != nil {
			panic(err)
		}
	}

	// Create symlink
	if err := os.Symlink(src, dst); err != nil {
		panic(err)
	}
}
