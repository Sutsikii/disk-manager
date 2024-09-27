package main

import (
	"fmt"
	"os"
	"os/exec"
)

func runCommand(name string, args ...string) {
	cmd := exec.Command(name, args...)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	err := cmd.Run()
	if err != nil {
		fmt.Printf("Erreur lors de l'exécution de %s: %v\n", name, err)
	}
}

func listDisks() {
	fmt.Println("Liste des disques :")
	runCommand("lsblk")
}

func diskUsage() {
	fmt.Println("Utilisation des disques :")
	runCommand("df", "-h")
}

func main() {
	if len(os.Args) < 2 {
		fmt.Println("Usage: disk-manager <command>")
		fmt.Println("Commands:")
		fmt.Println("  list    - Liste des disques")
		fmt.Println("  usage   - Affiche l'utilisation du disque")
		os.Exit(1)
	}

	switch os.Args[1] {
	case "list":
		listDisks()
	case "usage":
		diskUsage()
	default:
		fmt.Println("Commande non reconnue:", os.Args[1])
	}
}
