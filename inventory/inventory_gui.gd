extends Control

signal opened
signal closed

@onready var inventory : Inventory = preload("res://inventory/playerInventory.tres")
@onready var slots : Array = $NinePatchRect/GridContainer.get_children()
@onready var ItemStackGuiClass = preload("res://gui/itemStackGui.tscn")

var isOpen : bool = false

func _ready():
	connnectSlots()
	inventory.updated.connect(update)
	update()

func connnectSlots():
	for slot in slots:
		var callable = Callable(onSlotClicked)
		callable = callable.bind(slot)
		slot.pressed.connect(callable)

func update():
	for i in range(min(inventory.slots.size(), slots.size())):
		var inventorySlot : InventorySlot = inventory.slots[i]
		
		if !inventorySlot.item : continue
		
		var itemStackGui = slots[i].itemStackGui
		if !itemStackGui:
			itemStackGui = ItemStackGuiClass.instantiate()
			slots[i].insert(itemStackGui)
		itemStackGui.inventorySlot = inventorySlot
		itemStackGui.update()

func open():
	visible = true
	isOpen = true
	opened.emit()

func close():
	visible = false
	isOpen = false
	closed.emit()

func onSlotClicked(slot):
	pass
	
