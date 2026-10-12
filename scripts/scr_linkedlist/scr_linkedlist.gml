
function LinkedList() constructor
{
	l = self; // It should be noted that in the main LinkedList parent, l refers to the rightmost node
	r = self; // And r refers to the leftmost node, because the LinkedList wraps around the outside
	
	static Append = function(_obj, tostart = false)
	{
		return AppendExisting(new LinkedListNode(_obj), tostart);
	}
	
	static AppendExisting = function(linkedlistnode, tostart = false)
	{
		if (tostart)
		{
			linkedlistnode.r = r;
			r.l = linkedlistnode;
			linkedlistnode.l = self;
			r = linkedlistnode;
		}
		else
		{
			linkedlistnode.l = l;
			l.r = linkedlistnode;
			linkedlistnode.r = self;
			l = linkedlistnode;
		}
		return linkedlistnode;
	}
	
	static Clear = function()
	{
		l.r = r;
		r.l = l;
		l = self;
		r = self;
	}
}

function LinkedListNode(_obj) constructor
{
	obj = _obj;
	l = -1;
	r = -1;
	
	static Migrate = function(linkedlist = -1)
	{
		if (l != -1) l.r = r;
		if (r != -1) r.l = l;
		l = -1;
		r = -1;
		if (linkedlist != -1) linkedlist.AppendExisting(self);
	}
}

function SortedLinkedList(combineMode = false) : LinkedList() constructor
{
	combine = combineMode;
	
	static Append = function (_obj, _score)
	{
		return AppendExisting(new SortedLinkedListNode(_obj, _score));
	}
	
	static AppendExisting = function(linkedlistnode)
	{
		if (l == -1 || l == self)
		{
			linkedlistnode.r = self;
			l = linkedlistnode;
			linkedlistnode.l = self;
			r = linkedlistnode;
			return linkedlistnode;
		}
		var searchDirection = true;
		var searchNode = r;
		if (abs(linkedlistnode.s - l.s) < abs(linkedlistnode.s - searchNode.s))
		{
			searchNode = l;
			searchDirection = false;
		}
		if (searchDirection)
		{
			while (!is_instanceof(searchNode, LinkedList) && linkedlistnode.s > searchNode.s)
			{
				searchNode = searchNode.r;
			}
			if (combine && !is_instanceof(searchNode, LinkedList) && searchNode.s == linkedlistnode.s)
			{
				searchNode.obj.Combine(linkedlistnode.obj);
				return searchNode;
			}
			linkedlistnode.l = searchNode.l;
			searchNode.l.r = linkedlistnode;
			linkedlistnode.r = searchNode;
			searchNode.l = linkedlistnode;
		}
		else
		{
			while (!is_instanceof(searchNode, LinkedList) && linkedlistnode.s < searchNode.s)
			{
				searchNode = searchNode.l;
			}
			if (combine && !is_instanceof(searchNode, LinkedList) && searchNode.s == linkedlistnode.s)
			{
				searchNode.obj.Combine(linkedlistnode.obj);
				return searchNode;
			}
			linkedlistnode.r = searchNode.r;
			searchNode.r.l = linkedlistnode;
			linkedlistnode.l = searchNode;
			searchNode.r = linkedlistnode;
		}
		return linkedlistnode;
	}
	
	static FindOrCreate = function(_score, defaultValue)
	{
		var linkedlistnode; 
		if (l == -1 || l == self)
		{
			linkedlistnode = new SortedLinkedListNode(defaultValue, _score); 
			linkedlistnode.r = self;
			l = linkedlistnode;
			linkedlistnode.l = self;
			r = linkedlistnode;
			return linkedlistnode;
		}
		var searchDirection = true;
		var searchNode = r;
		if (abs(_score - l.s) < abs(_score - searchNode.s))
		{
			searchNode = l;
			searchDirection = false;
		}
		if (searchDirection)
		{
			while (!is_instanceof(searchNode, LinkedList) && _score > searchNode.s)
			{
				searchNode = searchNode.r;
			}
			if (!is_instanceof(searchNode, LinkedList) && searchNode.s == _score)
			{
				return searchNode;
			}
			linkedlistnode = new SortedLinkedListNode(defaultValue, _score); 
			linkedlistnode.l = searchNode.l;
			searchNode.l.r = linkedlistnode;
			linkedlistnode.r = searchNode;
			searchNode.l = linkedlistnode;
		}
		else
		{
			while (!is_instanceof(searchNode, LinkedList) && _score < searchNode.s)
			{
				searchNode = searchNode.l;
			}
			if (!is_instanceof(searchNode, LinkedList) && searchNode.s == _score)
			{
				return searchNode;
			}
			linkedlistnode = new SortedLinkedListNode(defaultValue, _score); 
			linkedlistnode.r = searchNode.r;
			searchNode.r.l = linkedlistnode;
			linkedlistnode.l = searchNode;
			searchNode.r = linkedlistnode;
		}
		return linkedlistnode;
	}
	
	static Merge = function(sortedlinkedlist)
	{
		if (l == -1 || l == self)
		{
			sortedlinkedlist.l.r = self;
			l = sortedlinkedlist.l;
			sortedlinkedlist.r.l = self;
			r = sortedlinkedlist.r;
			return self;
		}
		var node1 = r;
		var node2 = sortedlinkedlist.r;
		while (true)
		{
			if (node1.s > node2.s)
			{
				node1.l.r = node2;
				node2.l = node1.l.r;
				node1.l = node2;
				node2 = node2.r;
				node1.l.r = node1;
			}
			else if (combine && node1.s == node2.s)
			{
				node1.obj.Combine(node2.obj);
				node2 = node2.r;
			}
			else
			{
				node1 = node1.r;
			}
			if (is_instanceof(node2, LinkedList))
			{
				break;
			}
			if (is_instanceof(node1, LinkedList))
			{
				node2.l = l;
				node2.l.r = node2;
				l = sortedlinkedlist.l;
				l.r = self;
				break;
			}
		}
		return self;
	}
}

function SortedLinkedListNode(_obj, _score) : LinkedListNode(_obj) constructor
{
	s = _score;
	
	static SetScore = function(_score, combine = false)
	{
		if (_score < s)
		{
			s = _score;
			if (!is_instanceof(l, LinkedList) && l.s > s)
			{
				l.r = r;
				r.l = l;
				l = l.l;
				while (!is_instanceof(l, LinkedList) && l.s > s)
				{
					l = l.l;
				}
				if (combine && !is_instanceof(l, LinkedList) && l.s == s)
				{
					l.obj.Combine(obj);
					return l;
				}
				r = l.r;
				l.r = self;
				r.l = self;
			}
		}
		else
		{
			s = _score;
			if (!is_instanceof(r, LinkedList) && r.s < s)
			{
				l.r = r;
				r.l = l;
				r = r.r;
				while (!is_instanceof(r, LinkedList) && r.s < s)
				{
					r = r.r;
				}
				if (combine && !is_instanceof(r, LinkedList) && r.s == s)
				{
					r.obj.Combine(obj);
					return r;
				}
				l = r.l;
				l.r = self;
				r.l = self;
			}
		}
		return self;
	}
}