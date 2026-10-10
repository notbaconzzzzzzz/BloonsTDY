
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

function SortedLinkedList() : LinkedList() constructor
{
	static Append = function (_obj, _score, combine = false)
	{
		return AppendExisting(new SortedLinkedListNode(_obj, _score), combine);
	}
	
	static AppendExisting = function(linkedlistnode, combine = false)
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
			while (!is_instanceof(searchNode, LinkedList) && s > searchNode.s)
			{
				searchNode = searchNode.r;
			}
			if (combine && !is_instanceof(searchNode, LinkedList) && searchNode.s == s)
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
			while (!is_instanceof(searchNode, LinkedList) && s < searchNode.s)
			{
				searchNode = searchNode.l;
			}
			if (combine && !is_instanceof(searchNode, LinkedList) && searchNode.s == s)
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
	
	static Merge = function(sortedlinkedlist, combine = false)
	{
		if (l == -1 || l == self)
		{
			sortedlinkedlist.l.r = self;
			l = sortedlinkedlist.l;
			sortedlinkedlist.r.l = self;
			r = sortedlinkedlist.r;
			return self;
		}
		return self;
	}
}

function SortedLinkedListNode(_obj, _score) constructor
{
	obj = _obj;
	s = _score;
	l = -1;
	r = -1;
	
	static SetScore = function(_score)
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
				l = r.l;
				l.r = self;
				r.l = self;
			}
		}
	}
}