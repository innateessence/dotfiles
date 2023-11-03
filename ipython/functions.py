class ConfigWrappers:
    @staticmethod
    def vi():
        """Switch to vi editing mode"""
        _ = get_ipython().configurables[0]
        _.editing_mode = "vi"
        _.init_prompt_toolkit_cli()

    @staticmethod
    def emacs():
        """Switch to emacs editing mode"""
        _ = get_ipython().configurables[0]
        _.editing_mode = "emacs"
        _.init_prompt_toolkit_cli()


vi = lambda: ConfigWrappers.vi()
emacs = lambda: ConfigWrappers.emacs()
