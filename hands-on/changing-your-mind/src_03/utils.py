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
