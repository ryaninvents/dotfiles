# kakoune walkthrough

This document is intended to get you up and running with kakoune to the point where you can start doing some of your daily work in it. It references Vim since I imagine that most people in the "want to learn kakoune" bucket are also members of the "already use Vim" bucket. However, it doesn't assume any Vim experience and will fully explain everything.

## getting started

Make sure that you're running this tutorial on MacOS in iTerm2.

```bash
# Download ELECTRIFY.md, assumed download location will be in your `~/Downloads` folder
mkdir -p ~/.config/kak
mv ~/Downloads/ELECTRIFY.md ~/.config/kak/
cd ~/.config/kak
kak ELECTRIFY.md
```

This will open kakoune with this document in your editor.

## a note on keys

Here's how keys will be presented in this document:

- `I` means press the `I` key (no shift).
- `Shift+I` means press and hold Shift, then press `I`.
- `Ctrl+O` means hold Ctrl and press `O`.
- `Alt+I, P` means `Alt+I` followed by releasing both keys and then pressing `P`.

## modes

If you're already familiar with Vim, you might be familiar with its three main modes: normal, insert, and visual. Kakoune only has two modes: normal and insert. In Vim, visual mode allows you to select text. In kakoune, there is always at least one selection -- it's just that sometimes this selection is zero characters wide. It's a bit simpler of a model.

Insert mode behaves much as any "ordinary" text editor. Characters appear in the document as they are typed, and you can move around using the arrow keys.

Normal mode is where the magic happens. You can use the keyboard to move rapidly around the document and make changes.

## movement

Moving around the document in normal mode is the same as Vim:
- `h` moves 1 character left,
- `j` moves 1 line down,
- `k` moves 1 line up, and
- `l` moves 1 character to the right.

You can of course use the arrow keys, but try to avoid this as you're learning, since using the home row keys is more efficient. (The arrow keys also work in insert mode.)

You can also click the document to jump around if your terminal supports it.

If you're interested, you can also press `g` to get a helpful menu describing other movements. I'll describe some of these later in this document, but you can try them on your own if you'd prefer.

## splitting the view

Many tutorials want to teach editing commands first, but the goal of this tutorial is to get you up and running quickly, so I want to make sure that you are working on your `kakrc` file while you learn.

To do this, you'll want to open your `kakrc` side-by-side with this tutorial. Vim offers a `:vsp` command which does this, and the equivalent in kakoune is... uh...

Well this is awkward. It appears that [one of kakoune's principles](https://kakoune.org/why-kakoune/why-kakoune.html#:~:text=Kakoune%20also%20tries%20to%20limit%20its%20scope%20to%20code%20editing%3A%20in%20particular%2C%20it%20does%20not%20try%20to%20manage%20windows%2C%20and%20lets%20the%20system%E2%80%99s%20window%20manager%2C%20or%20terminal%20multiplexer%20(such%20as%20tmux)%2C%20handle%20that%20responsibility.) is to avoid handling anything external to its core functionality of code editing. This may seem like an odd limitation at first, but don't forget the joke about Emacs -- "a full-fledged operating system lacking only a decent editor". Luckily, the authors thought this through and made sure that kakoune integrates nicely with any windowing solution you want to use.

Remember when I told you to use iTerm2? Kakoune can automatically determine how to create a new pane within its current environment. Type `:new` to split the view. You should see this document on both halves of your terminal now. With default iTerm2 settings, you should be able to use `Cmd+]` to cycle to the next pane, and `Cmd+[` to cycle to the previous.

Cycle to the right-hand pane and type `:e ~/.config/kak/kakrc`. This should drop you into a new document. Kakoune, like Vim, uses `~` characters to show when it's rendering beyond the end of the document.

First of all, it would be nice to have word wrap enabled, at least temporarily. This will make reading this Markdown document much easier. We'll also add a helpful popup when you run commands to help you see what you just did.

Press I to enter insert mode and type the following:

```
# kakrc

# When in normal mode, add contextual help. Delete this line when you're comfortable!
set -add global autoinfo normal

# Soft-wrap long lines
add-highlighter global/ wrap -word -indent
```

When you're done, press `<ESC>` to switch back to normal mode, and `:w` to save.

Then, switch back to the pane with this document, type `:q<ENTER>` and then `kak ELECTRIFY.md`. This will reload your config. There are probably more sophisticated ways to reload the config, but kakoune loads pretty quick. I'll ask you to reload the config later in the document; this is the process I'm referring to.

## starting to customize with options

One of the easiest ways to irritate a developer is to be on the "wrong" side of the tabs-vs-spaces debate. To help you avoid this, we'll set this up next.

Add the following lines to your `kakrc`, customizing for your setup.

```
# Set width of a tab
set-option global tabstop 2

# Indent using 2 spaces. For the tab character, set this to 0.
set-option global indentwidth 2
```

Be sure to save after every change.

You'll notice that as you type, suggestions will pop up near the cursor. You might be used to using the arrow keys in your IDE to select these, or have it automatically apply when it reaches a "commit character" such as space or semicolon. To traverse the list in Kakoune, press `Ctrl+N` to move down and `Ctrl+P` to move up. Then, when the desired suggestion is selected, just keep typing -- it's already in the document. It's a little weird, but becomes second nature after a bit of use. Try it on the next option, which ensures that the cursor always has a margin around it before it reaches the end of the screen:

```
set-option global scrolloff 1,3
```

## adding highlighters

You can change how text is displayed in the window using highlighters. There are a few built in that we can leverage.

```
add-highlighter global/ number-lines -hlcursor
```

In fact, you may have noticed that we're already using a highlighter to wrap the text. In order to clean up our file, we should move these two lines to be close to one another. We'll have to select the line, yank it, and paste it to its new location.

In normal mode, use the `hjkl` keys to move to the `add-highlighter global/ wrap -word -indent` line, and press `X` to highlight the line, `Y` to yank it to the default register, and `D` to remove it from its old position. Then, use `hjkl` to move below the remaining `add-highlighter` line and press `P`. The file should look a bit tidier now!

## references

- https://kakoune-editor.github.io/community-articles/2021/01/01/first_two_hours_in_two_minutes.html
- https://github.com/mawww/kakoune/wiki, especially ["Use kakoune as an IDE"](https://github.com/mawww/kakoune/wiki/IDE)
- https://www.hamvocke.com/blog/a-guide-to-customizing-your-tmux-conf/
