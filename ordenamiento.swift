class BinaryTree {
  var number: Int
  var left: BinaryTree?
  var right: BinaryTree?

  init(number: Int) {
    self.number = number
    self.left = nil
    self.right = nil
  }
}

var tree: BinaryTree?


func callMenuTree() {
  var option = 0
  repeat{
    print("\n\nThe menu:\n\n ")
    print("1. add Tree")
    print("2. search Tree")
    print("3. delete Tree")
    print("4. show Tree")
    print("5. orde the Tree")
    print("6. exit")
    print("The option: ", terminator: "")
    if let input = readLine(), let number = Int(input) {
      option = number
    }
  } while option < 1 || option > 5

   switch option {
     case 1: addTree()
     case 2: search()
     case 3: deleteTree()
     case 4: showTree()
     case 5: ordenTree()
     case 6: break
     default: break
   }
}


func addTree() {
  var list: [Int] = []
  repeat {
    print("\nEnter the number for add or n for finish : ", terminator: "")
    guard let input = readLine() else {
      print("the input is error")
      continue
    }
    if let parsedNumber = Int(input) {
        list.append(parsedNumber)
    } else if input.lowercased() == "n" {
        print("\nFinished entering numbers.")
        break
    } else {
      print("Invalid input. please enter a valid number or 'n' to finish")
    }
  } while true
  
  for numb in list {
    insertNode(number: numb)
  }
  callMenuTree()
}
 

func insertNode(number: Int) {

  let newNode = BinaryTree(number: number)

  if tree == nil {
    tree = newNode
  } else {
    var current = tree
    var aux: BinaryTree?
    while let itera = current {
      aux = current
      if number < itera.number {
        current = itera.left
      } else {
        current = itera.right
      }
    }
  
    if number < aux!.number {
      aux?.left = newNode
    } else {
      aux?.right = newNode
    }
  }
}


func search() {
  print("\nEnter the number to search: ", terminator: "")
  if let input = readLine(), let number = Int(input) {
    searchNumber(number: number, remove: false)
  }
  callMenuTree()
}


func  searchNumber(number: Int, remove: Bool) {
  var aux = tree
  var round = 0
  var prev: BinaryTree?
  while let current = aux {
    if number == current.number {
      round += 1
      break
    } else {
      prev = current
    }
    if number < current.number {
      aux = current.left
    } else {
      aux = current.right
    }
    round += 1
  }
if aux == nil {
  print("The number \(number) is not in the tree")
} else {
  if !remove {
    print("the number \(number) is in the tree with \(round) rounds")
  } else {
    removeNodeTree(aux: aux, prev: prev)
  }
 }
} 


func showTree() {
  var option = 0
  repeat{
    print("\nThe option of Show:\n")
    print("1. Pre-order")
    print("2. In-order")
    print("3. Post-order")
    print("Enter the option: ", terminator: "")
    if let input = readLine(), let number = Int(input) {
      option = number
    }
    
  } while option < 1 || option > 3
  switch option {
    case 1: 
      print("\nThe list of Pre-order: ")
      preOrder(aux: tree)
    case 2: 
      print("\nThe list of In-order: ")
      inOrder(aux: tree)
    case 3:
      print("\nThe list of Post-order: ") 
      postOrder(aux: tree)
    default: break
  }
  callMenuTree()
}


func preOrder(aux: BinaryTree?) {
  if let currentNode  = aux {
    print(currentNode.number, terminator: " ")
    preOrder(aux: currentNode.left)
    preOrder(aux: currentNode.right)
    
  }
}


func inOrder(aux: BinaryTree?) {
  if let currentNode = aux {
    inOrder(aux: currentNode.left)
    print(currentNode.number, terminator: " ")
    inOrder(aux: currentNode.right)
  }
  
}


func postOrder(aux: BinaryTree?) {
  if let currentNode = aux {
    postOrder(aux: currentNode.left)
    postOrder(aux: currentNode.right) 
    print(currentNode.number, terminator: " ")
  }
  
}


func deleteTree() {
  print("\nEnter the number to delete: ", terminator: "")
  if let input = readLine(), let number = Int(input) {
    searchNumber(number: number, remove: true)
  }
  callMenuTree()
}


func removeNodeTree(aux: BinaryTree?, prev: BinaryTree?) {
  if let current = aux {
    removeNodeTree(aux: current.left, prev: current)
    removeNodeTree(aux: current.right, prev: current)
    print("\nDeleted Node: \(current.number)")
    if let previous = prev {
      if current.number < previous.number {
        previous.left = nil
      } else {
        previous.right = nil
      }
    }
    if current === tree {
      tree = nil
    }
  }
}

// agregado la funcion de ordenamiento de nodo

func insertOrdenTree(list: [Int]) {
    guard !list.isEmpty else {
        return
    }

    var lista = list

    let center = (lista.count - 1) / 2
    let low = center / 2
    let high = (center / 2) + center

    if lista.count == 3 {
        insertNode(number: lista[1])
        insertNode(number: lista[0])
        insertNode(number: lista[2])
        return
    }
    if lista.count == 1 {
        insertNode(number: lista[0])
        return
    }
    if lista.count > 2 {
      insertNode(number: lista[center])
      insertNode(number: lista[low])
      insertNode(number: lista[high])

      lista.remove(at: high)
      lista.remove(at: center)
      lista.remove(at: low)
    } else {
      insertNode(number: lista[center])
      lista.remove(at: center)

    }
    insertOrdenTree(list: lista)
}


func ordenTree() {
  print("\nthe tree in orden star.")
  let list = createList(aux: tree)
  insertOrdenTree(list: list)
  print("\nThe tree in orden finish.")
  callMenuTree()

}


func createList(aux: BinaryTree?) -> [Int] {

  var list:[Int] = []

  func inOrderReturn(aux: BinaryTree?)  {
  if let currentNode = aux {
    inOrderReturn(aux: currentNode.left)
    list.append(currentNode.number) 
    tree = nil
    inOrderReturn(aux: currentNode.right)
  }
 }
  inOrderReturn(aux: tree)

  return list
}

callMenuTree()