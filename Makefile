.PHONY: all
all: git asdf nvim tmux bin zsh starship

.PHONY: git
git: 
	ln -snfv ${PWD}/gitconfig ${HOME}/.gitconfig

.PHONY: asdf
asdf:
	ln -snfv ${PWD}/tool-versions ${HOME}/.tool-versions
	git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.1
	. ${HOME}/.asdf/asdf.sh
	asdf install

.PHONY: nvim
nvim:
	mkdir -p ${HOME}/.config
	ln -snfv ${PWD}/nvim ${HOME}/.config/

.PHONY: tmux
tmux:
	ln -snfv ${PWD}/tmux.conf ${HOME}/.tmux.conf

.PHONY: bin
bin:
	ln -snfv ${PWD}/bin ${HOME}/.bin

.PHONY: zsh
zsh:
	ln -snfv ${PWD}/zsh ${HOME}/.zsh
	ln -snfv ${PWD}/zshrc ${HOME}/.zshrc
	ln -snfv ${PWD}/zshenv ${HOME}/.zshenv

.PHONY: starship
starship:
	mkdir -p ${HOME}/.config
	ln -snfv ${PWD}/starship.toml ${HOME}/.config/
