pragma Singleton
import Quickshell

Singleton {
  function truncate(text: string, maxLength: int): string {
    return text.length > maxLength ? text.slice(0, maxLength - 3) + "..." : text;
  }
}
