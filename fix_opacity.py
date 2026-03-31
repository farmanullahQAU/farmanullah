import os
import re

def fix_with_opacity(directory):
    pattern = re.compile(r'\.withOpacity\(([^)]+)\)')
    replacement = r'.withValues(alpha: \1)'
    
    for root, _, files in os.walk(directory):
        for file in files:
            if file.endswith('.dart'):
                filepath = os.path.join(root, file)
                with open(filepath, 'r', encoding='utf-8') as f:
                    content = f.read()
                
                new_content = pattern.sub(replacement, content)
                
                if new_content != content:
                    with open(filepath, 'w', encoding='utf-8') as f:
                        f.write(new_content)
                    print(f"Fixed {filepath}")

if __name__ == "__main__":
    fix_with_opacity('/home/farman/flutterProjects/farmanullah/lib')
