trigger CaseTrigger on Case (before insert) {
    trigger.New[0].Type = 'Mechanical';
}