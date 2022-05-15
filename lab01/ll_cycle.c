#include <stddef.h>
#include "ll_cycle.h"

int ll_has_cycle(node *head) {
    /* your code here */
    node *tortoise = head; // move in a step of one nodes
    node *hare = head; //move in a step of two nodes
    do { 
        if (!hare) {return 0;}
        hare = hare -> next;
	if (!hare) {return 0;}
	hare = hare -> next;
	tortoise = tortoise -> next;            
    } while (tortoise != hare);
    return 1;
}
