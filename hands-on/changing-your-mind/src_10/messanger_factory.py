def say_something(msg: str, name: str) -> str:
    '''
    Returns a formatted string with the given message and name.
    
    Args:
        msg (str): The message to include.
        name (str): The name to include in the message.
    
    Returns:
        str: A formatted string combining the message and name.
    '''
    return f'{msg} {name}'

def create_messenger(msg: str) -> callable:
    '''
    Creates a messenger function that uses the given message.
    
    Args:
        msg (str): The message to use in the messenger function.
    
    Returns:
        callable: A function that takes a name and returns a formatted message.
    '''
    @functools.wraps(say_something)
    def messanger(name: str) -> str:
        return say_something(msg, name)
    
    return messanger
