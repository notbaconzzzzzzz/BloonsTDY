
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
	static Add = function (_obj, _score)
	{
		
	}
	
	static AddExisting = function(linkedlistnode)
	{
		return linkedlistnode;
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
			if (!is_instanceof(l, LinkedList) && l.score > s)
			{
				l.r = r;
				r.l = l;
				l = l.l;
				while (!is_instanceof(l, LinkedList) && l.score > s)
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
			if (!is_instanceof(r, LinkedList) && r.score < s)
			{
				l.r = r;
				r.l = l;
				r = r.r;
				while (!is_instanceof(r, LinkedList) && r.score < s)
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