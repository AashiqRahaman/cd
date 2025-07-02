#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX 20

int n; // number of states
int epsilon[MAX][MAX]; // epsilon[i][j] = 1 if epsilon transition from i to j
int closure[MAX]; // stores visited states for closure

void epsilon_closure(int state) {
    closure[state] = 1;
    for (int j = 0; j < n; j++) {
        if (epsilon[state][j] == 1 && closure[j] == 0) {
            epsilon_closure(j);
        }
    }
}

int main() {
    int trans;
    int from, to;
    char symbol;

    printf("Enter number of states: ");
    scanf("%d", &n);

    printf("Enter number of transitions: ");
    scanf("%d", &trans);

    // Initialize transition matrix
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++)
            epsilon[i][j] = 0;

    printf("Enter transitions (from to symbol), use 'e' for epsilon:\n");
    for (int i = 0; i < trans; i++) {
        scanf("%d %d %c", &from, &to, &symbol);
        if (symbol == 'e') {
            epsilon[from][to] = 1;
        }
    }

    int start_state;
    printf("Enter the state to compute epsilon closure: ");
    scanf("%d", &start_state);

    // Clear closure array
    for (int i = 0; i < n; i++) closure[i] = 0;

    // Compute epsilon closure
    epsilon_closure(start_state);

    printf("Epsilon closure of state %d: { ", start_state);
    for (int i = 0; i < n; i++) {
        if (closure[i]) printf("%d ", i);
    }
    printf("}\n");

    return 0;
}
